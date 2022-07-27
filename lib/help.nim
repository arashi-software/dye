let helps* = (
  flip: """
The flip command can be used to flip the colors of an image to their opposite.
Flags:
  -o --output <output>
    The output file. If not specified the file is saved as the name of the operation and the filename.
  -b --bar
    Show a progress bar or not. (Default is false)
  """,
  luma: """
The luma comand can be used to invert the luminance of an image. (Turns day to night)
Flags:
  -o --output <output>
    The output file. If not specified the file is saved as the name of the operation and the filename.
  -b --bar
    Show a progress bar or not. (Default is false)
  """,
  palette: """
Palette is a type of arg that can be a csv file of colors, a comma separated list of colors in quotesm, or a builtin palette (you can list palettes with `dye list`). It is denoted by `<palette>`.
  """,
  list: """
The list command can be used to list the available builtin palettes.
  """,
  all: """
Welcome to dye! The ultrafast image colorizer.

Usage:
  dye [flags] -p <palette> [image]
  dye list
  dye flip [flags] <image>
  dye luma [flags] <image>

Commands:
  list
  flip
  luma

To get more information about a command, use `dye help -c <comand>`.
  """
)
