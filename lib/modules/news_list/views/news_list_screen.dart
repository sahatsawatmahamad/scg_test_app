import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:scg_test_app/modules/news_detail/views/news_details_screen.dart';
import 'package:scg_test_app/modules/news_list/bloc/news_list_bloc.dart';
import 'package:scg_test_app/modules/news_list/views/widgets/image_list.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Apple News',
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontSize: 24, color: Colors.black),
          ),
        ),
        BlocBuilder<NewsListBloc, NewsListState>(
          bloc: Modular.get<NewsListBloc>(),
          buildWhen: (previous, current) =>
              previous.loading != current.loading ||
              previous.articles != current.articles,
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: state.articles.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DateTime updatedDateTime =
                      DateTime.parse(state.articles[index].publishedAt);
                  String updatedDateString =
                      DateFormat('MMM dd, HH:mm').format(updatedDateTime);
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(13)),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF303030).withOpacity(0.1),
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
                                builder: (context) => NewsDetailsScreen(
                                      title: state.articles[index].title,
                                      description:
                                          state.articles[index].description,
                                      imageUrl:
                                          state.articles[index].urlToImage ??
                                              "",
                                      url: state.articles[index].url,
                                      updateDate:
                                          state.articles[index].publishedAt,
                                    )),
                          );
                        },
                        child: Column(
                          children: [
                            ImageList(
                              imageUrl: state.articles[index].urlToImage ?? "",
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
                                        fontSize: 20, color: Colors.blueGrey),
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
                                        fontSize: 16, color: Colors.black),
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
                                        fontSize: 14, color: Colors.grey),
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
    );
  }
}
