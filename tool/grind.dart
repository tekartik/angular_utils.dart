import 'package:tekartik_build_utils/grind/grind_app.dart';
export 'package:tekartik_build_utils/grind/grind_app.dart';

main(List<String> args) {
//  example_sidebar();
app.gsPath = "gs://gs.tk4k.ovh/angular_utils";
example();
example_sidebar();
  grind(args);
}

example_sidebar() {
  app.path = join("example", "side_bar");
  app.gsPath = "gs://gs.tk4k.ovh/angular_utils/example/side_bar";

}
@Task('Test')
test() async {
  //devPrint('test');
}

