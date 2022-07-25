# Most of the comments in the code are echo statements for debug purposes.
import os,
       chroma,
       pixie,
       strutils,
       progress,
       terminal

import ../lib/[
               opts,
               colors,
               palettes
  ]

if $args["<file>"] == "flip":
  echo "Usage: dye flip <file>"
  quit 1

var
  flipName: string
  convName: string
  lumaName: string

var paletteDir: string

paletteDir = getConfigDir() / "dye/palettes"

proc fileName(file: string): void =
  if $args["--output"] != "nil":
    flipName = $args["--output"] & ".png"
    convName = $args["--output"] & ".png"
    lumaName = $args["--output"] & ".png"
  else:
    flipName = "flip-" & getFilename(file) & ".png"
    convName = "conv-" & getFilename(file) & ".png"
    lumaName = "luma-" & getFilename(file) & ".png"

var imgs: seq[string]

if dirExists(strip($args["<file>"])):
  imgs = @[]
  for file in walkDirRec($args["<file>"]):
    if ".png" in $file or ".jpg" in $file or ".jpeg" in $file:
      imgs.add(strip(file))
  #echo imgs
  #echo execCmdEx("ls -m " & $args["<file>"])[0].split(", ")
else:
  imgs = @[$args["<file>"]]
  #echo imgs

proc flip(imgPath: string, bar: bool): void =
  stdout.styledWriteLine(fgYellow, "Converting: ", fgWhite, splitFile(
      imgPath).name & splitFile(imgPath).ext & " ...")
  if bar:
    var imageFile = readImage(imgPath)
    var newImg = copy(imageFile)
    var bar = newProgressBar(total = imageFile.width * imageFile.height)
    bar.start()
    for y in 1..newImg.height:
      for x in 1..newImg.width:
        var rgbx = newImg.getColor(x, y).rgbx()
        rgbx.r = 255 - rgbx.r
        rgbx.g = 255 - rgbx.g
        rgbx.b = 255 - rgbx.b
        newImg.setColor(x, y, rgbx.color)
        bar.increment()
    bar.finish()
    stdout.styledWriteLine(fgGreen, "Completed: ", fgWhite, splitFile(
        imgPath).name & splitFile(imgPath).ext & "\n")
    fileName(imgPath)
    if fileExists(flipName):
      removeFile(flipName)
    newImg.writeFile(flipName)
  else:
    var imageFile = readImage(imgPath)
    var newImg = copy(imageFile)
    for y in 1..newImg.height:
      for x in 1..newImg.width:
        var rgbx = newImg.getColor(x, y).rgbx()
        rgbx.r = 255 - rgbx.r
        rgbx.g = 255 - rgbx.g
        rgbx.b = 255 - rgbx.b
        newImg.setColor(x, y, rgbx.color)
    stdout.styledWriteLine(fgGreen, "Completed: ", fgWhite, splitFile(
        imgPath).name & splitFile(imgPath).ext & "\n")
    fileName(imgPath)
    if fileExists(flipName):
      removeFile(flipName)
    newImg.writeFile(flipName)

proc luma(imgPath: string, bar: bool): void =
  stdout.styledWriteLine(fgYellow, "Converting: ", fgWhite, splitFile(
      imgPath).name & splitFile(imgPath).ext & " ...")
  if bar:
    var imageFile = readImage(imgPath)
    var newImg = copy(imageFile)
    var bar = newProgressBar(total = imageFile.width * imageFile.height)
    bar.start()
    for y in 1..newImg.height:
      for x in 1..newImg.width:
        #echo 1 - hsl(newImg.getColor(x, y)).l / 100
        newImg.setColor(x, y, newImg.getColor(x, y).invertLuma())
        #echo -(newImg.getColor(x, y).hsl().l / 100)
        bar.increment()
    bar.finish()
    stdout.styledWriteLine(fgGreen, "Completed: ", fgWhite, splitFile(
        imgPath).name & splitFile(imgPath).ext & "\n")
    fileName(imgPath)
    if fileExists(lumaName):
      removeFile(lumaName)
    newImg.writeFile(lumaName)
  else:
    var imageFile = readImage(imgPath)
    var newImg = copy(imageFile)
    for y in 1..newImg.height:
      for x in 1..newImg.width:
        #echo 1 - hsl(newImg.getColor(x, y)).l / 100
        newImg.setColor(x, y, newImg.getColor(x, y).invertLuma())
        #echo -(newImg.getColor(x, y).hsl().l / 100)
    stdout.styledWriteLine(fgGreen, "Completed: ", fgWhite, splitFile(
        imgPath).name & splitFile(imgPath).ext & "\n")
    fileName(imgPath)
    if fileExists(lumaName):
      removeFile(lumaName)
    newImg.writeFile(lumaName)

