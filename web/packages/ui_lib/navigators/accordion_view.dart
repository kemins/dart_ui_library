import 'package:polymer/polymer.dart';

import "package:ui_lib/ui_lib.dart";

import "dart:html";

@CustomTag('accordion-view')
class AccordionView extends StackViewImpl{
  
  @published
  String title = "";
  
  @observable
  int headerHeight = 25;
  
  @observable
  int contentHeight = 100;
  
  @observable
  int viewIndex;
  
  @observable
  int selectedIndex;
  
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