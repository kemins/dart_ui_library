import 'package:polymer/polymer.dart';

import 'package:ui_lib/ui_lib.dart';

import "dart:html";


@CustomTag('tree-dropdown')
class TreeDropDwon extends DropDownSelector{
 
  TreeDropDwon.created() : super.created();
  
  @published
  bool multiSelectAllowed = true;
  
  void enteredView() {
    super.enteredView();
  }
  
  @override
  List<MenuItem> computeSelectedItems() => _computeSelectedItems(dataProvider);
   
  
  @override
  bool isAllSelected() => selectedItems.length == _calculateChildrenCount(dataProvider);
  
  @reflectable
  List<MenuItem> _computeSelectedItems(List items) {
    List<MenuItem> res = [];
    
    for (MenuItem item in items) {
      
      if (selectedValues.contains(item.value.toString())) {
        res.add(item);
        
        if (item.children != null) {
          res.addAll(_computeSelectedItems(item.children));
        }
      }
    }
    
    return res;
  }
  
  @reflectable
  int _calculateChildrenCount(List items) {
    int res = items.length;
    
    for (MenuItem item in items) {
      
      if (item.children != null) {
        res+= _calculateChildrenCount(item.children);  
      }
    }
    
    return res;
  }
  
  DivElement get _divDropDowm => $['divDropDowm'];
      
}