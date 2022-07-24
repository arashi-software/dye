import docopt,
       strutils,
       strformat


let doc = """
Usage:
  dye list
  dye [-o FILE] [-b] [--colors CSV | --colorfile FILE] <file>
  dye flip [-o FILE] [-b] <file>
  dye luma [-o FILE] [-b] <file>
  dye (-h | --help)
  dye (-v | --version)

Options:
  -h --help    Show this screen.
  -v --version    Show version info.
  -b --bar    Show a progress bar.
  -o --output <file>    File name to output to
  --colors <csv>    Comma separated list of colors to use.
  --colorfile <file>    Path to a csv file containing colors or a preexisting palette

Subcommands:
  flip    Flip the image colors.
  luma    Flip image luminance (turn day to night).
  list   List the available color palettes.
"""

const version = staticRead(fmt"../dye.nimble").splitLines()[0].split("=")[
    1].strip().replace("\"", "")

let args* = docopt(doc, version = fmt"dye v{version}")

export docopt
