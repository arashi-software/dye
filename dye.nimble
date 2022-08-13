<<<<<<< HEAD
version       = "1.1.5"
=======
<<<<<<< HEAD
version       = "1.1.5"
=======
version       = "1.1.6"
>>>>>>> 45263dd (feat: update command for macos and linux)
>>>>>>> 025954b (feat: update command for macos and linux)
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
requires "harpoon#head"
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
requires "zippy"
>>>>>>> 45263dd (feat: update command for macos and linux)
>>>>>>> 025954b (feat: update command for macos and linux)
#requires "nimoji"


task lint, "Lint all *.nim files":
  exec "nimpretty --indent:2 */**.nim"

task b, "Build for release":
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 025954b (feat: update command for macos and linux)
  exec "nimble install -d:release && nim c -d:release src/dye && mkdir -p bin && mv -f src/dye bin/"

task bi, "Build and install to your path (/usr/bin/)":
  exec "nimble install -d:release && nim c -d:release src/dye"

task bz, "Build using zig as a c compiler":
  exec "nimble install -y -d && nim c -d:release --cc:clang --clang.exe:'scripts/zigcc' src/dye.nim && mkdir -p bin && mv -f src/dye bin/"
<<<<<<< HEAD
=======
=======
  exec "nimble install -d:release && nim c -d:release -d:ssl src/dye && mkdir -p bin && mv -f src/dye bin/"

task bi, "Build and install to your path (/usr/bin/)":
  exec "nimble install -d:release && nim c -d:release -d:ssl src/dye"

task bz, "Build using zig as a c compiler":
  exec "nimble install -y -d && nim c -d:release -d:ssl --cc:clang --clang.exe:'scripts/zigcc' src/dye.nim && mkdir -p bin && mv -f src/dye bin/"
>>>>>>> 45263dd (feat: update command for macos and linux)
>>>>>>> 025954b (feat: update command for macos and linux)

task i, "Install a built version of dye":
  exec "sudo mv -fv bin/dye /usr/bin/"

task bzi, "Build with zig and install":
  exec "nimble bz && nimble i"
