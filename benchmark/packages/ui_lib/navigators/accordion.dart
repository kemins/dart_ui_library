import 'package:polymer/polymer.dart';
import 'view_stack.dart';
import 'accordion_view.dart';
import 'dart:html';
import 'package:ui_lib/ui_lib.dart';

@CustomTag('accordion-stack')
class Accordion extends ViewStack{
  
  Accordion.created() : super.created() {
  }
  
  void enteredView() {
    super.enteredView();
    addEventListener("showView", onShowView);
    callLater(_layoutViews);
  }
 
  @override
  void hideViewFromDom(Element view) {
  }
  
  @override
  void showViewInDom(Element view) {
  }
  
  @override
  get useAnimation => false;
  
  @published
  int headerHeight = 25;
  
  int get numChildren => children.length;
  
  @override
  void initView(StackView view) {
   super.initView(view);
   AccordionView av = view as AccordionView;
   av.headerHeight = headerHeight;
   av.viewIndex = children.indexOf(view);
  }
  
  @override
  void onAnimationComplete([event = null]) {
    super.onAnimationComplete(event);
    callLater(setViewPosition);
  }
  
  @override
  void set selectedIndex(int value) {
    if (selectedIndex != value) {
      super.selectedIndex = value;
      children.forEach((AccordionView view) => view.selectedIndex = selectedIndex);
      if (!useAnimation) {
        callLater(setViewPosition);
      }
    }
  }
  
  void setViewPosition() {
    int x = 0;
    for (AccordionView view in children) {
      view.style.top = "$x$sizeType";
      Rectangle rec = view.getBoundingClientRect();
      x += rec.height.ceil();
    }
  }
  
  void setViewSize() {
    int contentHeight = _calculateContentHeight();
    for (AccordionView view in children) {
      view.style.margin = "0";
      view.style.width = "100%";
      view.contentHeight = contentHeight;
    }
  }
  
  void onShowView(CustomEvent event) {
    selectedIndex = event.detail; 
  }
  
  void headerHeightChanged() {
    children.forEach((AccordionView view) => view.headerHeight = headerHeight);
    _layoutViews();
  }
  
  int _calculateContentHeight() {
    int res = 0;
    num height = getBoundingClientRect().height;
    res = height.ceil();
    res = res - numChildren * headerHeight;
    return res;
  }
  
  void _layoutViews() {
    setViewSize();
    callLater(setViewPosition);
  }
  
}