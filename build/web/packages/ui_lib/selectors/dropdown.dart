part of ui_lib;

abstract class DropDownSelector extends PolymerElement with ChangeNotifier {
  DropDownSelector.created(): super.created() {
  }
  
  void enteredView() {
    super.enteredView();
    
    mainDiv = $['mainDiv'];
    selectionLabelSpan = $['selectionLabelSpan'];
    dropDownDiv = mainDiv.querySelector("#divDropDowm");
    dropDownBtnRect = $['dorpdownButton'];
    onClick.listen(_onComponentClick);
    mainDiv.onClick.listen(_onComponentClick);
    
    if (_overlayManager.POPUP_OVERLAY != null) {
      mainDiv.remove();
      _overlayManager.POPUP_OVERLAY.children.add(mainDiv);
    }
    
    _animator = new ExpandCollapseAnimator(dropDownDiv, animationDuration: animationDuration, collapseAnimationCallback: _onCollapseAnimationComplete);
  }
  
  @override
  void leftView() {
    super.leftView();
    mainDiv.remove();
  }
  
  @reflectable @published
  String get prompt => __$prompt; String __$prompt = "Please select an item"; @reflectable set prompt(String value) { __$prompt = notifyPropertyChange(#prompt, __$prompt, value); }
  
  @reflectable @observable
  String get selectionLabel => __$selectionLabel; String __$selectionLabel = ""; @reflectable set selectionLabel(String value) { __$selectionLabel = notifyPropertyChange(#selectionLabel, __$selectionLabel, value); }
  
  @reflectable @published
  int get animationDuration => __$animationDuration; int __$animationDuration = 300; @reflectable set animationDuration(int value) { __$animationDuration = notifyPropertyChange(#animationDuration, __$animationDuration, value); }
  
  @reflectable @published 
  bool get useAnimation => __$useAnimation; bool __$useAnimation = true; @reflectable set useAnimation(bool value) { __$useAnimation = notifyPropertyChange(#useAnimation, __$useAnimation, value); }
  
  @reflectable @observable
  bool get showDropDown => __$showDropDown; bool __$showDropDown = false; @reflectable set showDropDown(bool value) { __$showDropDown = notifyPropertyChange(#showDropDown, __$showDropDown, value); }
  
  @reflectable @published
  List<MenuItem> get dataProvider => __$dataProvider; List<MenuItem> __$dataProvider = []; @reflectable set dataProvider(List<MenuItem> value) { __$dataProvider = notifyPropertyChange(#dataProvider, __$dataProvider, value); }
  
  @reflectable @published
  List<String> get selectedValues => __$selectedValues; List<String> __$selectedValues = []; @reflectable set selectedValues(List<String> value) { __$selectedValues = notifyPropertyChange(#selectedValues, __$selectedValues, value); }
  
  @reflectable @published
  List<MenuItem> get selectedItems => __$selectedItems; List<MenuItem> __$selectedItems = []; @reflectable set selectedItems(List<MenuItem> value) { __$selectedItems = notifyPropertyChange(#selectedItems, __$selectedItems, value); }
  
  @reflectable @published
  String get dropDownWidth => __$dropDownWidth; String __$dropDownWidth = "auto"; @reflectable set dropDownWidth(String value) { __$dropDownWidth = notifyPropertyChange(#dropDownWidth, __$dropDownWidth, value); }
  
  @reflectable @published
  String get dropDownHeight => __$dropDownHeight; String __$dropDownHeight = "auto"; @reflectable set dropDownHeight(String value) { __$dropDownHeight = notifyPropertyChange(#dropDownHeight, __$dropDownHeight, value); }
  
  @reflectable
  void showDropDownChanged() {
    if (showDropDown) {
      _documentClikSubscription = document.onClick.listen(_onDocumentClick);
    }else if (_documentClikSubscription != null){
      _documentClikSubscription.cancel();
      _documentClikSubscription = null;
    }
  }
  
  
  @reflectable
  void openCloseDropDown(MouseEvent event, detilas, target) {

  _computeOffset();
  
   if (useAnimation) {
     if (showDropDown) {
       _animator.animateCollapse();
     }else {
       //avoid blinks
       dropDownDiv.style.marginTop = "-9999px";
       callLater(_animator.animateExpand, ms: 20);
       showDropDown = true;
     }
     
   }else {
     showDropDown = !showDropDown;
   }
  }
  
  @reflectable
  void onSelectionChange(CustomEvent event) {
    Selector selector = event.target as Selector;
    selectedValues = selector.selectedValues;
  }
  
  @reflectable
  void selectedValuesChanged() {
    selectedItems = computeSelectedItems();
    computeSelectionLabel();  
  }
  
  @reflectable
  void computeSelectionLabel() {
   
    if (selectionLabelSpan != null) {
      String str = "";
      
      if (isAllSelected()) {
        str = "All selected";
      }else{
        for (int i = 0; i< selectedItems.length; i++){
          MenuItem item = selectedItems[i];
          if (i > 0){
            str+= ", ";
          }
          str+= " ${item.label}";
        }
      }
      
      if (prompt != null && !prompt.isEmpty && selectedItems.isEmpty) {
        selectionLabel = prompt;
        selectionLabelSpan.classes.add("promptStyle");
      }else {
        selectionLabel = str;
        selectionLabelSpan.classes.remove("promptStyle");
      }
    }
  }
  
  @reflectable
  List<MenuItem> computeSelectedItems() => dataProvider.where((MenuItem item) => selectedValues.contains(item.value.toString())).toList();
  
  @reflectable
  bool isAllSelected() => computeSelectedItems().length == dataProvider.length;
  
  void _onComponentClick(MouseEvent event) {
    _componentClick = true;
  }
   
  void _onDocumentClick(MouseEvent event) {
    
    if (!_componentClick) {
      
      if (showDropDown) {
        showDropDown = false;
      }
    }
    _componentClick = false;
  }
 
  void _onCollapseAnimationComplete([event = null]) {
    showDropDown = false;
  }
  
  void _computeOffset() {
    final int gap = 4;
    Point thisOffset = documentOffset;
    Point mainDivOffset = _overlayManager.POPUP_OVERLAY != null ? _overlayManager.POPUP_OVERLAY.documentOffset : new Point(0, 0);
    Rectangle dropDoenBtnRect = dropDownBtnRect.getBoundingClientRect();
    Point resutlOffset = new Point(thisOffset.x - mainDivOffset.x, thisOffset.y - mainDivOffset.y + dropDoenBtnRect.height + gap);
    
    mainDiv.style.top = "${resutlOffset.y}px";
    mainDiv.style.left = "${resutlOffset.x}px";
  }
  
  OverlayManager get _overlayManager => new OverlayManager.instance();
  
 
  StreamSubscription _documentClikSubscription;
  
  Element mainDiv;
 
  Element dropDownDiv;
  
  ButtonElement dropDownBtnRect;
  
  SpanElement selectionLabelSpan;
 
  bool _componentClick = false;
  
  ExpandCollapseAnimator _animator;  
  
}