import 'package:crypto_price_list/pages/news_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../data/models/news_model.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({super.key, required this.articles});

  final Articles? articles;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    DateTime? date = DateTime.tryParse(articles?.publishedAt ?? '');
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return NewsDetailPage(
                title: articles?.title ?? "",
                link: articles?.url ?? "",
              );
            },
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (articles?.urlToImage != null)
                Stack(
                  children: [
                    Image.network(
                      articles!.urlToImage!,
                      width: double.infinity,
                      errorBuilder: (_, __, ___) {
                        return Container(
                          alignment: Alignment.center,
                          width: 100,
                          child: Icon(Icons.error),
                        );
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(),
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.black.withAlpha(120),
                      ),
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(8.0),
                      child: Text(
                        articles?.source?.name ?? "",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(articles?.title ?? "", style: textTheme.titleMedium),
                    Text(
                      articles?.description ?? "",
                      style: textTheme.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_month_sharp),
                      SizedBox(width: 8),
                      if (date != null)
                        Text(
                          "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}",
                        ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      SharePlus.instance.share(
                        ShareParams(uri: Uri.parse(articles?.url ?? "")),
                      );
                    },
                    icon: Icon(Icons.share),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
