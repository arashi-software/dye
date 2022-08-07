import 'package:dye_dart/dye.dart';
import 'package:args/args.dart';
import 'package:color/color.dart';
import 'dart:isolate';
import 'dart:io';
import 'package:image/image.dart';

void main(List<String> args) async {
  var parser = ArgParser();
  parser.addFlag('help', abbr: 'h', negatable: false);
  parser.addOption('palette', abbr: 'p');
  var res = parser.parse(args);
  var file = res.rest.first;
  if (res["help"]) {
    print(parser.usage);
  } else {
    // Check to see if all the necessary arguments were provided
    if (res["palette"] == null) {
      print(
          "You must specify a palette with the --palette flag, run dye -h for more information");
      throw "No palette specified";
    } else if (file.isEmpty) {
      print("Please specify some image files to convert");
      throw "No files specified";
    }
    stdout.write("Preparing...");
    var receivePort = ReceivePort();

    await Isolate.spawn(
      decodeIsolate, DecodeParam(File(file), receivePort.sendPort)
    );
    var col = res["palette"].split(",");
    List<RgbColor> colors = [];
    for (String c in col) {
      colors.add(HexColor(normalizeHex(c)).toRgbColor());
    }  
    var image = await receivePort.first as Image;
    colorize(file, image, colors);
  }
}
