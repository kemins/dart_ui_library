import 'package:polymer/polymer.dart';
import 'dart:html';

import 'package:ui_lib/ui_lib.dart';

@CustomTag('tree-node')
class TreeNode extends PolymerElement {
 
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
  
  @published
  int animationDuration = 300;
  
  @published 
  bool useAnimation = true;
  
  @published
  MenuItem item;
  
  @published
  bool multiSelectAllowed = true;
  
  @observable
  bool expanded = false;
  
  @observable
  bool colapsed = true;
  
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