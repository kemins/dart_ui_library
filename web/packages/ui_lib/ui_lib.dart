library ui_lib;

import 'dart:html';
import "package:observe/observe.dart";

import 'package:polymer/polymer.dart';
import 'package:animation/animation.dart' as animator;

import 'dart:async';

import "dart:math";

import "managers.dart";

part "common/models.dart";

part "selectors/selectors.dart";
part "selectors/dropdown.dart";

part "common/animation_utils.dart";
part "graphic_utils.dart";

@reflectable
void callLater(Function callBack, {int ms: 0}) {
  new Timer(new Duration(milliseconds: ms), callBack);
}

abstract class StackView implements PolymerElement{
  
  bool showView = false;
  
  void viewShown();
  
  void viewHidden();
}

class StackViewImpl extends PolymerElement implements StackView {
  
  StackViewImpl.created(): super.created() {
    
  }
  
  @published
  String sizeType = "px";
  
  @reflectable
  bool get showView => _showView;
  
  @reflectable
  bool get hideView => !_showView;
  
  @reflectable
  void set showView(bool value) {
    
    if (_showView != value) {
      
      _showView = value;
      
      _showView ?
        callLater(viewShown):
        viewHidden();
        notifyPropertyChange(#showView, !showView, showView);
        notifyPropertyChange(#hideView, !hideView, hideView);
    }
  }
  
  @reflectable
  void viewShown() {
    
  }
  
  @reflectable
  void viewHidden() {
    
  }
  
  
  bool _showView = false;
  
  
}
