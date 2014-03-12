part of ui_lib;

class MenuItem extends Object with Observable {
  MenuItem(this.value, this.label) {
    onPropertyChange(this, new Symbol("collapsed"), () => notifyPropertyChange(new Symbol("expanded"), expanded, !expanded));
    onPropertyChange(this, new Symbol("collapsed"), () => notifyPropertyChange(new Symbol("expanded"), expanded, !expanded));
    onPropertyChange(this, new Symbol("children.length"), () => notifyPropertyChange(new Symbol("noChildren"), noChildren, !noChildren));
  }
  
  @observable
  Object value;
  
  @observable
  String label;
  
  @observable
  bool selected = false;
  
  @observable
  List<MenuItem> children;
  
  @observable
  bool collapsed = true;
  
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