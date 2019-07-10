import 'package:process_run/shell.dart';

Future main() async {
  var shell = Shell();

  await shell.run('''

dartanalyzer --fatal-warnings lib test

pub run test -p vm,chrome

pub run build_runner test -- -p chrome -j 1
  ''');
}
