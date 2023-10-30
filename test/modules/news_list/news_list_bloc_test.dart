import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:scg_test_app/modules/news_list/bloc/news_list_bloc.dart';
import 'package:scg_test_app/modules/news_list/models/articles.dart';
import 'package:scg_test_app/modules/news_list/models/news.dart';
import 'package:scg_test_app/modules/news_list/repository/news.dart';

void main() {
  group('NewsListBloc', () {
    late NewsRepository newsRepository;
    late NewsListBloc newsListBloc;
    const News news = News(
      status: 'ok',
      totalResult: 2,
      articles: [
        Articles(
          title: 'Test Title 1',
          description: 'Test Description 1',
          url: 'https://example.com/1',
          urlToImage: 'https://example.com/image1.jpg',
          publishedAt: '2023-01-01T12:00:00Z',
          content: 'Test Content 1',
        ),
        Articles(
          title: 'Test Title 2',
          description: 'Test Description 2',
          url: 'https://example.com/2',
          publishedAt: '2023-01-02T12:00:00Z',
          content: 'Test Content 2',
        ),
      ],
    );

    setUp(() {
      newsRepository = NewsRepositoryMock();
      newsListBloc = NewsListBloc(newsRepository);
    });

    tearDown(() {
      newsListBloc.close();
    });

    blocTest<NewsListBloc, NewsListState>(
      'emits loading success when GetNews is added and repository returns data',
      build: () {
        when(() => newsRepository.getNews()).thenAnswer((_) async => news);
        return newsListBloc;
      },
      act: (bloc) => bloc.add(const GetNews()),
      wait: const Duration(milliseconds: 3000),
      expect: () => [
        const NewsListState(articles: [], loading: true),
        NewsListState(articles: news.articles, loading: false),
      ],
    );
  });
}

class NewsRepositoryMock extends Mock implements NewsRepository {}
