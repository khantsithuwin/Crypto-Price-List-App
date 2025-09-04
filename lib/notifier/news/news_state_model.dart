import 'package:crypto_price_list/data/models/news_model.dart';

class NewsStateModel {
  final NewsModel? newsModel;
  final bool isLoading;
  final bool isSuccess;
  final bool isError;

  NewsStateModel({
    this.newsModel,
    this.isLoading = true,
    this.isSuccess = false,
    this.isError = false,
  });

  NewsStateModel copyWith({
    NewsModel? newsModel,
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
  }) {
    return NewsStateModel(
      newsModel: newsModel ?? this.newsModel,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
    );
  }
}
