import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:math';

import "package:ui_lib/ui_lib.dart";

@CustomTag('progress-bar')
class ProgressBar extends PolymerElement with ChangeNotifier  {

  @reflectable @published
  int get current => __$current; int __$current = 0; @reflectable set current(int value) { __$current = notifyPropertyChange(#current, __$current, value); }
  
  @reflectable @published
  int get total => __$total; int __$total = 100; @reflectable set total(int value) { __$total = notifyPropertyChange(#total, __$total, value); }

  int get percentloaded => current == 0 || total == 0 ? 0 : min((current/total * 100).round(), 100);
  
  @reflectable @published
  int get width => __$width; int __$width = 200; @reflectable set width(int value) { __$width = notifyPropertyChange(#width, __$width, value); }
  
  @reflectable @published
  int get height => __$height; int __$height = 32; @reflectable set height(int value) { __$height = notifyPropertyChange(#height, __$height, value); }
  
  @reflectable @published
  String get sizeType => __$sizeType; String __$sizeType = "px"; @reflectable set sizeType(String value) { __$sizeType = notifyPropertyChange(#sizeType, __$sizeType, value); }
  
  @reflectable @published
  String get backgroundColor => __$backgroundColor; String __$backgroundColor = "#ffffff"; @reflectable set backgroundColor(String value) { __$backgroundColor = notifyPropertyChange(#backgroundColor, __$backgroundColor, value); }
  
  @reflectable @published
  int get borderThickness => __$borderThickness; int __$borderThickness = 4; @reflectable set borderThickness(int value) { __$borderThickness = notifyPropertyChange(#borderThickness, __$borderThickness, value); }
  
  @reflectable @published
  List<String> get fillColors => __$fillColors; List<String> __$fillColors = ["#ffc423", "#fde09b", "#ffc423"]; @reflectable set fillColors(List<String> value) { __$fillColors = notifyPropertyChange(#fillColors, __$fillColors, value); }
  
  @reflectable @published
  List<String> get strokeColors => __$strokeColors; List<String> __$strokeColors = ["#d9d9ec", "#ffffff", "#d9d9ec"]; @reflectable set strokeColors(List<String> value) { __$strokeColors = notifyPropertyChange(#strokeColors, __$strokeColors, value); }
  
  ProgressBar.created() : super.created() {
  }
  
  
  void widthChanged() {
    if (_mainDiv != null) {
      _mainDiv.style.width = "${width}${sizeType}";
    }
  }
  
  void heightChanged() {
    if (_mainDiv != null) {
      _mainDiv.style.height = "${height}${sizeType}";
    }
  }
  
  void enteredView() {
    super.enteredView();
    
    _canvas = $['progressCanvas'];
    _mainDiv = $['mainDiv'];
    _progressContext = _canvas.context2D;
    
    widthChanged();
    heightChanged();
    _drawThermometer();
    
  }
  
  void currentChanged() {
    notifyPropertyChange(#percentloaded, null, percentloaded);
    _drawThermometer();
  }
  
  void totalChanged() {
    notifyPropertyChange(#percentloaded, null, percentloaded);
    _drawThermometer();
  }
  
  void _drawThermometer() {
    
      if (_progressContext != null) {
          num x = borderThickness;
          num y = borderThickness;
          
          _progressContext.clearRect(0, 0, _canvas.width, _canvas.height);
          num leftRadius = _loaderHeight/2;
          num rightRadius = min(leftRadius, _progressWidth - leftRadius);
          rightRadius = max(0, rightRadius);
          
          CanvasGradient strokeGradient = _progressContext.createLinearGradient(x, y, x, y + _loaderHeight);
          List<String> colors = strokeColors;
          strokeGradient.addColorStop(0, colors[0]);
          strokeGradient.addColorStop(0.5, colors[1]);
          strokeGradient.addColorStop(1, colors[2]);
          
          CanvasGradient fillGradient = _progressContext.createLinearGradient(x, y, x, y + _loaderHeight);
          fillGradient.addColorStop(0, "#cccccc");
          fillGradient.addColorStop(0.5, backgroundColor);
          fillGradient.addColorStop(1, "#cccccc");
          
          GraphicUtils.drawRoundRect(_progressContext, x, y, _loaderrWidth, _loaderHeight, 
              leftRadius, leftRadius, 
              borderThickness: borderThickness,
              fill: fillGradient,
              stroke: strokeGradient);
          
          
          colors = fillColors;
          fillGradient = _progressContext.createLinearGradient(x, y, x, y + _loaderHeight);
          fillGradient.addColorStop(0, colors[0]);
          fillGradient.addColorStop(0.5, colors[1]);
          fillGradient.addColorStop(1, colors[2]);
          
          GraphicUtils.drawRoundRect(_progressContext, x, y, _progressWidth, _loaderHeight, 
              leftRadius, rightRadius, 
              fill: fillGradient,
              stroke: strokeGradient,
              borderThickness: 0);
        
      }
  }
  
  int get _progressWidth {
    int res = 0;
    if (total != 0 && current != 0) {
      res = (min(1, current/total) *  _loaderrWidth).round();
    }
    return res;
  }
  
  CanvasRenderingContext2D _progressContext;
  
  CanvasElement _canvas;
  
  DivElement _mainDiv;
  
  num get _loaderHeight => height - 2 * borderThickness;
  num get _loaderrWidth => width - 2 * borderThickness;
  
  ShadowRoot _shadowRoot;
  
}