part of 'search_bloc.dart';

class SearchState extends Equatable {
  final List<Articles> articles;
  final bool loading;

  const SearchState({
    required this.articles,
    this.loading = false,
  });

  SearchState copyWith({
    List<Articles>? articles,
    bool? loading,
  }) {
    return SearchState(
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
