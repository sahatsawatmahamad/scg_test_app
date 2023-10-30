import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scg_test_app/modules/search/models/articles.dart';

import 'package:scg_test_app/modules/search/repository/search_news.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._searchNewsRepository)
      : super(const SearchState(articles: [])) {
    on<GetSearchNews>(_onGetSearchNews);
  }
  final SearchNewsRepository _searchNewsRepository;

  Future<void> _onGetSearchNews(
    GetSearchNews event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(
      loading: true,
    ));
    if (event.keyword != "") {
      final news = await _searchNewsRepository.getSearchNews(event.keyword);
      emit(state.copyWith(
        loading: false,
        articles: news.articles,
      ));
    } else {
      emit(state.copyWith(
        loading: false,
        articles: [],
      ));
    }
  }
}