proc col(imgPath: string, bar: bool): void =
  stdout.styledWriteLine(fgYellow, "Converting: ", fgWhite, splitFile(
      imgPath).name & splitFile(imgPath).ext & " ...")
  fileName(imgPath)
  if bar:
    var imageFile = readImage(imgPath)
    var colors: seq[string]
    if $args["--colors"] == "nil" and $args["--colorfile"] == "nil":
      stderr.writeLine("Please specify either a csv file with hex colors or a list of comma separated hex colors")
      quit 1
    elif $args["--colors"] != "nil":
      var colorSplit = strip($args["--colors"]).split(",")
      colors = @[]
      for color in colorSplit:
        if "#" in color:
          colors.add color.replace("#", "").strip()
        else:
          colors.add(color.strip())
    elif $args["--colorfile"] != "nil":
      var colorFile: seq[string]
      try:
        colorFile = readFile($args["--colorfile"]).strip().split(",")
      except:
        var a = $args["--colorfile"]
        for k, v in pal.fieldPairs:
          if a == k:
            colorFile = v
            break
      #echo colorFile
      colors = @[]
      for color in colorFile:
        if "#" in color.strip:
          colors.add color.replace("#", "").strip()
        else:
          colors.add(color.strip())
      #echo colors

    let h = imageFile.height
    let w = imageFile.width
    let colorsRGB = colors.prepareClosestColor()
    var newImg = copy(imageFile)
    var bar = newProgressBar(total = h)
    bar.start()
    for y in 1..h:
      for x in 1..w:
        newImg.setColor(x = x, y = y, color = getClosestColor(colorsRGB,
            newImg.getColor(x, y)))
      bar.increment()

    if fileExists(convName):
      removeFile(convName)
    newImg.writeFile(convName)
    bar.finish()
    stdout.styledWriteLine(fgGreen, "Completed: ", fgWhite, splitFile(
        imgPath).name & splitFile(imgPath).ext & "\n")
  else:
    var imageFile = readImage(imgPath)
    var colors: seq[string]
    if $args["--colors"] == "nil" and $args["--colorfile"] == "nil":
      stderr.writeLine("Please specify either a csv file with hex colors or a list of comma separated hex colors")
      quit 1
    elif $args["--colors"] != "nil":
      var colorSplit = strip($args["--colors"]).split(",")
      colors = @[]
      for color in colorSplit:
        if "#" in color:
          colors.add color.replace("#", "").strip()
        else:
          colors.add(color.strip())
    elif $args["--colorfile"] != "nil":
      var colorFile: seq[string]
      try:
        colorFile = readFile($args["--colorfile"]).strip().split(",")
      except:
        var a = $args["--colorfile"]
        for k, v in pal.fieldPairs:
          if a == k:
            colorFile = v
            break
      colors = @[]
      for color in colorFile:
        if "#" in color.strip:
          colors.add color.replace("#", "").strip()
        else:
          colors.add(color.strip())

    let h = imageFile.height
    let w = imageFile.width
    let colorsRGB = colors.prepareClosestColor()
    var newImg = copy(imageFile)
    for y in 1..h:
      for x in 1..w:
        newImg.setColor(x = x, y = y, color = getClosestColor(
            colorsRGB, newImg.getColor(x, y)))

    if fileExists(convName):
      removeFile(convName)
    newImg.writeFile(convName)
    stdout.styledWriteLine(fgGreen, "Completed: ", fgWhite, splitFile(
        imgPath).name & splitFile(imgPath).ext & "\n")

if args["flip"]:
  for img in imgs:
    try:
      flip(img, args["--bar"])
    except:
      stdout.styledWriteLine(fgRed, "Error: ", fgWhite, getCurrentExceptionMsg())
      continue
elif args["luma"]:
  for img in imgs:
    try:
      luma(img, args["--bar"])
    except:
      stdout.styledWriteLine(fgRed, "Error: ", fgWhite, getCurrentExceptionMsg())
      continue
elif args["list"]:
  for k,v in pal.fieldPairs:
    discard v
    echo k
else:
  for img in imgs:
    try:
      col(img, args["--bar"])
    except:
      stdout.styledWriteLine(fgRed, "Error: ", fgWhite, getCurrentExceptionMsg())
      continue
