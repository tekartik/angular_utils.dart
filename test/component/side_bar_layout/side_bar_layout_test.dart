@TestOn("browser")
import 'package:dev_test/test.dart';
import 'package:tekartik_angular2_utils/component/side_bar_layout/side_bar_layout.dart';

main() {
  group('side_bar_layout', () {
    test('getPixelWidth', () {
      expect(SideBarLayoutComponent.getPixelWidth('100px'), 100);
    });
  });
}