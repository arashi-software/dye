import chroma,
       strutils,
       os,
       math,
       pixie,
       terminal,
       parseutils

proc parseColor(colors: seq[string]): seq[Color] =
  var res: seq[Color] = @[]
  for color in colors:
    res.add(parseHex(color))
  res

# proc prepareClosestColor*(colors: seq[string]): seq[ColorLAB] =
#   for color in colors:
#     result.add parseHex(color).to(ColorLAB)
#
# proc getClosestColor*(colors: seq[ColorLAB], old: Color): Color =
#   var
#     minDiff = 255
#     minDiffColor: ColorLAB
#     oldLab = old.to(ColorLab)
#   for color in colors:
#     let diff = oldLab.distance(color).int
#     if minDiff > diff:
#       minDiff = diff
#       minDiffColor = color
#   minDiffColor.to(Color)

# Mimic the go function
proc getClosestColor*(colors: seq[ColorRGB], old: Color): Color =
  var
    r: int
    g: int
    b: int
    r2: int
    g2: int
    b2: int
    oldcol: ColorRGB
    res: Color
    minDiff: float64 = 999.0 ^ 2
    distance: float64
  for color in colors:
    r = color.r.int()
    g = color.g.int()
    b = color.b.int()
    oldcol = old.to(ColorRGB)
    r2 = oldcol.r.int()
    g2 = oldcol.g.int()
    b2 = oldcol.b.int()
    distance = ((r2 - r)^2 + (g2 - g)^2 + (b2 - b)^2).float64
    if minDiff > distance:
      minDiff = distance
      res = color.to(Color)
  res

proc prepareClosestColor*(colors: seq[string]): seq[ColorRGB] =
  var res: seq[ColorRGB] = @[]
  for color in colors:
    res.add(parseHex(color).to(ColorRGB))
  res

proc getFilename*(file: string): string =
  extractFilename(file).split(".")[0]

proc invertLuma*(color: Color): Color =
  var hsl = color.hsl()
  hsl.l = 100 - hsl.l
  result = color(hsl)

proc colorMatch*(seq: seq[string], color: Color): bool =
  for s in seq:
    if color == s.parseHex():
      return true

proc fsDither*(oldpixel: Color, newpixel: Color, x, y: int): void =
  ## This function implements Floyd-Steinberg dithering.
  var oldp = oldpixel.to(ColorRGB)
  var newp = newpixel.to(ColorRGB)
  let quantError = @[
    (newp.r - oldp.r).int,
    (newp.g - oldp.g).int,
    (newp.b - oldp.b).int
  ]

proc checkFileOrDir*(file: string): seq[string] =
  if dirExists(file):
    result = @[]
    for Lfile in walkDirRec(file):
      if ".png" in $Lfile or ".jpg" in $Lfile or ".jpeg" in $Lfile:
        result.add(strip(Lfile))
  else:
    if not fileExists(file):
      stdout.styledWriteLine(fgRed, "Error: ", fgWhite, "File not found: " &
          file & "\n")
    result = @[file]

proc rmTag*(colors: seq[string]): seq[string] =
  for color in colors:
    if "#" in color:
      result.add(color.replace("#", ""))
    else:
      result.add(color)

proc parseColors*(input: string): seq[string] = # Please return colours
  var
    i = 0
    buff = ""
  while i < input.len:
    i += input.skipWhile({'#', ' ', ','}, i)
    i += input.parseUntil(buff, ',', i)
    result.add buff

proc save*(image: Image, path: string) =
  discard tryRemoveFile(path)
  image.writeFile(path)
