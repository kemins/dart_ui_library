import 'package:polymer/polymer.dart';

import "package:ui_lib/ui_lib.dart";

import "dart:html";

@CustomTag('list-selector-view')
class ListSelectorTestView extends StackViewImpl with ChangeNotifier {

  @reflectable @observable
  List get listSelectorItems => __$listSelectorItems; List __$listSelectorItems = toObservable([]); @reflectable set listSelectorItems(List value) { __$listSelectorItems = notifyPropertyChange(#listSelectorItems, __$listSelectorItems, value); }
  
  @reflectable @observable
  List get listSingleSelectorItems => __$listSingleSelectorItems; List __$listSingleSelectorItems = toObservable([]); @reflectable set listSingleSelectorItems(List value) { __$listSingleSelectorItems = notifyPropertyChange(#listSingleSelectorItems, __$listSingleSelectorItems, value); }
  
  @reflectable @observable
  List get listSelectedValues => __$listSelectedValues; List __$listSelectedValues = toObservable([]); @reflectable set listSelectedValues(List value) { __$listSelectedValues = notifyPropertyChange(#listSelectedValues, __$listSelectedValues, value); }
  
  @reflectable @observable
  List<MenuItem> get listSelectedItems => __$listSelectedItems; List<MenuItem> __$listSelectedItems; @reflectable set listSelectedItems(List<MenuItem> value) { __$listSelectedItems = notifyPropertyChange(#listSelectedItems, __$listSelectedItems, value); }
  
  @reflectable @observable
  MenuItem get listSingleSelectorSelectedItem => __$listSingleSelectorSelectedItem; MenuItem __$listSingleSelectorSelectedItem; @reflectable set listSingleSelectorSelectedItem(MenuItem value) { __$listSingleSelectorSelectedItem = notifyPropertyChange(#listSingleSelectorSelectedItem, __$listSingleSelectorSelectedItem, value); }
  
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