import 'package:polymer/polymer.dart';

import "package:ui_lib/ui_lib.dart";

@CustomTag('dropdown-view')
class DropdownView extends StackViewImpl with ChangeNotifier {

  @reflectable @observable
  List get multiselectorItems => __$multiselectorItems; List __$multiselectorItems = toObservable([]); @reflectable set multiselectorItems(List value) { __$multiselectorItems = notifyPropertyChange(#multiselectorItems, __$multiselectorItems, value); }
  
  @reflectable @observable
  List get treeItems => __$treeItems; List __$treeItems = toObservable([]); @reflectable set treeItems(List value) { __$treeItems = notifyPropertyChange(#treeItems, __$treeItems, value); }
  
  @reflectable @observable
  List get multiselectorSelectedItems => __$multiselectorSelectedItems; List __$multiselectorSelectedItems = toObservable([]); @reflectable set multiselectorSelectedItems(List value) { __$multiselectorSelectedItems = notifyPropertyChange(#multiselectorSelectedItems, __$multiselectorSelectedItems, value); }
  
  @reflectable @observable
  List get treeSelectedItems => __$treeSelectedItems; List __$treeSelectedItems = toObservable([]); @reflectable set treeSelectedItems(List value) { __$treeSelectedItems = notifyPropertyChange(#treeSelectedItems, __$treeSelectedItems, value); }
  
  @reflectable @observable
  List get multiselectorSelectedValues => __$multiselectorSelectedValues; List __$multiselectorSelectedValues = toObservable([]); @reflectable set multiselectorSelectedValues(List value) { __$multiselectorSelectedValues = notifyPropertyChange(#multiselectorSelectedValues, __$multiselectorSelectedValues, value); }
  
  @reflectable @observable
  List get treeSelectedValues => __$treeSelectedValues; List __$treeSelectedValues = toObservable([]); @reflectable set treeSelectedValues(List value) { __$treeSelectedValues = notifyPropertyChange(#treeSelectedValues, __$treeSelectedValues, value); }
  
  
  DropdownView.created(): super.created() {
  }
  
  @override
  void enteredView() {
    super.enteredView();
  }
  
  @override
  void viewShown() {
    super.viewShown();

    populateSelectorItems();
    populateSingleSelectorItems();
    
    populateTreeSelectorItems();
    
    var multiSelector = shadowRoot.querySelector('#multiSelector');
    bindProperty(#multiselectorSelectedItems, multiSelector, "selectedItems");
    
    var treeSelector = shadowRoot.querySelector('#treeSelector');
    bindProperty(#treeSelectedItems, treeSelector, "selectedItems");
  }
  
  void viewHidden() {
    super.viewHidden();
    unbindAllProperties();
  }
  
  void populateSelectorItems() {
    List<MenuItem> items = toObservable([]);
    
    for (int i = 1; i <= 10; i++) {

      MenuItem item1 = new MenuItem("$i", "Item $i");
      
      items.add(item1);  
    }
    
    multiselectorItems = items;
    multiselectorSelectedValues = toObservable(["3", "5", "10"]);
  }
  
  void populateSingleSelectorItems() {
      List<MenuItem> items = toObservable([]);
      
      for (int i = 1; i <= 10; i++) {

        MenuItem item1 = new MenuItem("$i", "Item $i");
        
        items.add(item1);  
      }
      
  }
  
  void populateTreeSelectorItems() {
      List<MenuItem> items = toObservable([]);
      
      for (int i = 1; i <= 6; i++) {

        MenuItem item1 = new MenuItem("$i", "Item $i");
        _populateChildren(item1, 3, "$i.", deepLevel: 2);
        
        items.add(item1);  
      }
      
      treeItems = items;
      
      callLater(() =>  treeSelectedValues = toObservable(["2", "2.1", "2.1.2", "10.3.1", "4.3.1"]));
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