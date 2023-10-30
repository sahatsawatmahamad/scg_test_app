import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'articles.g.dart';

@JsonSerializable()
class Articles extends Equatable {
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String content;
  const Articles({
    required this.content,
    required this.description,
    required this.publishedAt,
    required this.title,
    required this.url,
    this.urlToImage,
  });

  factory Articles.fromJson(Map<String, dynamic> json) =>
      _$ArticlesFromJson(json);
  Map<String, dynamic> toJson() => _$ArticlesToJson(this);

  @override
  List<Object?> get props => [
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      ];
}
