import 'package:crypto_price_list/data/models/news_model.dart';
import 'package:crypto_price_list/notifier/news/news_notifier.dart';
import 'package:crypto_price_list/notifier/news/news_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/news_widget.dart';

class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({super.key});

  @override
  ConsumerState<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends ConsumerState<NewsPage> {
  final NewsProvider _provider = NewsProvider(() => NewsNotifier());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(_provider.notifier).getNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    NewsStateModel newsStateModel = ref.watch(_provider);
    NewsModel? newsModel = newsStateModel.newsModel;
    int count = newsModel?.articles?.length ?? 0;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (newsStateModel.isLoading)
            Center(child: CircularProgressIndicator()),
          if (newsStateModel.isLoading == false &&
              newsStateModel.isError == false &&
              newsStateModel.isSuccess == true)
            Expanded(
              child: ListView.builder(
                itemCount: count + 1,
                itemBuilder: (context, index) {
                  if (index == newsModel?.totalResults) {
                    return Text("Out of Content");
                  } else if (index == count) {
                    ref.read(_provider.notifier).loadMore();
                    return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    );
                  }
                  Articles? articles = newsModel?.articles?[index];
                  return NewsWidget(articles: articles);
                },
              ),
            ),
        ],
      ),
    );
  }
}
