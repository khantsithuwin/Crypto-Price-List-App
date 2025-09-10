import 'package:crypto_price_list/data/models/news_model.dart';
import 'package:crypto_price_list/data/services/news_api_service.dart';
import 'package:crypto_price_list/notifier/news/news_state_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef NewsProvider = NotifierProvider<NewsNotifier, NewsStateModel>;

class NewsNotifier extends Notifier<NewsStateModel> {
  final NewsApiService _apiService = NewsApiService();
  int _page = 1;

  @override
  NewsStateModel build() {
    return NewsStateModel();
  }

  Future<void> getNews() async {
    try {
      state = state.copyWith(isLoading: true, isSuccess: false, isError: false);
      NewsModel newsModel = await _apiService.getNews();
      state = state.copyWith(
        newsModel: newsModel,
        isLoading: false,
        isSuccess: true,
        isError: false,
      );
    } catch (e) {
      state = state.copyWith(isError: true, isSuccess: false, isLoading: false);
    }
  }

  void loadMore() async {
    try {
      _page = _page + 1;
      NewsModel newsModel1 = await _apiService.getNews(page: _page);
      state = state.copyWith(
        newsModel: state.newsModel?.copyWith(
          articles: [
            ...state.newsModel?.articles ?? [],
            ...newsModel1.articles ?? [],
          ],
        ),
      );
    } catch (e) {
      //
    }
  }
}
