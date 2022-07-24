version       = "0.1.7"
author        = "Luke"
description   = "An image colorizer"
license       = "GPL-3.0-or-later"
srcDir        = "src"
bin           = @["cli/dye", "web/index"]

requires "nim >= 1.4.8"
requires "progress"
requires "pixie#head"
requires "chroma#head"
requires "docopt"
#requires "nimoji"


task lint, "Lint all *.nim files":
  exec "nimpretty --indent:2 */**.nim"

task build_local, "Build for release":
  exec "nimble install -d:release && nim c -d:release src/dye && mkdir -p bin && mv -f src/dye bin/"

task build_install, "Build and install to your path (/usr/bin/)":
  exec "nimble install -d:release && nim c -d:release src/dye && sudo mv -f src/dye /usr/bin/ && mkdir -p ~/.config/dye/palettes/ && cp -rvf palettes/ ~/.config/dye/"

