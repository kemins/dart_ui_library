import 'package:polymer/polymer.dart';

import "package:ui_lib/ui_lib.dart";

import "dart:html";

@CustomTag('button-bar-view')
class TestView extends StackViewImpl{

  @observable
  List dataProvider = toObservable([]);
  
  @observable
  String selectedValue;
  
  TestView.created(): super.created() {
  }
  
  @override
  void enteredView() {
    super.enteredView();
    
  }

  @override
  void viewShown() {
    super.viewShown();
    populateDataProvider();
  }
  
  @override 
  void viewHidden(){
    super.viewHidden();
    unbindAllProperties();
    dataProvider.clear();
    selectedValue = "";
  }
  
  
  void populateDataProvider() {
    MenuItem item = new MenuItem('1', "First Button");
    dataProvider.add(item);  
    item = new MenuItem('2', "Second Button");
    dataProvider.add(item);
    item = new MenuItem('3', "Third Button");
    dataProvider.add(item);
  }
  
  void onButtonClick(Event event, details, target) {
    selectedValue = target.lastClickedValue;
  }
  

}