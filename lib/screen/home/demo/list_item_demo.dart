import 'package:flutter/material.dart';
import 'package:note_app/base/widget/list/base_list_view.dart';
import 'package:note_app/screen/home/demo/list_item_controller_demo.dart';

class ListItemDemo extends StatefulWidget {
  const ListItemDemo({super.key});

  @override
  State<ListItemDemo> createState() => _ListItemDemoState();
}

class _ListItemDemoState
    extends BaseListViewState<ListItemDemo, String, ListItemDemoController> {
  @override
  Widget buildItems(int index, String item) {
    return Text(item);
  }

  @override
  Widget buildSeperator() => SizedBox(height: 24);

  @override
  ListItemDemoController initController() => ListItemDemoController(this);
}
