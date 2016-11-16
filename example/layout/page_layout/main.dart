// Copyright (c) 2016, Alexandre Roux Tekartik. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/platform/browser.dart';
import 'package:tekartik_app_utils/css_app_reset/loader.dart';
import 'package:tekartik_app_utils/iron_flex_layout/loader.dart';

//import 'package:tekartik_angular2_utils/app_component.dart';
import 'app/app.dart';

main() async {
  await loadCssAppResetCss();
  await loadIronFlexLayoutCss();
  bootstrap(AppComponent);
}
