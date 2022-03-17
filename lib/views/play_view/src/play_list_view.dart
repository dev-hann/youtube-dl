import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_dl/views/play_view/src/play_card_view.dart';
import 'package:youtube_dl/widget/dl_image/src/dl_background_photo.dart';
import 'play_list_view_model.dart';

class PlayListView extends StatelessWidget {
  PlayListView({Key? key}) : super(key: key);

  final PlayListViewModel _viewModel = PlayListViewModel();

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        "PlayList",
        style: Get.textTheme.headline2!.copyWith(color: Colors.white),
      ),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.close),
        )
      ],
    );
  }

  Widget _listView() {
    return Obx(() {
      return ReorderableListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemCount: _viewModel.dlList.length,
        itemBuilder: (_, index) {
          final item = _viewModel.dlList[index];
          return GestureDetector(
            key: ValueKey(index),
            onTap: () {
              _viewModel.onTapItem(item);
            },
            child: Card(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: PlayCardView(
                  item: item,
                  onTapMore: _viewModel.onTapMore,
                  isPlaying: _viewModel.isPlaying(item),
                ),
              ),
            ),
          );
        },
        onReorder: _viewModel.onReorder,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DlBackgroundPhoto(
        dl: _viewModel.currentItem,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _appBar(),
          body: _listView(),
        ),
      );
    });
  }
}
