import 'package:polymer/polymer.dart';
import 'package:ui_lib/ui_lib.dart';

import "dart:html";


@CustomTag("tree-selector")
class Tree extends Selector{
  
  Tree.created(): super.created() {
    
  }
  
  void enteredView() {
    super.enteredView();
    
    _mainHolder = $['mainHolder'];
    _childHolder = $['childHolder'];
    
    _initAttributes();
  }
  
  @published
  bool showExpandCollapseAll = true;
  
  @override
  MenuItem findItemByValue(String value, {List source}) {
    MenuItem res;
    
    List lookupItems = source != null ? source : dataProvider;
    
    for (MenuItem item in lookupItems) {
      if (item.value == value) {
        res = item;
        break;
      }
      
      if (item.children != null) {
        res = findItemByValue(value, source: item.children);
        
        if (res != null){
          break;
        }
      }
    }
    return res;
  }
  
  
  @override
  void selectAll() {
    suspendSelectionChangeListeners();
    dataProvider.forEach(_selectAll);
    resumeSelectionChangeListeners();
  }
  
  @override
  void unselectAll() {
    suspendSelectionChangeListeners();
    dataProvider.forEach(_unselectAll);
    resumeSelectionChangeListeners();
  }
  
  Iterable computeSelectedBranches() => dataProvider.where((MenuItem item) => item.isBranchSelected); 
  
  @override
  bool isAllSelected() => computeSelectedBranches().length == dataProvider.length;
  
  @override
  Iterable computeSelectedItems() => computeSlectedItems(dataProvider);
  
  @override
  void selectValues(List<MenuItem> items) {
    super.selectValues(items);
  
    if (items != null)
    {
      items.forEach((MenuItem item) => selectValues(item.children));
    }
  }
  
  @override
  void addListenerForSelectionChange(List<MenuItem> items) {
   super.addListenerForSelectionChange(items);
   
   if (items != null) {
     items.forEach((MenuItem item) => addListenerForSelectionChange(item.children));
   }
   
  }
  
  @override
  void widthChangeHandler(String oldValue, String newValue) {
    super.widthChangeHandler(oldValue, newValue);
    if (_mainHolder != null) {
      _mainHolder.style.width = newValue;
    }
  }
  
  @override
  void heightChangeHandler(String oldValue, String newValue) {
    super.heightChangeHandler(oldValue, newValue);
    if (_mainHolder != null) {
      _mainHolder.style.height = height;
    }
  }
  
  void expandAll() {
    List<MenuItem> items = dataProvider;
    dataProvider = null;
    items.forEach((MenuItem item) => item.expandAllChildren());
    dataProvider = items;
  }
  
  void collapseAll() {
    dataProvider.forEach((MenuItem item) => item.collapseAllChildren());
  }
  
  void _selectAll(MenuItem item) {
    item.selected = true;
    
    if (item.children != null) {
      item.children.forEach(_selectAll);
    }
  }
  
  void _unselectAll(MenuItem item) {
    item.selected = false;
    
    if (item.children != null) {
      item.children.forEach(_unselectAll);
    }
  }
  
  void _initAttributes() {
    if (width != null && width.isNotEmpty) {
      
      _mainHolder.style.width = width; 
    }
    
    if (height != null && height.isNotEmpty) {
     _mainHolder.style.height = height;
    }
  }
  
  static Iterable computeSlectedItems(List<MenuItem> items) {
    List<MenuItem> res = [];
    
    MenuItem item;
    
    if (items != null) {
      
      for (MenuItem item in items) {
        if (item.selected) {
          res.add(item);
        }
        res.addAll(computeSlectedItems(item.children));
      }
    }
    
    return res;
  }
  
  
  DivElement _mainHolder;
  
  DivElement _childHolder;
  
}