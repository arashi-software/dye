import futhark

importc:
  sysPath "/usr/lib/clang/12.0.1/include"
  path "../c"
  define IMAGE_H
  "image.h"

importc:
  sysPath "/usr/lib/clang/12.0.1/include"
  path "../c"
  define IMAGE_DITHER_H
  "dither.h"
