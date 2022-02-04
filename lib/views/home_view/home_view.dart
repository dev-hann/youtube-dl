import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_dl/views/mini_play_view/mini_play_view.dart';

import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  final HomeViewModel _viewModel = HomeViewModel();

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: const Text("JYPlayer"),
      leading: GestureDetector(
        onTap: _viewModel.onTapLeading,
        child: const Icon(
          Icons.list,
          // color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: _viewModel.onTapSearch,
          icon: Hero(
            tag: _viewModel.searchTag,
            child: const Icon(Icons.search),
          ),
        ),
      ],
    );
  }

  Widget _drawer() {
    Widget _drawerButton({
      required String label,
      required IconData iconData,
      required VoidCallback onTap,
    }) {
      return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              Icon(iconData, size: 24),
              const SizedBox(width: 8),
              Text(label, style: Get.textTheme.bodyText1),
            ],
          ),
        ),
      );
    }

    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: ColoredBox(
              color: Colors.red.withOpacity(.5),
              child: const SizedBox.expand(),
            ),
          ),
          Expanded(
            flex: 7,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _drawerButton(
                    onTap: () {
                      Get.back();
                    },
                    label: "Download",
                    iconData: Icons.download),
                _drawerButton(
                  onTap: () {
                    Get.back();
                  },
                  label: "Option",
                  iconData: Icons.settings,
                ),
                _drawerButton(
                  onTap: () {
                    Get.back();
                  },
                  label: "Close",
                  iconData: Icons.close,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _viewModel.scaffoldKey,
      appBar: _appBar(),
      bottomNavigationBar: MiniPlayView(),
      drawer: _drawer(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
