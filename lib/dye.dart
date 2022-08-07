import 'package:color/color.dart';
import 'package:image/image.dart';
import 'dart:io';
import 'dart:isolate';

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

int distance(RgbColor c1, RgbColor c2) {
  return ((c2.r - c1.r) * (c2.r - c1.r)) + ((c2.g - c1.g) * (c2.g - c1.g)) + ((c2.b - c1.b) * (c2.b - c1.b))
      .toInt();
}

RgbColor closestColor(List<RgbColor> cols, RgbColor o) {
  var diff = 999999;
  RgbColor color;
  int d;
  for (RgbColor c in cols) {
    d = distance(c, o);
    if (d < diff) {
      diff = d;
      color = c;
    }
  }
  return color;
}

void colorize(String file, Image image, List<RgbColor> palette) async {
  for (var y = 0; y < image.height; y++) {
    for (var x = 0; x < image.width; x++) {
      var color = image.getPixel(x, y);
      var c = RgbColor(getRed(color), getGreen(color), getBlue(color));
      var closest = closestColor(palette, c);
      //print(closest);
      drawPixel(image, x, y, getColor(closest.r, closest.g, closest.b));
    }
    stdout.write("\rConverting $y");
  }
  var filename = file.split('/').last;
  var name = "conv-$filename";
  stdout.write("\rWriting to $name...");
  File(name).create(recursive: false);
  File(name).writeAsBytesSync(encodePng(image));
  stdout.write("\rDone!");
  exit(0);
}

class DecodeParam {
  final File file;
  final SendPort sendPort;
  DecodeParam(this.file, this.sendPort);
}

void decodeIsolate(DecodeParam param) {
  // Read an image from file (webp in this case).
  // decodeImage will identify the format of the image and use the appropriate
  // decoder.
  var image = decodeImage(param.file.readAsBytesSync());
  // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
  param.sendPort.send(image);
}
