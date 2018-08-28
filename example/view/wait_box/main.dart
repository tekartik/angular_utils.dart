// Copyright (c) 2016, Alexandre Roux Tekartik. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:tekartik_app_utils/css_app_reset/loader.dart';
import 'package:tekartik_app_utils/iron_flex_layout/loader.dart';

//import 'package:tekartik_angular_utils/app_component.dart';
//import 'package:tekartik_angular_utils/app_component.template.dart' as ng;
import 'app/app.template.dart' as ng;

main() async {
  await loadCssAppResetCss();
  await loadIronFlexLayoutCss();
  runApp(ng.AppComponentNgFactory);
}
