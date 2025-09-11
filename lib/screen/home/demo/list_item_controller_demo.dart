import 'package:note_app/base/widget/list/base_list_controller.dart';

class ListItemDemoController extends BaseListController<String> {
  ListItemDemoController(super.state);

  @override
  Future<List<String>> getItems(int page, int limit) async {
    await Future.delayed(const Duration(seconds: 2));
    return List.generate(limit, (index) => '1233');
  }
}
