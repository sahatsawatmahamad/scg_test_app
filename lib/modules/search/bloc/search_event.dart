part of 'search_bloc.dart';

class GetSearchNews extends SearchEvent {
  const GetSearchNews({required this.keyword});
  final String keyword;

  @override
  List<Object> get props => [keyword];
}

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}
