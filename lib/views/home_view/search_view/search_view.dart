import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'search_view_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final SearchViewModel _viewModel = SearchViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.init();
  }

  Widget _textField() {
    return Row(
      children: [
        TextField(
          controller: _viewModel.searchController,
          onSubmitted: (_) {
            _viewModel.onTapSearch();
          },
        ),
        const SizedBox(width: 16),
        _submitButton(),
      ],
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: _viewModel.onTapSearch,
      child: const Text("search"),
    );
  }

  Widget _body() {
    Widget _listView() {
      return ListView.builder(
        itemCount: _viewModel.resultList.length,
        itemBuilder: (_,index){
          return Text("$index");
        },
      );
    }

    return Obx(() {
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _textField(),
          _body(),
        ],
      ),
    );
  }
}
