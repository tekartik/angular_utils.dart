import 'package:angular2/core.dart';
import 'package:tekartik_browser_utils/browser_utils_import.dart';
import 'dart:html';

@Component(
    selector: 'side-bar-layout',
    templateUrl: 'side_bar_layout.html',
    styleUrls: const <String>['side_bar_layout.css'])
class SideBarLayoutComponent implements OnInit, AfterContentInit {
  bool _sideBarVisible;
  bool _bigScreen;
  @Input()
  String sideBarWidth;

  @Input()
  String contentMinWidth;

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
    _bigScreen = bigScreen;
    //devPrint('arranging...');
    resetSideBar(noAnimation: noAnimation);
  }

  void showSideBar({bool noAnimation}) {
    if (!_sideBarVisible) {
      //sideBarElement.style.transform = 'translate(${sideBarWidth},0px)';
      _sideBarVisible = true;
      sideBarElement.style.left = '${sideBarWidth}';
      contentElement.style.marginRight =
          _bigScreen ? '0px' : '-${sideBarWidth}';
      wrapperElement.style.paddingLeft = '${sideBarWidth}';
    }
  }

  void hideSideBar({bool noAnimation}) {
    if (_sideBarVisible) {
      //sideBarElement.style.transform = 'translate(-${sideBarWidth},0px)';
      _sideBarVisible = false;
      sideBarElement.style.left = '0px';

      contentElement.style.marginRight = '0px';
      wrapperElement.style.paddingLeft = '0px';
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
}

@Directive(selector: '[side-bar-width]')
class SideBarLayoutDirective {
  SideBarLayoutComponent element;
  SideBarLayoutDirective(ElementRef element) {
    element.nativeElement.style.backgroundColor = 'yellow';
  }
}
