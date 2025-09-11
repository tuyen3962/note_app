import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import 'package:note_app/base/stream/base_stream_builder.dart';
import 'package:note_app/base/stream/load_more_delegate_custom.dart';
import 'package:note_app/base/widget/base_view.dart';
import 'package:note_app/base/widget/list/base_list_controller.dart';

mixin BaseListViewMixin<S extends StatefulWidget, M,
    C extends BaseListController<M>> on BaseViewState<S, C> {
  Widget buildListItems() {
    return TwoBaseListStreamBuilder<bool, M>(
      firstController: controller.isLoading,
      secondController: controller.items,
      builder: (loading, values) => loading
          ? buildLoading()
          : RefreshIndicator(
              onRefresh: controller.onRefresh,
              child: LoadMore(
                onLoadMore: controller.loadMore,
                delegate: const LoadMoreDelegateCustom(),
                isFinish: !controller.canLoadMore,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        buildItems(index, values[index]),
                    separatorBuilder: (context, index) => buildSeperator(),
                    itemCount: values.length),
              ),
            ),
    );
  }

  Widget buildLoading() => const Center(child: CircularProgressIndicator());

  Widget buildItems(int index, M item);

  Widget buildSeperator();
}
