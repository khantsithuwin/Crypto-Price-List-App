import 'package:crypto_price_list/data/models/news_model.dart';
import 'package:crypto_price_list/notifier/news/news_notifier.dart';
import 'package:crypto_price_list/notifier/news/news_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    TextTheme textTheme = TextTheme.of(context);
    NewsStateModel newsStateModel = ref.watch(_provider);
    NewsModel? newsModel = newsStateModel.newsModel;
    return Scaffold(
      appBar: AppBar(title: Text("News")),
      body: Column(
        children: [
          if (newsStateModel.isLoading)
            Center(child: CircularProgressIndicator()),
          if (newsStateModel.isLoading == false &&
              newsStateModel.isError == false &&
              newsStateModel.isSuccess == true)
            Expanded(
              child: ListView.builder(
                itemCount: newsModel?.articles?.length,
                itemBuilder: (context, index) {
                  Articles? articles = newsModel?.articles?[index];
                  DateTime? date = DateTime.tryParse(
                    articles?.publishedAt ?? '',
                  );
                  return Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (articles?.urlToImage != null)
                          Image.network(
                            articles!.urlToImage!,
                            width: 100,
                            errorBuilder: (_, __, ___) {
                              return Container(
                                alignment: Alignment.center,
                                width: 100,
                                child: Icon(Icons.error),
                              );
                            },
                          ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                articles?.title ?? "",
                                style: textTheme.titleLarge,
                              ),
                              Text(
                                articles?.description ?? "",
                                style: textTheme.bodyMedium,
                              ),
                              if (date != null)
                                Text(
                                  "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}",
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
