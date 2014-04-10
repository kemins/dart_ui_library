part of ui_lib;

class MenuItem extends Object with ChangeNotifier {
  MenuItem(value, label) : __$value = value, __$label = label {
    onPropertyChange(this, new Symbol("collapsed"), () => notifyPropertyChange(new Symbol("expanded"), expanded, !expanded));
    onPropertyChange(this, new Symbol("collapsed"), () => notifyPropertyChange(new Symbol("expanded"), expanded, !expanded));
    onPropertyChange(this, new Symbol("children.length"), () => notifyPropertyChange(new Symbol("noChildren"), noChildren, !noChildren));
  }
  
  @reflectable @observable
  Object get value => __$value; Object __$value; @reflectable set value(Object value) { __$value = notifyPropertyChange(#value, __$value, value); }
  
  @reflectable @observable
  String get label => __$label; String __$label; @reflectable set label(String value) { __$label = notifyPropertyChange(#label, __$label, value); }
  
  @reflectable @observable
  bool get selected => __$selected; bool __$selected = false; @reflectable set selected(bool value) { __$selected = notifyPropertyChange(#selected, __$selected, value); }
  
  @reflectable @observable
  List<MenuItem> get children => __$children; List<MenuItem> __$children; @reflectable set children(List<MenuItem> value) { __$children = notifyPropertyChange(#children, __$children, value); }
  
  @reflectable @observable
  bool get collapsed => __$collapsed; bool __$collapsed = true; @reflectable set collapsed(bool value) { __$collapsed = notifyPropertyChange(#collapsed, __$collapsed, value); }
  
  @reflectable
  bool get expanded => !collapsed;
  
  @observable
  bool get noChildren => children == null || children.isEmpty;
  
  @reflectable
  void collapseAllChildren() {
    collapsed = true;
    if (!noChildren) {
      children.forEach((MenuItem item) => item.collapseAllChildren());
    }
  }
  
  @reflectable
  void expandAllChildren({bool expandItSelf: true}) {
    collapsed = !expandItSelf;
    if (!noChildren) {
      children.forEach((MenuItem item) => item.expandAllChildren());
    }
  }
  
  bool get isBranchSelected {
    bool res = selected;
    
    if (res) {
      if (children != null) {
        Iterable iterable = children.where((MenuItem item) => item.isBranchSelected);
        res = iterable.length == children.length;
      }
    }
   
    return res;
  }
  
}