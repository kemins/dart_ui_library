import 'package:polymer/polymer.dart';
import 'package:ui_lib/ui_lib.dart';

import "tree_selector.dart";

import "dart:async";
import "dart:html";

@CustomTag("tree-selector-adv")
class TreeADV extends Tree with ChangeNotifier {
  
  static const NODE_INDENT = 20;
  
  @reflectable @observable
  List<MenuItem> get plainDataProvider => __$plainDataProvider; List<MenuItem> __$plainDataProvider = toObservable([]); @reflectable set plainDataProvider(List<MenuItem> value) { __$plainDataProvider = notifyPropertyChange(#plainDataProvider, __$plainDataProvider, value); }
  
  @reflectable @observable
  Map get indents => __$indents; Map __$indents = toObservable({}); @reflectable set indents(Map value) { __$indents = notifyPropertyChange(#indents, __$indents, value); }
  
  
  @reflectable @observable
  Map get nodeClasses => __$nodeClasses; Map __$nodeClasses = toObservable({}); @reflectable set nodeClasses(Map value) { __$nodeClasses = notifyPropertyChange(#nodeClasses, __$nodeClasses, value); }
  
  @reflectable @observable
  Map get styleLines => __$styleLines; Map __$styleLines = toObservable({}); @reflectable set styleLines(Map value) { __$styleLines = notifyPropertyChange(#styleLines, __$styleLines, value); }
  
  TreeADV.created(): super.created() {
    
  }
  
  @override
  void set dataProvider(List value) {
    super.dataProvider = value;
    
    List plainDP = [];
    
    if (dataProvider != null) {
      dataProvider.forEach(((MenuItem item) => _addItemToPlainList(item, plainDP)));
      plainDataProvider = toObservable(plainDP);
    }
    
  }
  
  @override
  void addListenerForSelectionChange(List<MenuItem> items) {
    super.addListenerForSelectionChange(items);
    if (items != null) {
      StreamSubscription ss = new ListPathObserver(items, 'collapsed').changes.listen(_collapsedChangeHandler);
      _collapsedSubscriptions.add(ss);
    }
  }
  
  @override
  void removeListenerForSelectionChange() {
    super.removeListenerForSelectionChange();
    _collapsedSubscriptions.forEach((StreamSubscription ss) => ss.cancel());
    _collapsedSubscriptions = [];
  }
  
  @override
  void enteredView() {
    super.enteredView();
  }
  
  void arrowClickHandler(MouseEvent event, details, Element target) {
    
    String id = target.id;
    String value = id.replaceAll("arrow", "");
    
    MenuItem item = findItemByValue(value, source: dataProvider);
    item.collapsed = !item.collapsed;
  }    
    
  void _addItemToPlainList(MenuItem item, List list, {int deepLevel: 0}) {
    list.add(item);
    
    nodeClasses[item] = item.collapsed ? "arrow-right-small close-node" : "arrow-down-small open-node";
    if (item.noChildren) {
      nodeClasses[item] = nodeClasses[item] +" emptyNode";
    }
    
    indents[item] = NODE_INDENT * deepLevel;
    if (!item.collapsed && item.children != null) {
      item.children.forEach((MenuItem child) => _addItemToPlainList(child, list, deepLevel: deepLevel + 1));
    }
  }
  
  void _collapsedChangeHandler(data) {
    List plainDP = [];
    dataProvider.forEach(((MenuItem item) => _addItemToPlainList(item, plainDP)));
    plainDataProvider.clear();
    plainDataProvider.addAll(plainDP);
  }
  
  List<StreamSubscription> _collapsedSubscriptions = [];
}