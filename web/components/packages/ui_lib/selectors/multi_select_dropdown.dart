import 'package:polymer/polymer.dart';

import 'package:ui_lib/ui_lib.dart';

@CustomTag('multi-select-dropdown')
class MultiSelectDropDwon extends DropDownSelector{
 
  MultiSelectDropDwon.created() : super.created();
  
  @published
  bool multiSelectAllowed = true;
  
  void enteredView() {
    super.enteredView();
  }
    
}