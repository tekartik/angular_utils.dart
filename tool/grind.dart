import 'package:tekartik_build_utils/grind/grind_app.dart';

export 'package:tekartik_build_utils/grind/grind_app.dart';

void main(List<String> args) {
//  example_sidebar();
  app.gsPath = 'gs://gs.tk4k.ovh/angular_utils';
  example();
  exampleSidebar();
  grind(args);
}

void exampleSidebar() {
  app.path = join("example", "side_bar");
  app.gsPath = 'gs://gs.tk4k.ovh/angular_utils/example/side_bar';
}

@Task('Test')
Future test() async {
  //devPrint('test');
}
