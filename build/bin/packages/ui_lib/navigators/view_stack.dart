import 'package:polymer/polymer.dart';
import 'dart:html';
import 'package:ui_lib/ui_lib.dart';

@CustomTag('view-stack')
class ViewStack extends PolymerElement with ChangeNotifier  {

  @reflectable @published
  String get width => __$width; String __$width = "100px"; @reflectable set width(String value) { __$width = notifyPropertyChange(#width, __$width, value); }

  @reflectable @published
  String get height => __$height; String __$height = "100px"; @reflectable set height(String value) { __$height = notifyPropertyChange(#height, __$height, value); }

  @reflectable @published
  bool get useAnimation => __$useAnimation; bool __$useAnimation = true; @reflectable set useAnimation(bool value) { __$useAnimation = notifyPropertyChange(#useAnimation, __$useAnimation, value); }

  @reflectable @published
  int get animationDuration => __$animationDuration; int __$animationDuration = 300; @reflectable set animationDuration(int value) { __$animationDuration = notifyPropertyChange(#animationDuration, __$animationDuration, value); }

  @reflectable @published
  String get animationDirection => __$animationDirection; String __$animationDirection = MoveAnimator.FROM_LEFT; @reflectable set animationDirection(String value) { __$animationDirection = notifyPropertyChange(#animationDirection, __$animationDirection, value); }

  @reflectable @published
  String get sizeType => __$sizeType; String __$sizeType = "px"; @reflectable set sizeType(String value) { __$sizeType = notifyPropertyChange(#sizeType, __$sizeType, value); }

  Element get selectedChild => _selectedChild;

  ViewStack.created(): super.created();
  void enteredView() {

    super.enteredView();

    _createAnimator();

    _contentHolder = $["contentHolder"];

    widthChanged();
    heightChanged();
    children.forEach(initView);

    _created = true;

    if (_selectedIndex == -1) {
      selectedIndex = 0;
    } else {
      selectView(false);
    }

  }

  @override
  void leftView() {
    super.leftView();
    _created = false;
  }

  @published
  int get selectedIndex => _selectedIndex;

  int get numChildren => children == null ? 0 : children.length;

  void set selectedIndex(int value) {
    _selectedIndex = value;

    if (_selectedIndex < 0 || _selectedIndex >= numChildren) {
      throw new RangeError('Selected Index out of Bounds.');
    } else {
      if (_created) {
        selectView(useAnimation);
      }
    }

  }

  void selectView([bool animate = false]) {

    children.forEach(_resetViewZIndex);

    if (_selectedChild != null) {
      _selectedChild.style.zIndex = (_SELECTED_CHILD_Z_INDEX - 1).toString();
    }

    _selectedChild = children[_selectedIndex];

    if (_selectedChild != null) {
      _showView(_selectedChild, useAnimation: animate);

      if (animate) {
        if (_selectedChild != null) {
          _moveAnimator.target = _selectedChild;
          callLater(_moveAnimator.animateMove);
        }
      } else {
        _hideViews();
      }
    }
  }

  void animationDirectionChanged() {
    _createAnimator();
  }

  void animationDurationChanged() {
    if (_moveAnimator != null) {
      _moveAnimator.animationDuration = animationDuration;
    }
  }

  void hideViewFromDom(Element view) {
    view.style.visibility = "hidden";
    view.style.display = "none";
  }

  void showViewInDom(Element view) {
    view.style.visibility = "visible";
    view.style.display = "block";
  }

  void _showView(StackView view, {bool useAnimation: false}) {
    showViewInDom(view);
    view.showView = true;
    resetViewPosition(view, useAnimation); //avoid blinks
    view.style.zIndex = _SELECTED_CHILD_Z_INDEX.toString();
  }

  void _hideView(StackView view) {
    _resetViewZIndex(view);
    view.showView = false;
    hideViewFromDom(view);
  }

  void initView(StackView view) {
    _resetViewZIndex(view);

    view.style.position = "absolute";

    if (view != _selectedChild) {
      hideViewFromDom(view);
    }
  }


  void _resetViewZIndex(StackView view) {
    view.style.zIndex = (_SELECTED_CHILD_Z_INDEX - 2).toString();
  }

  void onAnimationComplete([event = null]) {
    _hideViews();
  }

  void _hideViews() {
    List<Element> inactiveChildren = children.where((i) => i != _selectedChild
        ).toList();
    inactiveChildren.forEach(_hideView);
  }

  void _createAnimator() {
    switch (animationDirection) {
      case MoveAnimator.FROM_TOP:
        _moveAnimator = new MoveFromTopAnimator(animationDuration:
            animationDuration, callback: onAnimationComplete);
        break;
      case MoveAnimator.FROM_BOTTOM:
        _moveAnimator = new MoveFromBottomAnimator(animationDuration:
            animationDuration, callback: onAnimationComplete);
        break;
      case MoveAnimator.FROM_RIGHT:
        _moveAnimator = new MoveFromRightAnimator(animationDuration:
            animationDuration, callback: onAnimationComplete);
        break;
      case MoveAnimator.FROM_LEFT:
      default:
        _moveAnimator = new MoveFromLeftAnimator(animationDuration:
            animationDuration, callback: onAnimationComplete);
        break;
    }
  }

  void resetViewPosition(Element view, bool useAnimation) {
    switch (animationDirection) {
      case MoveAnimator.FROM_TOP:
      case MoveAnimator.FROM_BOTTOM:
        view.style.top = useAnimation ? "-9999${sizeType}" : "0${sizeType}";
        break;

      case MoveAnimator.FROM_LEFT:
      case MoveAnimator.FROM_RIGHT:
      default:
        view.style.left = useAnimation ? "-9999${sizeType}" : "0${sizeType}";
        break;
    }
  }

  void widthChanged() {
    if (_contentHolder != null) {
      _contentHolder.style.width = width;
    }
  }

  void heightChanged() {
    if (_contentHolder != null) {
      _contentHolder.style.height = height;
    }
  }

  int _selectedIndex = -1;

  Element _selectedChild;

  DivElement _contentHolder;

  bool _created = false;

  MoveAnimator _moveAnimator;

  static final int _SELECTED_CHILD_Z_INDEX = 3;

}
