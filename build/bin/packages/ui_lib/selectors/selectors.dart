part of ui_lib;

abstract class Selector extends PolymerElement with ChangeNotifier  {

  Selector.created(): super.created() {
  }
  
  @override
  void enteredView() {
    super.enteredView();
    
    var allCovered = isAllSelected();
    
    if (_allSelected != allCovered) {
      _allSelected = allCovered;
      notifyPropertyChange(const Symbol('allSelected'), !allSelected, allSelected);
    }
    
    bindCssClass(mainHolder, "resizableBox", this, "resizable");
  }
  
  @reflectable @published
  String get width => __$width; String __$width; @reflectable set width(String value) { __$width = notifyPropertyChange(#width, __$width, value); }
  
  @reflectable @published
  bool get resizable => __$resizable; bool __$resizable = false; @reflectable set resizable(bool value) { __$resizable = notifyPropertyChange(#resizable, __$resizable, value); }
  
  @reflectable @published
  String get height => __$height; String __$height; @reflectable set height(String value) { __$height = notifyPropertyChange(#height, __$height, value); }
  
  @reflectable
  bool get allSelected => _allSelected;
  
  @reflectable
  void set allSelected(bool value) {
    
    if (allSelected != value) {
      bool oldValue = _allSelected;
      
      _allSelected = value;
      
      allSelected ? selectAll() : unselectAll();
      
      notifyPropertyChange(const Symbol('allSelected'), oldValue, allSelected);
      
    }
    
  }
  
  @published
  @reflectable
  List get dataProvider => _dataProvider;
  
  @reflectable
  void set dataProvider(List value) {
    
    removeListenerForSelectionChange();
    
    var oldValue = _dataProvider;
    _dataProvider = value;
    
    addListenerForSelectionChange(_dataProvider);
    
    notifyPropertyChange(const Symbol('dataProvider'), oldValue, _dataProvider);
    
  }
  
  @published
  @reflectable
  List<String> get selectedValues => _selectedValues;
  
  @reflectable
  List<MenuItem> get selectedItems => _selectedItems;
   
  @reflectable
  void set selectedValues(List<String> values) {

    var oldSelectedValues = _selectedValues;
    
   _selectedValues = values;
   
   if (_selectedValues != null) {
     callLater(() => selectValues(dataProvider));
     selectValues(dataProvider);
   }
   
   notifyPropertyChange(const Symbol('selectedValues'), oldSelectedValues, _selectedValues);
   
   
 }
 
  @reflectable
  void selectValues(List<MenuItem> inItems) {
   if (inItems != null) {
     for (MenuItem item in inItems) {
       if (_selectedValues.contains(item.value.toString())) {
         if (!item.selected) {
           item.selected = true;
         }
       }
     }
   }
  }
  
  void _selectionChangeHandler(data) {
    if (!_suspendSelectionChangeListening) {
      var oldSelectedItems = selectedItems;
      _selectedItems = computeSelectedItems().toList();
      
      var allCovered = isAllSelected(); 
      
      if (_allSelected != allCovered) {
        _allSelected = allCovered;
        notifyPropertyChange(const Symbol('allSelected'), !allSelected, allSelected);
      }
      
      var oldSelectedValues = selectedValues;
      List<String> newSelectedValues = [];
      _selectedItems.forEach((MenuItem item) => newSelectedValues.add(item.value));
      _selectedValues = newSelectedValues;
      
      notifyPropertyChange(const Symbol('selectedValues'), oldSelectedValues, _selectedValues);
      notifyPropertyChange(const Symbol('selectedItems'), oldSelectedItems, _selectedItems);
      
      dispatchEvent(new CustomEvent("selection-change", detail: _selectedValues, canBubble: true));
    }
  }
  
  @reflectable @published
  bool get multiSelectAllowed => __$multiSelectAllowed; bool __$multiSelectAllowed = true; @reflectable set multiSelectAllowed(bool value) { __$multiSelectAllowed = notifyPropertyChange(#multiSelectAllowed, __$multiSelectAllowed, value); }
  
 
  @reflectable
  Iterable computeSelectedItems() => dataProvider.where((MenuItem item) => item.selected);
  
  @reflectable
  bool isAllSelected() => computeSelectedItems().length == dataProvider.length;
  
  @reflectable
  void onSelectAllCheckBoxClick(MouseEvent event, target, details) {
  }
  
  @reflectable
  void selectAll() {
  }
  
  @reflectable
  void unselectAll() {
  }
  
  @reflectable
  MenuItem findItemByValue(String value, {List source}) {
    List lookupItems = source != null ? source : dataProvider;
    Iterable items = lookupItems.where((MenuItem item) => item.value.toString() == value);
    MenuItem item = items.isEmpty ? null : items.first;
    return item;
  }
  
  @reflectable
  void selectUnselectItemByValue(String value, {bool selected}) {
    MenuItem item = findItemByValue(value);
    
    if (selected != null) {
      item.selected = selected;  
    }else {
      item.selected = !item.selected;
    }
  }
  
  @override
  void attributeChanged(name, oldValue, newValue) {
    super.attributeChanged(name, oldValue, newValue);
    
    if (name == "width") {
      widthChangeHandler(oldValue, newValue);
    }else if (name == "height") {
      heightChangeHandler(oldValue, newValue);
    }
  }
  
  @reflectable
  void widthChangeHandler(String oldValue, String newValue) {
    
  }
  
  @reflectable
  void heightChangeHandler(oldValue, newValue) {
    
  }
  
  void addListenerForSelectionChange(List<MenuItem> items) {
    
    if (items != null) {
      
      StreamSubscription ss = new ListPathObserver(items, 'selected').changes.listen(_selectionChangeHandler);
      _dataProviderSubscriptions.add(ss);
    }
  }
  
  void removeListenerForSelectionChange() {
    _dataProviderSubscriptions.forEach((StreamSubscription ss) => ss.cancel());
    _dataProviderSubscriptions = [];
  }
  
  void suspendSelectionChangeListeners() {
    _suspendSelectionChangeListening = true;
  }
  
  void resumeSelectionChangeListeners() {
    void resume() {
      _suspendSelectionChangeListening = false;
      _selectionChangeHandler(null);
    }
    callLater(resume, ms: 20);
  }
  
  Element get mainHolder => $['mainHolder'];
  
  List _dataProvider = [];
  
  @reflectable
  List<StreamSubscription> _dataProviderSubscriptions = [];
  
  List<String> _selectedValues = [];
  
  List<MenuItem> _selectedItems = [];
  
  bool _allSelected = false;
  
  bool _suspendSelectionChangeListening = false;
  
}