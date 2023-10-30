import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scg_test_app/modules/news_list/models/articles.dart';
import 'package:scg_test_app/modules/news_list/repository/news.dart';

part 'news_list_event.dart';
part 'news_list_state.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  NewsListBloc(this._newsRepository)
      : super(const NewsListState(articles: [])) {
    on<GetNews>(_onGetNews);
  }
  final NewsRepository _newsRepository;
  void _onGetNews(
    GetNews event,
    Emitter<NewsListState> emit,
  ) async {
    await _onLoadContents(emit);
  }

  Future<void> _onLoadContents(
    Emitter<NewsListState> emit,
  ) async {
    emit(state.copyWith(
      loading: true,
    ));
    final news = await _newsRepository.getNews();
    emit(state.copyWith(
      loading: false,
      articles: news.articles,
    ));
  }
}
