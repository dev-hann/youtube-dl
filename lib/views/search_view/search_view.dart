import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'search_view_model.dart';
import 'src/search_card_view.dart';

class SearchView extends StatelessWidget {
  SearchView({Key? key, required String searchTag})
      : _viewModel = SearchViewModel(searchTag),
        super(key: key);

  final SearchViewModel _viewModel;

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Hero(
        tag: _viewModel.searchTag,
        child: const Icon(Icons.search),
      ),
      title: Obx(() {
        return AnimatedOpacity(
          opacity: _viewModel.appBarOpacity,
          duration: const Duration(milliseconds: 300),
          child: TextField(
            controller: _viewModel.searchController,
            focusNode: _viewModel.searchFocus,
            onSubmitted: (_) {
              _viewModel.onTapSearch();
            },
          ),
        );
      }),
      actions: [
        Obx(() {
          return AnimatedOpacity(
            opacity: _viewModel.appBarOpacity,
            duration: const Duration(milliseconds: 300),
            child: IconButton(
              onPressed: _viewModel.onTapClose,
              icon: const Icon(Icons.close),
            ),
          );
        }),
      ],
    );
  }

  Widget _body() {
    Widget _listView() {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: _viewModel.items.length,
        itemBuilder: (_, index) {
          final _item = _viewModel.items[index];
          return Obx(() {
            return SearchCardView(
              item: _item,
              onTapDown: _viewModel.onTapDown,
              onTapPlay: _viewModel.onTapPlay,
              onTapStop: _viewModel.onTapStop,
              snapshot: _viewModel.snapshot(_item.videoId),
            );
          });
        },
      );
    }

    return Obx(() {
      if (_viewModel.isLoading) return const SizedBox();
      switch (_viewModel.state) {
        case ConnectionState.none:
          return const SizedBox();
        case ConnectionState.waiting:
        case ConnectionState.active:
          return const Center(child: CircularProgressIndicator());
        case ConnectionState.done:
          return _listView();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // _textField(),
              Expanded(child: _body()),
            ],
          ),
        ),
      ),
    );
  }
}
