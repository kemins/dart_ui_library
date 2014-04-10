import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag('button-bar')
class ButtonBar extends PolymerElement{

  @published
  List get dataProvider => _dataProvider;
  
  String get lastClickedValue => _lastClickedValue;
  
  void set dataProvider(List value) {
    
    var oldValue = _dataProvider;
    _dataProvider = value;
    
    notifyPropertyChange(const Symbol('dataProvider'), oldValue, _dataProvider);
  }
  
  ButtonBar.created() : super.created() {
  
  }
  
  void onButtonClick(MouseEvent event, detail, target) {
    _lastClickedValue = (target as ButtonElement).value;
    dispatchEvent(new Event("button-click", canBubble: true, cancelable: true));
  }
  
  List _dataProvider = toObservable([]);
  
  String _lastClickedValue;
  
}