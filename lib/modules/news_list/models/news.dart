import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:scg_test_app/modules/news_list/models/articles.dart';

part 'news.g.dart';

@JsonSerializable()
class News extends Equatable {
  final String status;
  final int? totalResult;
  final List<Articles> articles;

  const News({
    required this.status,
    this.totalResult,
    required this.articles,
  });

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);

  @override
  List<Object?> get props => [status, totalResult, articles];
}
