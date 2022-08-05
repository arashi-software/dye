import 'package:dye_dart/dye_dart.dart' as dye_dart;
import 'package:args/args.dart';

void main(List<String> args) {
  var parser = ArgParser();
  parser.addFlag('help', abbr: 'h', negatable: false);
  var res = parser.parse(args);
  if (res["help"]) {
    print(parser.usage);
  }
}

