import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'search_view_model.dart';
import 'src/search_card_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>
    with AutomaticKeepAliveClientMixin {
  final SearchViewModel _viewModel = SearchViewModel();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _viewModel.init();
  }

  Widget _textField() {
    Widget _submitButton() {
      return ElevatedButton(
        onPressed: _viewModel.onTapSearch,
        child: const Text("search"),
      );
    }

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _viewModel.searchController,
            focusNode: _viewModel.searchFocus,
            onSubmitted: (_) {
              _viewModel.onTapSearch();
            },
          ),
        ),
        const SizedBox(width: 16),
        _submitButton(),
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
              progress: _viewModel.progress(_item.videoId),
            );
          });
        },
      );
    }

    return Obx(() {
      if (_viewModel.isLoading) return SizedBox();
      switch (_viewModel.state) {
        case ConnectionState.none:
          return SizedBox();
        case ConnectionState.waiting:
        case ConnectionState.active:
          return Center(child: CircularProgressIndicator());
        case ConnectionState.done:
          return _listView();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _textField(),
            Expanded(child: _body()),
          ],
        ),
      ),
    );
  }
}
