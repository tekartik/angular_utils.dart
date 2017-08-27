import 'package:angular/core.dart';
import 'package:tekartik_angular_utils/component/side_bar_layout/side_bar_layout.dart';
import 'package:tekartik_browser_utils/browser_utils_import.dart';

import 'dart:html';

@Component(
    selector: 'app',
    templateUrl: 'app.html',
    styleUrls: const <String>['app.css'],
    directives: const [SideBarLayoutComponent])
class AppComponent implements OnInit {
  AppComponent();

  @ViewChild('sideBarLayout')
  SideBarLayoutComponent sideBarLayoutComponent;

  @ViewChild('hide')
  ElementRef hideComponent;

  @ViewChild('show')
  ElementRef showComponent;

  @ViewChild('reset')
  ElementRef resetComponent;

  @ViewChild('toggle')
  ElementRef toggleComponent;

  @override
  void ngOnInit() {
    (hideComponent.nativeElement as ButtonElement).onClick.listen((_) {
      sideBarLayoutComponent.hideSideBar();
    });

    (showComponent.nativeElement as ButtonElement).onClick.listen((_) {
      sideBarLayoutComponent.showSideBar();
    });

    (resetComponent.nativeElement as ButtonElement).onClick.listen((_) {
      sideBarLayoutComponent.resetSideBar();
    });

    (toggleComponent.nativeElement as ButtonElement).onClick.listen((_) {
      sideBarLayoutComponent.toggleSideBar();
    });
  }
}
