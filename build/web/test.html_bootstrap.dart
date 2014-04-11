library app_bootstrap;

import 'package:polymer/polymer.dart';

import 'package:ui_lib/navigators/view_stack.dart' as i0;
import 'package:ui_lib/selectors/list_selector.dart' as i1;
import 'package:ui_lib/selectors/treeSelectorClasses/tree_selector_node.dart' as i2;
import 'package:ui_lib/selectors/tree_selector.dart' as i3;
import 'package:ui_lib/selectors/tree_selector_adv.dart' as i4;
import 'tree_view.dart' as i5;
import 'list_selector_view.dart' as i6;
import 'package:ui_lib/selectors/multi_select_dropdown.dart' as i7;
import 'package:ui_lib/selectors/tree_dropdown.dart' as i8;
import 'dropdown_view.dart' as i9;
import 'package:ui_lib/bars/button_bar.dart' as i10;
import 'button_bar_view.dart' as i11;
import 'package:ui_lib/navigators/stack_view.dart' as i12;
import 'view-stack-test-view.dart' as i13;
import 'package:ui_lib/bars/progress_bar.dart' as i14;
import 'progress_bar_view.dart' as i15;
import 'package:ui_lib/navigators/accordion.dart' as i16;
import 'package:ui_lib/navigators/accordion_view.dart' as i17;
import 'accordion_test_view.dart' as i18;
import 'widget_example_view.dart' as i19;
import 'test_view.dart' as i20;
import 'main.dart' as i21;

void main() {
  configureForDeployment([
      'package:ui_lib/navigators/view_stack.dart',
      'package:ui_lib/selectors/list_selector.dart',
      'package:ui_lib/selectors/treeSelectorClasses/tree_selector_node.dart',
      'package:ui_lib/selectors/tree_selector.dart',
      'package:ui_lib/selectors/tree_selector_adv.dart',
      'tree_view.dart',
      'list_selector_view.dart',
      'package:ui_lib/selectors/multi_select_dropdown.dart',
      'package:ui_lib/selectors/tree_dropdown.dart',
      'dropdown_view.dart',
      'package:ui_lib/bars/button_bar.dart',
      'button_bar_view.dart',
      'package:ui_lib/navigators/stack_view.dart',
      'view-stack-test-view.dart',
      'package:ui_lib/bars/progress_bar.dart',
      'progress_bar_view.dart',
      'package:ui_lib/navigators/accordion.dart',
      'package:ui_lib/navigators/accordion_view.dart',
      'accordion_test_view.dart',
      'widget_example_view.dart',
      'test_view.dart',
      'main.dart',
    ]);
  i21.main();
}
