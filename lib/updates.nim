import os, puppy, strutils, distros,
    strformat, zippy/ziparchives

proc u*(v: string): void =
  let cv = fetch("https://raw.githubusercontent.com/Infinitybeond1/dye/main/dye.nimble").splitLines(
    )[0].split("=")[1].strip().replace("\"", "")
  if v.replace(".", "").strip().parseInt() < cv.replace(".", "").strip().parseInt():
    stdout.write("Updates are availible, would you like to update (Y/n): ")
    let a = readLine(stdin).toLower()
    if a == "n":
      echo "Exiting..."
      quit(0)
    let app = getAppFilename()
    echo "Detecting os..."
    var os: string
    if detectOs(Windows):
      echo "This feature isnt supported on windows"
    elif detectOs(Linux):
      os = "linux"
    elif detectOs(MacOSX):
      os = "darwin"
    else:
      quit 1
    echo "Downloading file..."
    writeFile(getTempDir() / fmt"dye-{os}.zip", fetch(fmt"https://github.com/Infinitybeond1/dye/releases/download/v{cv.strip()}/dye-{os}.zip"))
    while true:
      if fileExists(getTempDir() / fmt"dye-{os}.zip"):
        break
    let file = getTempDir() / fmt"dye-{os}.zip"
    echo "Extracting..."
    extractAll(file, getTempDir() / "dye")
    removeFile(file)
    echo "Moving file..."
    removeFile(app)
    copyFileWithPermissions(getTempDir() / "dye" / "dye", app)
    removeDir(getTempDir() / "dye")
    echo "Completed!"
  elif v.replace(".", "").strip().parseInt() == cv.replace(".", "").strip().parseInt():
    echo "You're all up to date"
  else:
    echo "Your version: $#\nCurrent version: $#" % @[v, cv]

