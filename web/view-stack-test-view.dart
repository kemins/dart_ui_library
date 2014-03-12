import 'package:polymer/polymer.dart';

import "package:ui_lib/ui_lib.dart";

import "dart:html";

@CustomTag('view-stack-test-view')
class ViewStackTestView extends StackViewImpl{
  
  @observable
  int selectedIndex = 0;
  
  @observable
  List menuDataProvider = toObservable([]);
  
  @observable
  String animationDirection = "fromLeft";
  
  @observable
  String animationDurationStr = "300";
  
  @observable
  int animationDuration;
  
  ViewStackTestView.created(): super.created() {
  }
  
  @override
  void enteredView() {
    super.enteredView();
  }
  
  @override
  void viewShown() {
    super.viewShown();
    populateMenuDataProvider();
  }
  
  @override 
  void viewHidden(){
    super.viewHidden();
    menuDataProvider.clear();
  }
  
  void populateMenuDataProvider() {
    MenuItem item = new MenuItem('0', "First Screen");
    menuDataProvider.add(item);  
    item = new MenuItem('1', "Second Screen");
    menuDataProvider.add(item);
    item = new MenuItem('2', "Third Screen");
    menuDataProvider.add(item);
    item = new MenuItem('3', "Fourth Screen");
    menuDataProvider.add(item);
  }
  
  void onButtonClick(Event event, details, target) {
    selectedIndex = int.parse(target.lastClickedValue);
  }
  
  void onAnimationDiractionChage(Event event, details, SelectElement target) {
    animationDirection = target.value;
  }
  
  void animationDurationStrChanged() {
    animationDuration = int.parse(animationDurationStr);
  }
   
  
}