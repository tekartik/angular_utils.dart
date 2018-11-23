@TestOn("browser")
library tekartik_angular_utils.test.side_bar_layout_test;

import 'package:tekartik_angular_utils/component/side_bar_layout/side_bar_layout_common.dart';
import 'package:test/test.dart';

main() {
  group('side_bar_layout', () {
    test('getPixelWidth', () {
      expect(getPixelWidth('100px'), 100);
    });
  });
}
