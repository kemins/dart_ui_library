import 'package:polymer/polymer.dart';

import "package:ui_lib/ui_lib.dart";

@CustomTag('progress-bar-view')
class ProgressBarView extends StackViewImpl{
  
  ProgressBarView.created(): super.created() {
  }
  
  @observable
  String progressTotalStr = "";
  
  @observable
  String progressCurrentStr = "";
  
  @observable
  int progressTotal = 100;
  
  @observable
  int progressCurrent = 20;
  
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