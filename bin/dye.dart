import 'package:dye_dart/dye_dart.dart';
import 'package:args/args.dart';

void main(List<String> args) {
  var parser = ArgParser();
  parser.addFlag('help', abbr: 'h', negatable: false);
  parser.addOption('palette', abbr: 'p');
  var res = parser.parse(args);
  var files = res.rest;
  if (res["help"]) {
    print(parser.usage);
  } else {
    if (res["palette"] == null) {
      print("You must specify a palette with the --palette flag, run dye -h for more information");
      throw "No palette specified";
    }

    print("Hello, World!");
    print(files);
    print(normalizeHex(res["palette"]));
  }
}

