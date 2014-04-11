import 'package:polymer/polymer.dart';

import "package:ui_lib/ui_lib.dart";


@CustomTag('widget-view')
class WidgetView extends StackViewImpl {

  @observable
  String src = "";
  
  WidgetView.created(): super.created() {
  }

  @override
  void enteredView() {
    super.enteredView();
  }

  @override
  void viewShown() {
    callLater(() => src = "widget.html", ms: 500);
  }

  @override
  void viewHidden() {
    src = "";
  }

}
