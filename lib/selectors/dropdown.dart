part of ui_lib;

abstract class DropDownSelector extends PolymerElement{
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
  
  @published
  String prompt = "Please select an item";
  
  @observable
  String selectionLabel = "";
  
  @published
  int animationDuration = 300;
  
  @published 
  bool useAnimation = true;
  
  @observable
  bool showDropDown = false;
  
  @published
  List<MenuItem> dataProvider = [];
  
  @published
  List<String> selectedValues = [];
  
  @published
  List<MenuItem> selectedItems = [];
  
  @published
  String dropDownWidth = "auto";
  
  @published
  String dropDownHeight = "auto";
  
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