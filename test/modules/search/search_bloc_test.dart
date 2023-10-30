import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:scg_test_app/modules/search/bloc/search_bloc.dart';
import 'package:scg_test_app/modules/search/models/articles.dart';
import 'package:scg_test_app/modules/search/models/news.dart';
import 'package:scg_test_app/modules/search/repository/search_news.dart';

void main() {
  group('NewsListBloc', () {
    late SearchNewsRepository searchNewsRepository;
    late SearchBloc searchBloc;
    const String keyword = "test";
    const String nullKeyword = "";
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
      searchNewsRepository = SearchNewsRepositoryMock();
      searchBloc = SearchBloc(searchNewsRepository);
    });

    tearDown(() {
      searchBloc.close();
    });

    blocTest<SearchBloc, SearchState>(
      'emits loading success when search keyword and repository returns data',
      build: () {
        when(() => searchNewsRepository.getSearchNews(keyword))
            .thenAnswer((_) async => news);
        return searchBloc;
      },
      act: (bloc) => bloc.add(const GetSearchNews(keyword: keyword)),
      wait: const Duration(milliseconds: 3000),
      expect: () => [
        const SearchState(articles: [], loading: true),
        SearchState(articles: news.articles, loading: false),
      ],
    );
    blocTest<SearchBloc, SearchState>(
      'emits loading success when search empty keyword and repository returns data',
      build: () {
        return searchBloc;
      },
      act: (bloc) => bloc.add(const GetSearchNews(keyword: nullKeyword)),
      wait: const Duration(milliseconds: 3000),
      expect: () => [
        const SearchState(articles: [], loading: true),
        const SearchState(articles: [], loading: false),
      ],
    );
  });

  test("keyword event equal", () {
    expect(
      true,
      const GetSearchNews(keyword: 'test') ==
          const GetSearchNews(keyword: 'test'),
    );
  });
  test("keyword event not equal", () {
    expect(
      false,
      const GetSearchNews(keyword: 'test') ==
          const GetSearchNews(keyword: 'test2'),
    );
  });
}

class SearchNewsRepositoryMock extends Mock implements SearchNewsRepository {}
