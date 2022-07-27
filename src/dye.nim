# Most of the comments in the code are echo statements for debug purposes.
import os,
       chroma,
       pixie,
       strutils,
       progress,
       terminal,
       commandeer,
       strformat

const version = staticRead(fmt"../dye.nimble").splitLines()[0].split("=")[1]
  .strip().replace("\"", "")

commandline:
  arguments dyefile, string
  option dyebar, bool, "bar", "b"
  option dyeoutfile, string, "out", "o", "null"
  option palette, string, "palette", "p"
  exitoption "v", "version", "dye v" & version
  subcommand flip, "flip", "f":
    arguments flipfile, string
    option flipoutfile, string, "out", "o", "null"
    option flipbar, bool, "bar", "b"
  subcommand luma, "luma", "l":
    arguments lumafile, string
    option lumaoutfile, string, "out", "o", "null"
    option lumabar, bool, "bar", "b"
  subcommand helpcmd, "help", "h":
    option command, string, "command", "c", "null"
  subcommand list, "list", "l":
    option x, bool, "X", "x", false # This doesnt actually do anything.

discard x

import ../lib/[colors, palettes, help]

if helpcmd:
  if command != "null":
    for k,v in helps.fieldPairs:
      if k == command:
        echo v 
        quit 0
    stdout.styledWriteLine(fgRed, "Error: ", fgWhite, "Unknown command: " & command)
    quit 0
  else:
    echo helps.all
    quit 0

var outfile: string
var bar: bool

if flip:
  outfile = flipoutfile
  bar = flipbar
elif luma:
  outfile = lumaoutfile
  bar = lumabar
else:
  outfile = dyeoutfile
  bar = dyebar

var
  flipName: string
  convName: string
  lumaName: string

proc fileName(file: string): void =
  if outfile != "null":
    flipName = outfile & ".png"
    convName = outfile & ".png"
    lumaName = outfile & ".png"
  else:
    flipName = "flip-" & getFilename(file) & ".png"
    convName = "conv-" & getFilename(file) & ".png"
    lumaName = "luma-" & getFilename(file) & ".png"

var imgs: seq[string]

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

    if fileExists(convName):
      removeFile(convName)
    newImg.writeFile(convName)
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

    if fileExists(convName):
      removeFile(convName)
    newImg.writeFile(convName)
    stdout.styledWriteLine(fgGreen, "Completed: ", fgWhite, splitFile(
        imgPath).name & splitFile(imgPath).ext & "\n")

if flip:
  for img in flipfile:
    try:
      flipCol(img, bar)
    except:
      stdout.styledWriteLine(fgRed, "Error: ", fgWhite, getCurrentExceptionMsg())
      continue
elif luma:
  for img in lumafile:
    try:
      lumaCol(img, bar)
    except:
      stdout.styledWriteLine(fgRed, "Error: ", fgWhite, getCurrentExceptionMsg())
      continue
elif list:
  for k,v in pal.fieldPairs:
    discard v
    echo k
else:
  var cols: seq[string]
  if "," in palette:
    cols = palette.split(",").rmTag()
  elif fileExists(palette):
    cols = readFile(palette).split(",").rmTag()
  else:
    for k, v in pal.fieldPairs:
      if palette == k:
        cols = v
        break
    cols = cols.rmTag()
  for img in dyefile:
    try:
      col(img, bar, cols)
    except:
      stdout.styledWriteLine(fgRed, "Error: ", fgWhite, getCurrentExceptionMsg())
      continue
