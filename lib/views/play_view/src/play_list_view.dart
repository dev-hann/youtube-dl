import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:youtube_dl/views/mini_play_view/mini_play_view.dart';
import 'package:youtube_dl/views/play_view/src/play_card_view.dart';

import 'play_list_view_model.dart';

class PlayListView extends StatelessWidget {
  PlayListView({Key? key}) : super(key: key);
  final PlayListViewModel _viewModel = PlayListViewModel();

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        "PlayList",
        style: TextStyle(color: Colors.black),
      ),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Ionicons.close,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  Widget _listView() {
    return Obx(() {
      return ReorderableListView.builder(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemCount: _viewModel.selectedList.length,
        itemBuilder: (_, index) {
          final item = _viewModel.selectedList[index];
          return Dismissible(
            direction: DismissDirection.endToStart,
            onDismissed: _viewModel.onDelete,
            confirmDismiss: _viewModel.confirmDelete,
            background: const ColoredBox(
              color: Colors.redAccent,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Delete",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            key: ValueKey(index),
            child: GestureDetector(
              onTap: () {
                _viewModel.onTapItem(item);
              },
              child: Card(
                child: PlayCardView(
                  item: item,
                  onTapPlay: (item) {},
                ),
              ),
            ),
          );
        },
        onReorder: (oldIndex, newIndex) {
          print(oldIndex);
          print(newIndex);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _listView(),
      bottomNavigationBar: MiniPlayView(),
    );
  }
}
