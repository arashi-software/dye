version       = "1.2.1"
author        = "Luke"
description   = "An image colorizer"
license       = "GPL-3.0-or-later"
srcDir        = "src"
bin           = @["dye"]

requires "nim >= 1.4.8"
requires "progress"
requires "pixie#head"
requires "chroma#head"
requires "therapist"
requires "puppy"
requires "zippy"
#requires "downit"

task lint, "Lint all *.nim files":
  exec "nimpretty --indent:2 */**.nim"

task b, "Build for release":
  exec "nimble install -d:release && nim c --passL:'-s' -d:ssl -d:release src/dye && mkdir -p bin && mv -f src/dye bin/"

task bi, "Build and install to your path (/usr/bin/)":
  exec "nimble install -d:release && nim c --passL:'-s' -d:release -d:ssl src/dye"

task bz, "Build using zig as a c compiler":
  exec "nimble install -y -d && nim c -d:release -d:ssl --passL:'-s' --cc:clang --clang.exe:'scripts/zigcc' src/dye.nim && mkdir -p bin && mv -f src/dye bin/"

task i, "Install a built version of dye":
  exec "sudo mv -fv bin/dye /usr/bin/"

task bzi, "Build with zig and install":
  exec "nimble bz && nimble i"
