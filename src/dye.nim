# Most of the comments in the code are echo statements for debug purposes.
import os,
       chroma,
       pixie,
       strutils,
       progress,
       terminal,
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 025954b (feat: update command for macos and linux)
       strformat

include ../lib/args

import ../lib/[colors, palettes]
<<<<<<< HEAD
=======
=======
       strformat,
       asyncdispatch

include ../lib/args

import ../lib/[colors, palettes, updates]
>>>>>>> 45263dd (feat: update command for macos and linux)
>>>>>>> 025954b (feat: update command for macos and linux)

var
  flipName: string
  convName: string
  lumaName: string

var outfile: string
var fileDir: string

if args.flip.seen:
  outfile = flip.output.value
  fileDir = flip.file.value 
elif args.luma.seen:
  outfile = luma.output.value
  fileDir = luma.file.value
else:
  outfile = args.output.value
  fileDir = args.file.value

proc fileName(file: string): void =
  if outfile != "null":
    flipName = outfile & ".png"
    convName = outfile & ".png"
    lumaName = outfile & ".png"
  else:
    flipName = "flip-" & getFilename(file) & ".png"
    convName = "conv-" & getFilename(file) & ".png"
    lumaName = "luma-" & getFilename(file) & ".png"

var files: seq[string]
if dirExists(fileDir):
  for file in walkDir(fileDir):
    files.add(file.path)
else:
  files.add(fileDir)

proc flipCol(imgPath: string, bar: bool): void =
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
    newImg.save(flipName)
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
    newImg.save(flipName)

proc lumaCol(imgPath: string, bar: bool): void =
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
    newImg.save(lumaName)
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
    newImg.save(lumaName)

proc col(imgPath: string, bar: bool, colors: seq[string]): void =
  stdout.styledWriteLine(fgYellow, "Converting: ", fgWhite, splitFile(
      imgPath).name & splitFile(imgPath).ext & " ...")
  fileName(imgPath)
  if bar:
    var imageFile = readImage(imgPath)
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

    newImg.save(convName)
    bar.finish()
    stdout.styledWriteLine(fgGreen, "Completed: ", fgWhite, splitFile(
        imgPath).name & splitFile(imgPath).ext & "\n")
  else:
    var imageFile = readImage(imgPath)
    let h = imageFile.height
    let w = imageFile.width
    let colorsRGB = colors.prepareClosestColor()
    var newImg = copy(imageFile)
    for y in 1..h:
      for x in 1..w:
        newImg.setColor(x = x, y = y, color = getClosestColor(
            colorsRGB, newImg.getColor(x, y)))

    newImg.save(convName)
    stdout.styledWriteLine(fgGreen, "Completed: ", fgWhite, splitFile(
        imgPath).name & splitFile(imgPath).ext & "\n")

if args.flip.seen:
  for img in files:
    try:
      flipCol(img, flip.bar.seen)
    except:
      stdout.styledWriteLine(fgRed, "Error: ", fgWhite, getCurrentExceptionMsg())
      continue
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
elif args.update.seen:
  u(versionNum)
>>>>>>> 45263dd (feat: update command for macos and linux)
>>>>>>> 025954b (feat: update command for macos and linux)
elif args.luma.seen:
  for img in files:
    try:
      lumaCol(img, luma.bar.seen)
    except:
      stdout.styledWriteLine(fgRed, "Error: ", fgWhite, getCurrentExceptionMsg())
      continue
elif args.list.seen:
  for k, v in pal.fieldPairs:
    discard v
    echo k
else:
  var cols: seq[string]
  if "," in args.palette.value:
    cols = args.palette.value.parseColors()
  elif fileExists(args.palette.value):
    cols = readFile(args.palette.value).parseColors()
  else:
    for k, v in pal.fieldPairs:
      if args.palette.value == k:
        cols = v
        break
    cols = cols.rmTag()
  for img in files:
    try:
      col(img, args.bar.seen, cols)
    except:
      stdout.styledWriteLine(fgRed, "Error: ", fgWhite, getCurrentExceptionMsg())
      continue
