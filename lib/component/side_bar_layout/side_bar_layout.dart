import 'package:angular2/core.dart';
import 'package:tekartik_browser_utils/browser_utils_import.dart';
import 'dart:html';

const String sideBarClosedClass = "sidebar-closed";
const String sideBarLargeScreenClass = "sidebar-large-screen";

@Component(
    selector: 'side-bar-layout',
    templateUrl: 'side_bar_layout.html',
    styleUrls: const <String>['side_bar_layout.css'])
class SideBarLayoutComponent implements OnInit, AfterContentInit {
  bool _sideBarVisible;
  bool _bigScreen;
  bool _shouldHandleContentClick;


  @Input()
  String sideBarWidth;

  @Input()
  String contentMinWidth;

  ElementRef hostRef;

  SideBarLayoutComponent(this.hostRef);

  @ViewChild('content')
  ElementRef contentRef;

  DivElement get contentElement => contentRef.nativeElement;

  @ViewChild('sideBar')
  ElementRef sideBarRef;

  DivElement get sideBarElement => sideBarRef.nativeElement;

  @ViewChild('wrapper')
  ElementRef wrapperRef;

  DivElement get wrapperElement => wrapperRef.nativeElement;

  @ContentChild('sideBarLayoutToggleSideBar')
  ElementRef toggleSideBarRef;

  Element get toggleSideBarElement => toggleSideBarRef?.nativeElement;

  static int getPixelWidth(String textWidth) {
    return int.parse(textWidth.replaceAll("px", ""));
  }

  @override
  void ngOnInit() {
    //devPrint("sideBarWidth $sideBarWidth");

    int sideBarWidth_ = getPixelWidth(sideBarWidth);
    int contentMinWidth_ = getPixelWidth(contentMinWidth);
    MediaQueryList mql =
        window.matchMedia("(min-width: ${sideBarWidth_ + contentMinWidth_}px)");
    //devPrint(mql.matches);
    _arrange(mql.matches, noAnimation: true);
    mql.addListener((Event event) {
      //devPrint("Changed");
      //devPrint(event);
      //devPrint(mql.matches);
      _arrange(mql.matches);
    });
  }

  _arrange(bool bigScreen, {bool noAnimation}) {
    if (_sideBarVisible == null) {
      _sideBarVisible = false;
      sideBarElement.style.marginLeft = '-${sideBarWidth}';
      sideBarElement.style.width = '${sideBarWidth}';
    }
    _shouldHandleContentClick = false;

    if (_bigScreen != bigScreen) {
      _bigScreen = bigScreen;
      (hostRef.nativeElement as Element).classes.toggle(sideBarLargeScreenClass, _bigScreen);
      devPrint('arranging...big $bigScreen');

      // small screen: fixed & height=100%
      sideBarElement.style.position = _bigScreen ? "absolute" : "fixed";
      if (_bigScreen) {
        sideBarElement.style.height = null;
      } else {
        sideBarElement.style.height = "100%";
      }
      resetSideBar(noAnimation: noAnimation);
    }
  }

  void showSideBar({bool noAnimation}) {
    if (!_sideBarVisible) {
      //sideBarElement.style.transform = 'translate(${sideBarWidth},0px)';
      _sideBarVisible = true;
      sideBarElement.style.left = '${sideBarWidth}';

      // push for big screen
      if (_bigScreen) {
        contentElement.style.marginRight =
            _bigScreen ? '0px' : '-${sideBarWidth}';
        wrapperElement.style.paddingLeft = '${sideBarWidth}';
      } else {
        // wait 500ms before handling click
        sleep(500).then((_) {
          devPrint('_shouldHandleContentClick');
          if (!_bigScreen && _sideBarVisible) {
            _shouldHandleContentClick = true;
          }
        });
      }
      (hostRef.nativeElement as Element).classes.remove(sideBarClosedClass);
    }
  }

  void hideSideBar({bool noAnimation}) {
    _shouldHandleContentClick = false;
    if (_sideBarVisible) {
      //sideBarElement.style.transform = 'translate(-${sideBarWidth},0px)';
      _sideBarVisible = false;
      sideBarElement.style.left = '0px';

      contentElement.style.marginRight = '0px';
      wrapperElement.style.paddingLeft = '0px';

      (hostRef.nativeElement as Element).classes.add(sideBarClosedClass);
    }
  }

  void resetSideBar({bool noAnimation}) {
    if (_bigScreen) {
      showSideBar(noAnimation: noAnimation);
    } else {
      hideSideBar(noAnimation: noAnimation);
    }
  }

  void toggleSideBar({bool noAnimation}) {
    if (_sideBarVisible) {
      hideSideBar(noAnimation: noAnimation);
    } else {
      showSideBar(noAnimation: noAnimation);
    }
  }

  @override
  ngAfterContentInit() {
    // TODO: implement ngAfterContentInit
    //devPrint('toggle?: ${toggleSideBarRef}');
    if (toggleSideBarElement != null) {
      toggleSideBarElement.onClick.listen((_) {
        toggleSideBar();
      });
    }
  }

  onContentClick() {
    devPrint("onContentClick($_shouldHandleContentClick _bigScreen $_sideBarVisible)");
    if (_shouldHandleContentClick) {
        resetSideBar();
        devPrint("onContentClick()");
      }

  }

}

@Directive(selector: '[side-bar-width]')
class SideBarLayoutDirective {
  SideBarLayoutComponent element;
  SideBarLayoutDirective(ElementRef element) {
    element.nativeElement.style.backgroundColor = 'yellow';
  }
}
