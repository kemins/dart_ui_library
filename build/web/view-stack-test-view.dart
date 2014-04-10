import 'package:polymer/polymer.dart';

import "package:ui_lib/ui_lib.dart";

import "dart:html";

@CustomTag('view-stack-test-view')
class ViewStackTestView extends StackViewImpl with ChangeNotifier {
  
  @reflectable @observable
  int get selectedIndex => __$selectedIndex; int __$selectedIndex = 0; @reflectable set selectedIndex(int value) { __$selectedIndex = notifyPropertyChange(#selectedIndex, __$selectedIndex, value); }
  
  @reflectable @observable
  List get menuDataProvider => __$menuDataProvider; List __$menuDataProvider = toObservable([]); @reflectable set menuDataProvider(List value) { __$menuDataProvider = notifyPropertyChange(#menuDataProvider, __$menuDataProvider, value); }
  
  @reflectable @observable
  String get animationDirection => __$animationDirection; String __$animationDirection = "fromLeft"; @reflectable set animationDirection(String value) { __$animationDirection = notifyPropertyChange(#animationDirection, __$animationDirection, value); }
  
  @reflectable @observable
  String get animationDurationStr => __$animationDurationStr; String __$animationDurationStr = "300"; @reflectable set animationDurationStr(String value) { __$animationDurationStr = notifyPropertyChange(#animationDurationStr, __$animationDurationStr, value); }
  
  @reflectable @observable
  int get animationDuration => __$animationDuration; int __$animationDuration; @reflectable set animationDuration(int value) { __$animationDuration = notifyPropertyChange(#animationDuration, __$animationDuration, value); }
  
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