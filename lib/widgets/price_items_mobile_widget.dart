import 'package:crypto_price_list/pages/price_list_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../const/indicator_color.dart';
import '../const/number_formatter.dart';
import '../data/models/price_model.dart';
import 'price_indicator.dart';

class PriceItemsMobileWidget extends StatelessWidget {
  const PriceItemsMobileWidget({super.key, required this.priceModel});

  final PriceModel priceModel;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    return InkWell(
      onTap: () {
        String? symbol = priceModel.symbol;
        if (symbol != null) {
          context.pushNamed(
            "details",
            queryParameters: {"symbol": symbol, "name": priceModel.name ?? ""},
          );
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        if (priceModel.image != null)
                          Image.network(priceModel.image!, width: 25),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            priceModel.name ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      priceModel.symbol?.toUpperCase() ?? '',
                      style: textTheme.bodySmall,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '\$${NumberFormatter.commaDecimal(priceModel.currentPrice ?? 0, 2)} ',
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("1h", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('24h', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('7d', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      priceIndicator(
                        priceModel.priceChangePercentage1hInCurrency,
                      ),
                      Text(
                        (priceModel.priceChangePercentage1hInCurrency ?? 0)
                            .abs()
                            .toStringAsFixed(1),
                        style: TextStyle(
                          color: indicatorColor(
                            priceModel.priceChangePercentage1hInCurrency,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      priceIndicator(
                        priceModel.priceChangePercentage24hInCurrency,
                      ),
                      Text(
                        (priceModel.priceChangePercentage24hInCurrency ?? 0)
                            .abs()
                            .toStringAsFixed(1),
                        style: TextStyle(
                          color: indicatorColor(
                            priceModel.priceChangePercentage24hInCurrency,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      priceIndicator(
                        priceModel.priceChangePercentage7dInCurrency,
                      ),
                      Text(
                        (priceModel.priceChangePercentage7dInCurrency ?? 0)
                            .abs()
                            .toStringAsFixed(1),
                        style: TextStyle(
                          color: indicatorColor(
                            priceModel.priceChangePercentage7dInCurrency,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      '24h Volume',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Market Cap',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(NumberFormatter.commaValue(priceModel.totalVolume ?? 0)),
                  Text(NumberFormatter.commaValue(priceModel.marketCap ?? 0)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
