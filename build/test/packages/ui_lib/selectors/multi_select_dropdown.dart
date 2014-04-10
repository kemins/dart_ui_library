import 'package:polymer/polymer.dart';

import 'package:ui_lib/ui_lib.dart';

@CustomTag('multi-select-dropdown')
class MultiSelectDropDwon extends DropDownSelector with ChangeNotifier {
 
  MultiSelectDropDwon.created() : super.created();
  
  @reflectable @published
  bool get multiSelectAllowed => __$multiSelectAllowed; bool __$multiSelectAllowed = true; @reflectable set multiSelectAllowed(bool value) { __$multiSelectAllowed = notifyPropertyChange(#multiSelectAllowed, __$multiSelectAllowed, value); }
  
  void enteredView() {
    super.enteredView();
  }
    
}