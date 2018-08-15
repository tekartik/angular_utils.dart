import 'package:angular/core.dart';
import 'package:tekartik_angular_utils/layout/page_layout/page_layout.dart';

@Component(
    selector: 'app',
    templateUrl: 'app.html',
    styleUrls: const <String>['app.css'],
    directives: const [PageLayout])
class AppComponent implements OnInit {
  AppComponent();
/*
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
*/
  @override
  void ngOnInit() {
    /*
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
    */
  }
}
