part of ui_lib;

class ExpandCollapseAnimator {
  
  ExpandCollapseAnimator(this.target, {Function collapseAnimationCallback, Function expandAnimationCallback, int animationDuration}) {
    this.expandAnimationCallback = expandAnimationCallback;
    this.collapseAnimationCallback = collapseAnimationCallback;
    this.animationDuration = animationDuration;
  }
  
  bool animationRequested = false;
  
  void animateExpand() {
    animationRequested = true;
    target.style.marginTop = "${-_targetDivHeigh}px";
    var properties = {
                      'margin-top': 0
    };
    
    _animation = animate(target, duration: animationDuration, properties: properties);
    _animationStreamSubscription = _animation.onComplete.listen(_onExpandAnimationComplete);
  }
  
  void animateCollapse() {
    animationRequested = true;
    
    var properties = {
                      'margin-top': -_targetDivHeigh
     };
    
    _animation = animate(target, duration: animationDuration, properties: properties);
    _animationStreamSubscription = _animation.onComplete.listen(_onCollapseAnimationComplete);
  }
  
  void _onExpandAnimationComplete([event = null]) {
    _resetAnimationsState();
    
    if (expandAnimationCallback != null) {
      expandAnimationCallback();
    }
  }
  
  void _onCollapseAnimationComplete([event = null]) {
    target.style.marginTop = "0px";
    _resetAnimationsState();
    
    if (collapseAnimationCallback != null) {
      collapseAnimationCallback();
    }
  }
  
  void _resetAnimationsState() {
    _animation = null;
    _animationStreamSubscription.cancel();
    _animationStreamSubscription = null;
    animationRequested = false;
  }
  
  num get _targetDivHeigh => target.getBoundingClientRect().height;
  
  Animation _animation;
    
  StreamSubscription _animationStreamSubscription;
    
  Element target;
  
  int animationDuration = 300; //ms
  
  Function collapseAnimationCallback;
  
  Function expandAnimationCallback;
}


class MoveAnimator {
  
  static const String FROM_LEFT  = "fromLeft";
  static const String FROM_RIGHT  = "fromRight";
  static const String FROM_TOP  = "fromTop";
  static const String FROM_BOTTOM  = "fromBottom";
  
  bool animationRequested = false;
  
  int animationDuration = 300; //ms
  
  Animation animation;
  
  StreamSubscription animationStreamSubscription;
     
  Element target;
   
  Function callback;
  
  MoveAnimator() {
  }
  
  void _onAnimationComplete([event = null]) {
     resetAnimationsState();
     
     if (callback != null) {
       callback();
     }
   }
   
   void resetAnimationsState() {
     animation = null;
     animationStreamSubscription.cancel();
     animationStreamSubscription = null;
     animationRequested = false;
   }
   
   Map get anumationProperties => {};
   
   void resetTargetState() {
     
   }
   
   void animateMove() {
     animationRequested = true;
     
     resetTargetState();
     
     animation = animate(target, duration: animationDuration, properties: anumationProperties);
     animationStreamSubscription = animation.onComplete.listen(_onAnimationComplete);
   }
}

class MoveFromLeftAnimator extends MoveAnimator{
  
  MoveFromLeftAnimator({Function callback, int animationDuration}) {
    this.callback = callback;
    this.animationDuration = animationDuration;
  }
  
  @override
  Map get anumationProperties {
    return {
          'left': 0
       }; 
  }
  
  @override
  void resetTargetState() {
    super.resetTargetState();
    target.style.left = "${-_targetDivWidth}px";
  }
  
  
  num get _targetDivWidth => target.getBoundingClientRect().width;
}

class MoveFromRightAnimator extends MoveAnimator{
  
  MoveFromRightAnimator({Function callback, int animationDuration}) {
    this.callback = callback;
    this.animationDuration = animationDuration;
  }
  
  @override
  Map get anumationProperties {
    return {
          'left': 0
       }; 
  }
  
  @override
  void resetTargetState() {
    super.resetTargetState();
    target.style.left = "${_targetDivWidth}px";
  }
  
  
  num get _targetDivWidth => target.getBoundingClientRect().width;
}

class MoveFromTopAnimator extends MoveAnimator{
  
  MoveFromTopAnimator({Function callback, int animationDuration}) {
    this.callback = callback;
    this.animationDuration = animationDuration;
  }
  
  @override
  Map get anumationProperties {
    return {
          'top': 0
       }; 
  }
  
  @override
  void resetTargetState() {
    super.resetTargetState();
    target.style.top = "${-_targetDivHeigh}px";
  }
  
  
  num get _targetDivHeigh => target.getBoundingClientRect().height;
}


class MoveFromBottomAnimator extends MoveAnimator{
  
  MoveFromBottomAnimator({Function callback, int animationDuration}) {
    this.callback = callback;
    this.animationDuration = animationDuration;
  }
  
  @override
  Map get anumationProperties {
    return {
          'top': 0
       }; 
  }
  
  @override
  void resetTargetState() {
    super.resetTargetState();
    target.style.top = "${_targetDivHeigh}px";
  }
  
  
  num get _targetDivHeigh => target.getBoundingClientRect().height;
}