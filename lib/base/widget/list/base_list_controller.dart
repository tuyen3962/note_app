import 'package:note_app/base/stream/base_list_stream_controller.dart';
import 'package:note_app/base/stream/base_stream_controller.dart';
import 'package:note_app/base/widget/base_controller.dart';

abstract class BaseListController<M> extends BaseController {
  BaseListController(super.state);

  int get startPage => 1;
  var _page = 0;
  final limit = 20;
  final isLoading = BaseStreamController(false);
  final items = BaseListStreamController<M>([]);
  bool canLoadMore = true;

  @override
  void onInit() {
    onRefresh();
  }

  @override
  void onDispose() {
    isLoading.dispose();
    items.dispose();
    super.onDispose();
  }

  Future<List<M>> getItems(int page, int limit);

  Future<void> onRefresh() async {
    _page = startPage;
    isLoading.value = true;
    final result = await getItems(_page, limit);
    items.value = result;
    canLoadMore = result.length == limit;
    isLoading.value = false;
  }

  Future<bool> loadMore() async {
    final currentPage = startPage == 1 ? _page : _page + 1;
    if (items.length < currentPage * limit) {
      canLoadMore = false;
      return false;
    }
    _page += 1;
    final result = await getItems(_page, limit);
    items.addAll(result);
    canLoadMore = result.length == limit;
    return canLoadMore;
  }
}
