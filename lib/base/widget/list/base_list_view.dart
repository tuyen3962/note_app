import 'package:flutter/material.dart';
import 'package:note_app/base/widget/base_page.dart';
import 'package:note_app/base/widget/list/base_list_controller.dart';
import 'package:note_app/base/widget/list/mixin_list_view.dart';

abstract class BaseListViewState<S extends StatefulWidget, M,
        C extends BaseListController<M>> extends BasePageState<S, C>
    with BaseListViewMixin<S, M, C> {
  @override
  Widget build(BuildContext context) {
    return buildListItems();
  }
}
