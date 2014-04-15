import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag('button-bar')
class ButtonBar extends PolymerElement{

  @published
  List get dataProvider => _dataProvider;
  
  String get lastClickedValue => _lastClickedValue;
  
  @published
  String buttonClass = "button_bar_button";
  
  @published
  String selectedButtonClass = "button_bar_selected_button";
  
  @override
  bool get applyAuthorStyles => true;
  
  void set dataProvider(List value) {
    
    var oldValue = _dataProvider;
    _dataProvider = value;
    
    notifyPropertyChange(const Symbol('dataProvider'), oldValue, _dataProvider);
  }
  
  ButtonBar.created() : super.created() {
  
  }
  
  void onButtonClick(MouseEvent event, detail, target) {
    
    ButtonElement selectedButton = (target as ButtonElement);
    _lastClickedValue = selectedButton.value;
    
    _applyClassForButtons(selectedButton);
    dispatchEvent(new Event("button-click", canBubble: true, cancelable: true));
  }
  
  
  void _applyClassForButtons(ButtonElement selectedButton) {
    
    ElementList buttons = shadowRoot.querySelectorAll("button");
    List<String> buttonClasses = buttonClass.split(" ");
    List<String> buttonSelectedClasses = selectedButtonClass.split(" ");
    
    void applyClass(ButtonElement btn) {
      btn.classes.clear();
      
      if (btn == selectedButton) {
        buttonClasses.forEach((String claz) => btn.classes.remove(claz));
        buttonSelectedClasses.forEach((String claz) => btn.classes.add(claz));
      }else {
        buttonSelectedClasses.forEach((String claz) => btn.classes.remove(claz));
        buttonClasses.forEach((String claz) => btn.classes.add(claz));
      }
    }
    
    
    buttons.forEach(applyClass);
    
  }
  
  List _dataProvider = toObservable([]);
  
  String _lastClickedValue;
  
}