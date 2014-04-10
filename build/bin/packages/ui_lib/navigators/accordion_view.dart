import 'package:polymer/polymer.dart';

import "package:ui_lib/ui_lib.dart";

import "dart:html";

@CustomTag('accordion-view')
class AccordionView extends StackViewImpl with ChangeNotifier {
  
  @reflectable @published
  String get title => __$title; String __$title = ""; @reflectable set title(String value) { __$title = notifyPropertyChange(#title, __$title, value); }
  
  @reflectable @observable
  int get headerHeight => __$headerHeight; int __$headerHeight = 25; @reflectable set headerHeight(int value) { __$headerHeight = notifyPropertyChange(#headerHeight, __$headerHeight, value); }
  
  @reflectable @observable
  int get contentHeight => __$contentHeight; int __$contentHeight = 100; @reflectable set contentHeight(int value) { __$contentHeight = notifyPropertyChange(#contentHeight, __$contentHeight, value); }
  
  @reflectable @observable
  int get viewIndex => __$viewIndex; int __$viewIndex; @reflectable set viewIndex(int value) { __$viewIndex = notifyPropertyChange(#viewIndex, __$viewIndex, value); }
  
  @reflectable @observable
  int get selectedIndex => __$selectedIndex; int __$selectedIndex; @reflectable set selectedIndex(int value) { __$selectedIndex = notifyPropertyChange(#selectedIndex, __$selectedIndex, value); }
  
  AccordionView.created(): super.created() {
  }
  
  @override
  void enteredView() {
    super.enteredView();
    _contentHolder = $['contentDiv'];
    _topHeaderButton = $['topHeaderButton'];
    headerHeightChanged();
  }
  
  @reflectable
  void onButtonClick(MouseEvent event, details, target) {
    dispatchEvent(new CustomEvent("showView", canBubble: true, detail: viewIndex));
  }
  
  void contentHeightChanged() {
    updateContentHeight();
  }
  
  void showViewChanged() {
    updateContentHeight();
  }
  
  void headerHeightChanged() {
    _topHeaderButton.style.height = "${headerHeight}${sizeType}";
  }
  
  void updateContentHeight() {
    _contentHolder.style.height = showView ? "${contentHeight}${sizeType}" : "0";
  }
  
  Element _contentHolder;
  ButtonElement _topHeaderButton;
  
  
}