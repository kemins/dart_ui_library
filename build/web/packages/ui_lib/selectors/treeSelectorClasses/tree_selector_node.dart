import 'package:polymer/polymer.dart';
import 'dart:html';

import 'package:ui_lib/ui_lib.dart';

@CustomTag('tree-node')
class TreeNode extends PolymerElement with ChangeNotifier  {
 
  TreeNode.created(): super.created() {
    
  }
  
  @override
  void enteredView() {
    super.enteredView();
    
    DivElement arrowDiv = $["arrow"];
    
    _animator = new ExpandCollapseAnimator(_childrenDiv, animationDuration: animationDuration, collapseAnimationCallback: _onCollapseAnimationComplete);
    
    _observers.add(bindCssClass(arrowDiv, 'arrow-right-small', item, 'collapsed'));
    _observers.add(bindCssClass(arrowDiv, 'close-node', item, 'collapsed'));
    
    _observers.add(bindCssClass(arrowDiv, 'arrow-down-small', item, 'expanded'));
    _observers.add(bindCssClass(arrowDiv, 'open-node', item, 'expanded'));
    
    _observers.add(bindCssClass(arrowDiv, 'emptyNode', item, 'noChildren'));
    
  }
  
  @override
  void leftView() {
    super.leftView();
    _observers.forEach((PathObserver oberve) => oberve.unobserved());
  }
  
  @reflectable @published
  int get animationDuration => __$animationDuration; int __$animationDuration = 300; @reflectable set animationDuration(int value) { __$animationDuration = notifyPropertyChange(#animationDuration, __$animationDuration, value); }
  
  @reflectable @published 
  bool get useAnimation => __$useAnimation; bool __$useAnimation = true; @reflectable set useAnimation(bool value) { __$useAnimation = notifyPropertyChange(#useAnimation, __$useAnimation, value); }
  
  @reflectable @published
  MenuItem get item => __$item; MenuItem __$item; @reflectable set item(MenuItem value) { __$item = notifyPropertyChange(#item, __$item, value); }
  
  @reflectable @published
  bool get multiSelectAllowed => __$multiSelectAllowed; bool __$multiSelectAllowed = true; @reflectable set multiSelectAllowed(bool value) { __$multiSelectAllowed = notifyPropertyChange(#multiSelectAllowed, __$multiSelectAllowed, value); }
  
  @reflectable @observable
  bool get expanded => __$expanded; bool __$expanded = false; @reflectable set expanded(bool value) { __$expanded = notifyPropertyChange(#expanded, __$expanded, value); }
  
  @reflectable @observable
  bool get colapsed => __$colapsed; bool __$colapsed = true; @reflectable set colapsed(bool value) { __$colapsed = notifyPropertyChange(#colapsed, __$colapsed, value); }
  
  void arrowClickHandler(MouseEvent event, details, target) {
    if (item.collapsed) {
      expandNode(event, target, details);
    }else {
      collapseNode(event, target, details);
    }
  }
  
  void expandNode(MouseEvent event, target, details) {
    
    if (_animator.animationRequested) return;
    
    item.collapsed = false;
    
    if (useAnimation) {
      // avoid blinks
      _childrenDiv.style.marginTop = "-9999px";
      callLater(_animator.animateExpand);
    }
  }
  
  void collapseNode(MouseEvent event, target, details) {
    
    if (_animator.animationRequested) return;
    
    if (useAnimation) {
      _animator.animateCollapse();
    }else {
      item.collapsed = true;
    }
  }
  
  void _onCollapseAnimationComplete([event = null]) {
    item.collapsed = true;
  }
  
  DivElement get _childrenDiv => $["childrenDiv"];
  
  List<PathObserver> _observers = [];
  
  ExpandCollapseAnimator _animator;
  
  
}