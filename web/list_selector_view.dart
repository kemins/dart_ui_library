import 'package:polymer/polymer.dart';

import "package:ui_lib/ui_lib.dart";

import "dart:html";

@CustomTag('list-selector-view')
class ListSelectorTestView extends StackViewImpl{

  @observable
  List listSelectorItems = toObservable([]);
  
  @observable
  List listSingleSelectorItems = toObservable([]);
  
  @observable
  List listSelectedValues = toObservable([]);
  
  @observable
  List<MenuItem> listSelectedItems;
  
  @observable
  MenuItem listSingleSelectorSelectedItem;
  
  ListSelectorTestView.created(): super.created() {
  }
  
  @override
  void enteredView() {
    super.enteredView();
    
    populateSelectorItems();
    populateSingleSelectorItems();
    
  }
  
  void populateSelectorItems() {
    List<MenuItem> items = toObservable([]);
    
    for (int i = 1; i <= 10; i++) {

      MenuItem item1 = new MenuItem("$i", "Item $i");
      
      items.add(item1);  
    }
    
    listSelectorItems = items;
    
    callLater(() =>  listSelectedValues = toObservable(["3", "5", "10"]));
  }
  
  void populateSingleSelectorItems() {
      List<MenuItem> items = toObservable([]);
      
      for (int i = 1; i <= 10; i++) {

        MenuItem item1 = new MenuItem("$i", "Item $i");
        
        items.add(item1);  
      }
      
      listSingleSelectorItems = items;
  }
  
  void onListSelectionChange(Event event, details, target) {
    listSelectedItems = target.selectedItems;
  }
  
  void onListSingleSelectionChange(Event event, details, target) {
    listSingleSelectorSelectedItem = target.selectedItems.isEmpty ? null : target.selectedItems[0];
  }
  
}