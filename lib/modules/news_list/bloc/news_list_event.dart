part of 'news_list_bloc.dart';

class GetNews extends NewsListEvent {
  const GetNews();
}

abstract class NewsListEvent extends Equatable {
  const NewsListEvent();

  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}
