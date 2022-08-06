import 'package:color/color.dart';
import 'dart:math';
import 'package:image/image.dart';
import 'dart:io';
import 'dart:async';

// This function removes the tag from a hex color code.
// If the hex is only 3 charecters it will convert it into a long form hex
String normalizeHex(String hex) {
  hex.replaceAll('#', '');
  if (hex.length == 3) {
    return '${hex[0]}${hex[0]}${hex[1]}${hex[1]}${hex[2]}${hex[2]}';
  } else if (hex.length == 6) {
    return hex;
  } else {
    throw 'Invalid hex value: $hex';
  }
}

int distance(HexColor c1, HexColor c2) {
  var h1 = c1.toRgbColor();
  var h2 = c2.toRgbColor();
  return (pow(h2.r - h1.r, 2) + pow(h2.g - h1.g, 2) + pow(h2.b - h1.b, 2))
      .toInt();
}

HexColor closestColor(List<HexColor> cols, HexColor o) {
  var diff = 1000000;
  HexColor color;
  int d;
  for (HexColor c in cols) {
    d = distance(c, o);
    if (d < diff) {
      diff = d;
      color = c;
    }
  }
  return color;
}


void colorize(String file, List<HexColor> palette) {
  var image = decodeImage(File(file).readAsBytesSync());
  for (var y = 0; y < image.height; y++) {
    for (var x = 0; x < image.width; x++) {
      var color = image.getPixel(x, y);
      var c = RgbColor(getRed(color), getGreen(color), getBlue(color));
      var closest = closestColor(palette, c.toHexColor()).toRgbColor();
      //print(closest);
      drawPixel(image, x, y, getColor(closest.r, closest.g, closest.b));
    }
  }
  var filename = file.split('/').last;
  var name = "conv-$filename";
  File(name).create(recursive: true);
  File(name).writeAsBytesSync(encodePng(image));
}
