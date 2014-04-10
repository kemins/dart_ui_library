import 'package:polymer/polymer.dart';

import "package:ui_lib/ui_lib.dart";

@CustomTag('progress-bar-view')
class ProgressBarView extends StackViewImpl with ChangeNotifier {
  
  ProgressBarView.created(): super.created() {
  }
  
  @reflectable @observable
  String get progressTotalStr => __$progressTotalStr; String __$progressTotalStr = ""; @reflectable set progressTotalStr(String value) { __$progressTotalStr = notifyPropertyChange(#progressTotalStr, __$progressTotalStr, value); }
  
  @reflectable @observable
  String get progressCurrentStr => __$progressCurrentStr; String __$progressCurrentStr = ""; @reflectable set progressCurrentStr(String value) { __$progressCurrentStr = notifyPropertyChange(#progressCurrentStr, __$progressCurrentStr, value); }
  
  @reflectable @observable
  int get progressTotal => __$progressTotal; int __$progressTotal = 100; @reflectable set progressTotal(int value) { __$progressTotal = notifyPropertyChange(#progressTotal, __$progressTotal, value); }
  
  @reflectable @observable
  int get progressCurrent => __$progressCurrent; int __$progressCurrent = 20; @reflectable set progressCurrent(int value) { __$progressCurrent = notifyPropertyChange(#progressCurrent, __$progressCurrent, value); }
  
  @override
  void enteredView() {
    super.enteredView();
  }
  
  @override
  void viewShown() {
    super.viewShown();
    progressTotalStr = "100";
    progressCurrentStr = "20";
    progressTotal = 100;
    progressCurrent = 20;
  }
  
  @override 
  void viewHidden(){
    super.viewHidden();
  }
  
  void progressTotalStrChanged() {
    progressTotal = int.parse(progressTotalStr);
    progressCurrent = int.parse(progressCurrentStr);
  }
  
  void progressCurrentStrChanged() {
    progressCurrent = int.parse(progressCurrentStr);
  }
  
}