import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:math';

import "package:ui_lib/ui_lib.dart";

@CustomTag('progress-bar')
class ProgressBar extends PolymerElement {

  @published
  int current = 0;
  
  @published
  int total = 100;

  int get percentloaded => current == 0 || total == 0 ? 0 : min((current/total * 100).round(), 100);
  
  @published
  int width = 200;
  
  @published
  int height = 32;
  
  @published
  String sizeType = "px";
  
  @published
  String backgroundColor = "#ffffff";
  
  @published
  int borderThickness = 4;
  
  @published
  List<String> fillColors = ["#ffc423", "#fde09b", "#ffc423"];
  
  @published
  List<String> strokeColors = ["#d9d9ec", "#ffffff", "#d9d9ec"];
  
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