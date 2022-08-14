import os, harpoon, uri, strutils, asyncdispatch, distros, strformat, osproc,
    zippy/ziparchives

proc u*(v: string): void =
  let cv = getContent(parseUri "https://raw.githubusercontent.com/Infinitybeond1/dye/main/dye.nimble").splitLines()[
      0].split("=")[1].strip().replace("\"", "")
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
    #downloadFile(parseUri(fmt"https://github.com/Infinitybeond1/dye/releases/download/v{cv.strip()}/dye-{os}.zip"), fmt"dye-{os}.zip")
    let d = execShellCmd(fmt"wget https://github.com/Infinitybeond1/dye/releases/download/v{cv.strip()}/dye-{os}.zip")
    if d == 1:
      echo "File was not downloaded successfully"
      quit 1
    echo "Extracting..."
    extractAll(fmt"dye-{os}.zip", "tmp")
    removeFile("dye-{os}.zip")
    echo "Moving file..."
    removeFile(app)
    moveFile("tmp/dye", app)
    removeDir("tmp")
    echo "Completed!"
  elif v.replace(".", "").strip().parseInt() == cv.replace(".", "").strip().parseInt():
    echo "You're all up to date"
  else:
    echo "Your version: $#\nCurrent version: $#" % @[v, cv]

proc tu*(v: string): void =
  let cv = getContent(parseUri "https://raw.githubusercontent.com/Infinitybeond1/dye/master/version.txt")
  #echo  cv
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
    quit 1
  elif detectOs(Linux):
    os = "linux"
  elif detectOs(MacOSX):
    os = "darwin"
  else:
    quit 1
  echo "Downloading file..."
  #downloadFile(parseUri(fmt"https://github.com/Infinitybeond1/dye/releases/download/v{cv.strip()}/dye-{os}.zip"), fmt"dye-{os}.zip")
  let d = execShellCmd(fmt"wget https://github.com/Infinitybeond1/dye/releases/download/v{cv.strip()}/dye-{os}.zip")
  if d == 1:
    echo "File was not downloaded successfully"
    quit 1
  echo "Extracting..."
  extractAll(fmt"dye-{os}.zip", "tmp")
  removeFile("dye-{os}.zip")
  echo "Moving file..."
  removeFile(app)
  moveFile("tmp/dye", app)
  removeDir("tmp")
  echo "Completed!"

