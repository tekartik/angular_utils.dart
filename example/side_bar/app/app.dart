import 'dart:html';

import 'package:angular/core.dart';
import 'package:tekartik_angular_utils/component/side_bar_layout/side_bar_layout.dart';
import 'package:tekartik_browser_utils/browser_utils_import.dart';

@Component(
    selector: 'app',
    templateUrl: 'app.html',
    styleUrls: <String>['app.css'],
    directives: [SideBarLayoutComponent])
class AppComponent implements OnInit {
  AppComponent();

  @ViewChild('sideBarLayout')
  SideBarLayoutComponent sideBarLayoutComponent;

  @ViewChild('hide')
  Element hideComponent;

  @ViewChild('show')
  Element showComponent;

  @ViewChild('reset')
  Element resetComponent;

  @ViewChild('toggle')
  Element toggleComponent;

  @override
  void ngOnInit() {
    (hideComponent as ButtonElement).onClick.listen((_) {
      sideBarLayoutComponent.hideSideBar();
    });

    (showComponent as ButtonElement).onClick.listen((_) {
      sideBarLayoutComponent.showSideBar();
    });

    (resetComponent as ButtonElement).onClick.listen((_) {
      sideBarLayoutComponent.resetSideBar();
    });

    (toggleComponent as ButtonElement).onClick.listen((_) {
      sideBarLayoutComponent.toggleSideBar();
    });
  }
}
