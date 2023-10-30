import 'package:flutter_modular/flutter_modular.dart';

import 'package:scg_test_app/modules/news_list/bloc/news_list_bloc.dart';
import 'package:scg_test_app/modules/news_list/repository/news.dart';
import 'package:scg_test_app/modules/search/bloc/search_bloc.dart';
import 'package:scg_test_app/modules/search/repository/search_news.dart';

class MainModule extends Module {
  MainModule();

  @override
  List<Module> get imports => [];

  @override
  List<Bind> get binds => [
        Bind.singleton<NewsRepository>((i) => NewsRepository()),
        Bind.singleton<NewsListBloc>(
            (i) => NewsListBloc(Modular.get<NewsRepository>())),
        Bind.singleton<SearchNewsRepository>((i) => SearchNewsRepository()),
        Bind.singleton<SearchBloc>(
            (i) => SearchBloc(Modular.get<SearchNewsRepository>())),
      ];

  @override
  List<ModularRoute> get routes => [];
}
