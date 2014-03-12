import 'package:polymer/polymer.dart';

import "package:ui_lib/ui_lib.dart";

@CustomTag('accordion-test-view')
class AccordionView extends StackViewImpl{
  
  
  AccordionView.created(): super.created() {
  }
  
  @observable
  String headerHeightStr = "25";
  
  @observable
  int headerHeight = 25;
  
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