import 'package:polymer/polymer.dart';

import 'package:ui_lib/ui_lib.dart';

import "dart:html";

@CustomTag('list-selector')
class ListSelector extends Selector{
 
  @observable
  int UID;
  
  @observable
  String radioGroupName;

  ListSelector.created() : super.created() {
    UID = new DateTime.now().millisecondsSinceEpoch;
    radioGroupName = "selectionGroup${UID}";
  }
  
  void enteredView() {
    super.enteredView();
    
    _mainHolder = $['mainHolder'];
    _initAttributes();
  }
  
  @published
  bool showTopControlPanel = true;
  
  @override
  void selectAll() {
    suspendSelectionChangeListeners();
    dataProvider.forEach((MenuItem item) => item.selected = true);
    resumeSelectionChangeListeners();
  }
  
  @override
  void unselectAll() {
    suspendSelectionChangeListeners();
    dataProvider.forEach((MenuItem item) => item.selected = false);
    resumeSelectionChangeListeners();
  }
 
  @override
  @reflectable
  void widthChangeHandler(String oldValue, String newValue) {
    super.widthChangeHandler(oldValue, newValue);
    
    if (_mainHolder != null) {
      _mainHolder.style.width = newValue;
    }
  }
  
  @override
  @reflectable
  void heightChangeHandler(String oldValue, String newValue) {
    super.heightChangeHandler(oldValue, newValue);
    
    if (_mainHolder != null) {
      _mainHolder.style.height = newValue;
    }
  }
  
  void _initAttributes() {
     if (width != null && width.isNotEmpty) {
       _mainHolder.style.width = width; 
     }
     
     if (height != null && height.isNotEmpty) {
      _mainHolder. style.height = height;
     }
   }
  
  DivElement _mainHolder;
}