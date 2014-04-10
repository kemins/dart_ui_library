import 'package:polymer/polymer.dart';

import "package:ui_lib/ui_lib.dart";

@CustomTag('accordion-test-view')
class AccordionView extends StackViewImpl with ChangeNotifier {
  
  
  AccordionView.created(): super.created() {
  }
  
  @reflectable @observable
  String get headerHeightStr => __$headerHeightStr; String __$headerHeightStr = "25"; @reflectable set headerHeightStr(String value) { __$headerHeightStr = notifyPropertyChange(#headerHeightStr, __$headerHeightStr, value); }
  
  @reflectable @observable
  int get headerHeight => __$headerHeight; int __$headerHeight = 25; @reflectable set headerHeight(int value) { __$headerHeight = notifyPropertyChange(#headerHeight, __$headerHeight, value); }
  
  @override
  void enteredView() {
    super.enteredView();
  }
  
  @override
  void viewShown() {
    super.viewShown();
  }
  
  @override 
  void viewHidden(){
    super.viewHidden();
  }
  
  void headerHeightStrChanged() {
    headerHeight = int.parse(headerHeightStr);
  }
  
}