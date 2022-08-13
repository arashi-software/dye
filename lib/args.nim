import os, strutils, strformat, therapist

<<<<<<< HEAD
const versionNum = staticRead(fmt"../dye.nimble").splitLines()[0].split("=")[1]
=======
<<<<<<< HEAD
const versionNum = staticRead(fmt"../dye.nimble").splitLines()[0].split("=")[1]
=======
const versionNum* = staticRead(fmt"../dye.nimble").splitLines()[0].split("=")[1]
>>>>>>> 45263dd (feat: update command for macos and linux)
>>>>>>> 025954b (feat: update command for macos and linux)
  .strip().replace("\"", "")

const release = defined(release)

var bType: string

if release:
  bType = "release"
else:
  bType = "debug"

let list = (
  help: newHelpArg()
)

let flip = (
  help: newHelpArg(),
  bar: newCountArg(@["--bar", "-b"], multi=false, help="Show a progress bar"),
  output: newStringArg(@["--output", "-o"], help="The file to write to", optional=true, defaultVal="null"),
  file: newPathArg(@["<file>"], help="The file (or folder of files) to convert")
)

let luma = (
  help: newHelpArg(),
  bar: newCountArg(@["--bar", "-b"], multi=false, help="Show a progress bar"),
  output: newStringArg(@["--output", "-o"], help="The file to write to", optional=true, defaultVal="null"),
  file: newPathArg(@["<file>"], help="The file (or folder of files) to convert")
)

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
let update = (
  help: newHelpArg()
)

>>>>>>> 45263dd (feat: update command for macos and linux)
>>>>>>> 025954b (feat: update command for macos and linux)
let args* = (
  list: newCommandArg(@["list", "ls"], list, help="List all palettes"),
  luma: newCommandArg(@["luma", "l"], luma, help="Invert the luminance of an image"),
  flip: newCommandArg(@["flip", "f"], flip, help="Flip the colors of an image"),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
  update: newCommandArg(@["update", "u"], update, help="Update dye"),
>>>>>>> 45263dd (feat: update command for macos and linux)
>>>>>>> 025954b (feat: update command for macos and linux)
  bar: newCountArg(@["--bar", "-b"], multi=false, help="Show a progress bar"),
  output: newStringArg(@["--output", "-o"], help="The file to write to", optional=true, defaultVal="null"),  
  file: newPathArg(@["<file>"], help="The file (or folder of files) to convert", optional=true),
  palette: newStringArg(@["--palette", "-p"], help="The palette to use"),
  version: newCountArg(@["--version", "-v"], multi=false, help="Show dye version information"), 
  help: newHelpArg()
)

args.parseOrQuit(prolog="Dye. The ultrafast image colorizer", command="dye")

if args.version.seen:
  echo "dye v$#\nrelease: $#" % @[versionNum, $release]
  quit(0)

export therapist
