part of 'news_list_bloc.dart';

class NewsListState extends Equatable {
  final List<Articles> articles;
  final bool loading;

  const NewsListState({
    required this.articles,
    this.loading = false,
  });

  NewsListState copyWith({
    List<Articles>? articles,
    bool? loading,
  }) {
    return NewsListState(
      articles: articles ?? this.articles,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object> get props => [
        articles,
        loading,
      ];
}
