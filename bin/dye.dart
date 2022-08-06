import 'package:dye_dart/dye.dart';
import 'package:args/args.dart';
import 'package:color/color.dart';

void main(List<String> args) {
  var parser = ArgParser();
  parser.addFlag('help', abbr: 'h', negatable: false);
  parser.addOption('palette', abbr: 'p');
  var res = parser.parse(args);
  var files = res.rest;
  if (res["help"]) {
    print(parser.usage);
  } else {
    // Check to see if all the necessary arguments were provided
    if (res["palette"] == null) {
      print(
          "You must specify a palette with the --palette flag, run dye -h for more information");
      throw "No palette specified";
    } else if (files.isEmpty) {
      print("Please specify some image files to convert");
      throw "No files specified";
    }
    print("Preparing...");
    var col = res["palette"].split(",");
    var colors = [HexColor('ffffff')];
    colors.removeAt(0);
    for (String c in col) {
      colors.add(Color.hex(normalizeHex(c)));
    }
    for (String f in files) {
      colorize(f, colors);
    }
  }
}
