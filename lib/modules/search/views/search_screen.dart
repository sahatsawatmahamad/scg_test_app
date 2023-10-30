import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:scg_test_app/modules/news_detail/views/news_details_screen.dart';
import 'package:scg_test_app/modules/news_list/views/widgets/image_list.dart';
import 'package:scg_test_app/modules/search/bloc/search_bloc.dart';
import 'package:scg_test_app/utils/screen_wrapper.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.onChange});
  final void Function(String)? onChange;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController searchController = SearchController();
  final ScrollController _scrollController = ScrollController();
  String searchText = "";
  Timer _debounce = Timer(const Duration(microseconds: 0), () {});
  _performSearch(String query) {
    if (widget.onChange != null) {
      widget.onChange!(query);
    }
  }

  _onSearchChanged(String query) {
    if (_debounce.isActive) {
      _debounce.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        appBar: AppBar(
          title: const Text('Search '),
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                TextField(
                  autofocus: true,
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.text,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    hintText: 'Type Something...',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w300,
                    ),
                    suffixIcon: const Icon(
                      Icons.search,
                      size: 25,
                      color: Color.fromRGBO(113, 128, 150, 1),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blueGrey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 0.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                BlocBuilder<SearchBloc, SearchState>(
                  bloc: Modular.get<SearchBloc>(),
                  buildWhen: (previous, current) =>
                      previous.loading != current.loading ||
                      previous.articles != current.articles,
                  builder: (context, state) {
                    if (state.loading) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    } else {
                      return state.articles.isEmpty
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'Type something or Data not found, Please try again.'),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: state.articles.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                DateTime updatedDateTime = DateTime.parse(
                                    state.articles[index].publishedAt);
                                String updatedDateString =
                                    DateFormat('MMM dd, HH:mm')
                                        .format(updatedDateTime);
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(13)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF303030)
                                                .withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(1, 1),
                                          ),
                                        ]),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NewsDetailsScreen(
                                                    title: state
                                                        .articles[index].title,
                                                    description: state
                                                        .articles[index]
                                                        .description,
                                                    imageUrl: state
                                                            .articles[index]
                                                            .urlToImage ??
                                                        "",
                                                    url: state
                                                        .articles[index].url,
                                                    updateDate: state
                                                        .articles[index]
                                                        .publishedAt,
                                                  )),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          ImageList(
                                            imageUrl: state.articles[index]
                                                    .urlToImage ??
                                                "",
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              state.articles[index].title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall
                                                  ?.copyWith(
                                                      fontSize: 20,
                                                      color: Colors.blueGrey),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              state.articles[index].description,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall
                                                  ?.copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Updated: $updatedDateString',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall
                                                  ?.copyWith(
                                                      fontSize: 14,
                                                      color: Colors.grey),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
