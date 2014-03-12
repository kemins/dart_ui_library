import 'package:polymer/polymer.dart';

import "package:ui_lib/ui_lib.dart";

import "dart:html";

@CustomTag('tree-view')
class TestView extends StackViewImpl{

  @observable
  List treeSelectorItems = toObservable([]);
  
  @observable
  List treeSelectedValues = toObservable([]);
  
  @observable
  List<MenuItem> treeSelectedItems;
  
  TestView.created(): super.created() {
  }
  
  @override
  void enteredView() {
    super.enteredView();
    
    populateTreeSelectorItems();
    
  }
  
  void populateTreeSelectorItems() {
    List<MenuItem> items = toObservable([]);
    
    for (int i = 1; i <= 6; i++) {

      MenuItem item1 = new MenuItem("$i", "Item $i");
      _populateChildren(item1, 3, "$i.", deepLevel: 2);
      
      items.add(item1);  
    }
    
    treeSelectorItems = items;
    
    callLater(() =>  treeSelectedValues = toObservable(["2", "2.1", "2.1.2", "10.3.1", "4.3.1"]));
  }
  
  void onTreeSelectionChange(Event event, details, target) {
    treeSelectedItems = target.selectedItems;
  }
  
  void _populateChildren(MenuItem item, int count, String prefix, {int deepLevel: 1}) {
    item.children = toObservable([]);
    for (int j = 1; j <= count; j++) {
      MenuItem child = new MenuItem("$prefix$j", "Item $prefix${j}");
      
      if (deepLevel > 1) {
        _populateChildren(child, count, "$prefix$j.", deepLevel: deepLevel-1);
      }
      
      item.children.add(child);
    }
  }
}