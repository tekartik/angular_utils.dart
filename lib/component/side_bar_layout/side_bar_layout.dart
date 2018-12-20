import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:tekartik_angular_utils/component/side_bar_layout/side_bar_layout_common.dart';
import 'package:tekartik_browser_utils/browser_utils_import.dart';

const String sideBarClosedClass = "sidebar-closed";
const String sideBarLargeScreenClass = "sidebar-large-screen";

typedef SideBarLayoutComponentResizeListener(bool bigScreen);

@Component(
    selector: 'side-bar-layout',
    templateUrl: 'side_bar_layout.html',
    directives: [NgIf],
    styleUrls: const <String>['side_bar_layout.css'])
class SideBarLayoutComponent implements OnInit, AfterContentInit, OnDestroy {
  bool _sideBarVisible;
  bool _bigScreen;
  bool _shouldHandleContentClick;

  bool get hasTemporarySideBar => _temporary || (_bigScreen != true);

  bool get temporarySideBarVisible =>
      hasTemporarySideBar && _sideBarVisible == true;

  bool get _temporary => parseBool(temporary) ?? false;

  bool get isSideBarVisible => _sideBarVisible == true;

  /// To force temporary side bar even on large screen
  @Input()
  String temporary;

  @Input()
  String sideBarWidth;

  @Input()
  String contentMinWidth;

  Element hostRef;

  SideBarLayoutComponent(this.hostRef);

  @ViewChild('content')
  Element contentRef;

  DivElement get contentElement => contentRef as DivElement;

  @ViewChild('sideBar')
  Element sideBarRef;

  DivElement get sideBarElement => sideBarRef as DivElement;

  @ViewChild('wrapper')
  Element wrapperRef;

  DivElement get wrapperElement => wrapperRef as DivElement;

  @ContentChild('sideBarLayoutToggleSideBar')
  Element toggleSideBarRef;

  Element get toggleSideBarElement => toggleSideBarRef;

  SideBarLayoutComponentResizeListener _resizeListener;
  MediaQueryList mql;

  // make sure the listener is called right away
  set resizeListener(SideBarLayoutComponentResizeListener resizeListener) {
    _resizeListener = resizeListener;
    if (resizeListener != null && _bigScreen != null) {
      resizeListener(_bigScreen);
    }
  }

  _onMediaChanged(Event _event) {
    _arrange(mql.matches);
  }

  @override
  void ngOnInit() {
    //devPrint("sideBarWidth $sideBarWidth");

    int sideBarWidth_ = getPixelWidth(sideBarWidth);
    int contentMinWidth_ = getPixelWidth(contentMinWidth);
    mql =
        window.matchMedia("(min-width: ${sideBarWidth_ + contentMinWidth_}px)");
    //devPrint(mql.matches);
    _arrange(mql.matches, noAnimation: true);
    mql.addListener(_onMediaChanged);
  }

  @override
  void ngOnDestroy() {
    try {
      mql.removeListener(_onMediaChanged);
    } catch (e, st) {
      print(e);
      print(st);
    }
  }

  _arrange(bool bigScreen, {bool noAnimation}) {
    // consider small if temporary
    bigScreen = bigScreen && !_temporary;
    // devPrint('temporary: $temporary bigScreen: $bigScreen (was $_bigScreen)');

    if (_sideBarVisible == null) {
      _sideBarVisible = false;
      sideBarElement.style.marginLeft = '-${sideBarWidth}';
      sideBarElement.style.width = '${sideBarWidth}';
    }
    _shouldHandleContentClick = false;

    if (_bigScreen != bigScreen) {
      _bigScreen = bigScreen;
      hostRef.classes.toggle(sideBarLargeScreenClass, _bigScreen);
      //devPrint('arranging...big $bigScreen');

      // small screen: fixed & height=100%
      sideBarElement.style.position = _bigScreen ? "absolute" : "fixed";
      if (_bigScreen) {
        sideBarElement.style.height = null;
      } else {
        sideBarElement.style.height = "100%";
      }
      resetSideBar(noAnimation: noAnimation);
    }

    // Notify listeners
    if (_resizeListener != null) {
      _resizeListener(bigScreen);
    }
  }

  void showSideBar({bool noAnimation}) {
    // Always execute as we might be switching from a small screen
    // to a big screen
    // if (!_sideBarVisible) {
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
        //devPrint('_shouldHandleContentClick');
        if (!_bigScreen && _sideBarVisible) {
          _shouldHandleContentClick = true;
        }
      });
    }
    hostRef.classes.remove(sideBarClosedClass);
  }

  void hideSideBar({bool noAnimation}) {
    _shouldHandleContentClick = false;
    if (_sideBarVisible) {
      //sideBarElement.style.transform = 'translate(-${sideBarWidth},0px)';
      _sideBarVisible = false;
      sideBarElement.style.left = '0px';

      contentElement.style.marginRight = '0px';
      wrapperElement.style.paddingLeft = '0px';

      hostRef.classes.add(sideBarClosedClass);
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
    //devPrint("onContentClick($_shouldHandleContentClick _bigScreen $_sideBarVisible)");
    if (_shouldHandleContentClick) {
      resetSideBar();
    }
  }

  onOverlayClick() {
    hideSideBar();
  }
}

@Directive(selector: '[side-bar-width]')
class SideBarLayoutDirective {
  SideBarLayoutComponent element;

  SideBarLayoutDirective(Element element) {
    element.style.backgroundColor = 'yellow';
  }
}
