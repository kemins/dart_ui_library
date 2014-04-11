import 'package:polymer/polymer.dart';

import "package:ui_lib/ui_lib.dart";
import "package:ui_lib/managers.dart" as managers;
import "dart:html";

import "package:ui_lib/selectors/list_selector.dart" as selectors;


@CustomTag('test-view')
class TestView extends PolymerElement with ChangeNotifier {

  @reflectable @observable
  List get menuItems => __$menuItems; List __$menuItems = toObservable([]); @reflectable set menuItems(List value) { __$menuItems = notifyPropertyChange(#menuItems, __$menuItems, value); }
  
  
  @reflectable @observable
  int get selectedIndex => __$selectedIndex; int __$selectedIndex = 0; @reflectable set selectedIndex(int value) { __$selectedIndex = notifyPropertyChange(#selectedIndex, __$selectedIndex, value); }

  
  TestView.created(): super.created() {
  }
  
  @override
  void enteredView() {
    super.enteredView();
    configOverlays();
    populateMenuItems();
    
    menu = $['menu'];
    callLater(() => menu.selectedValues = ['0']);
    onPropertyChange(menu, #selectedValues, onMenuChange);
  }
  
  void configOverlays() {
    Element popupOverlay = window.document.querySelector("#popupOverlay");
    managers.OverlayConfig overlayConfig = new managers.OverlayConfig(popupOverlay);
    new managers.OverlayManager.instance().init(overlayConfig);
  }
  
  void populateMenuItems() {
    MenuItem item = new MenuItem('0', "Selectors");
    menuItems.add(item);  
    item = new MenuItem('1', "Drop Downs");
    menuItems.add(item);
    item = new MenuItem('2', "Tree Component");
    menuItems.add(item);
    item = new MenuItem('3', "Button Bar");
    menuItems.add(item);
    item = new MenuItem('4', "View Stack");
    menuItems.add(item);
    item = new MenuItem('5', "Progress Bar");
    menuItems.add(item);
    item = new MenuItem('6', "Accordion");
    menuItems.add(item);
    item = new MenuItem('7', "Widget Example");
    menuItems.add(item);
  }
  
  void onMenuChange() {
    String selectedValue = menu.selectedValues.isEmpty ? null : menu.selectedValues[0];
    selectedIndex = selectedValue == null ? 0 : int.parse(selectedValue);
  }
  
  selectors.ListSelector menu;  
}