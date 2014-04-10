import 'package:polymer/polymer.dart';

import "package:ui_lib/ui_lib.dart";

import "dart:html";

@CustomTag('button-bar-view')
class TestView extends StackViewImpl with ChangeNotifier {

  @reflectable @observable
  List get dataProvider => __$dataProvider; List __$dataProvider = toObservable([]); @reflectable set dataProvider(List value) { __$dataProvider = notifyPropertyChange(#dataProvider, __$dataProvider, value); }
  
  @reflectable @observable
  String get selectedValue => __$selectedValue; String __$selectedValue; @reflectable set selectedValue(String value) { __$selectedValue = notifyPropertyChange(#selectedValue, __$selectedValue, value); }
  
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