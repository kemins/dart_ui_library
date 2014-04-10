import 'package:polymer/polymer.dart';

import 'package:ui_lib/ui_lib.dart';

import "dart:html";

@CustomTag('list-selector')
class ListSelector extends Selector with ChangeNotifier {
 
  @reflectable @observable
  int get UID => __$UID; int __$UID; @reflectable set UID(int value) { __$UID = notifyPropertyChange(#UID, __$UID, value); }
  
  @reflectable @observable
  String get radioGroupName => __$radioGroupName; String __$radioGroupName; @reflectable set radioGroupName(String value) { __$radioGroupName = notifyPropertyChange(#radioGroupName, __$radioGroupName, value); }

  ListSelector.created() : super.created() {
    UID = new DateTime.now().millisecondsSinceEpoch;
    radioGroupName = "selectionGroup${UID}";
  }
  
  void enteredView() {
    super.enteredView();
    
    _mainHolder = $['mainHolder'];
    _initAttributes();
  }
  
  @reflectable @published
  bool get showTopControlPanel => __$showTopControlPanel; bool __$showTopControlPanel = true; @reflectable set showTopControlPanel(bool value) { __$showTopControlPanel = notifyPropertyChange(#showTopControlPanel, __$showTopControlPanel, value); }
  
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