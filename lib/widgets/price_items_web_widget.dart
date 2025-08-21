import 'package:crypto_price_list/data/models/price_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../const/indicator_color.dart';
import '../const/number_formatter.dart';
import 'price_indicator.dart';

class PriceItemsWebWidget extends StatelessWidget {
  const PriceItemsWebWidget({super.key, required this.priceModel});

  final PriceModel priceModel;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.only(left: 8.0),
          width: 150,
          height: 40,
          decoration: BoxDecoration(border: Border.all()),
          child: Row(
            children: [
              if (priceModel.image != null)
                Image.network(priceModel.image!, width: 25),
              SizedBox(width: 8.0),
              Expanded(
                child: InkWell(
                  onTap: () {
                    context.pushNamed(
                      "details",
                      queryParameters: {
                        "symbol": priceModel.symbol ?? '',
                        "name": priceModel.name ?? '',
                      },
                    );
                  },
                  child: Text(
                    priceModel.name ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          width: 100,
          height: 40,
          decoration: BoxDecoration(border: Border.all()),
          child: Text(
            priceModel.symbol?.toUpperCase() ?? '',
            style: textTheme.bodySmall,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(8.0),
          width: 150,
          height: 40,
          decoration: BoxDecoration(border: Border.all()),
          child: Text(
            '\$${NumberFormatter.commaDecimal(priceModel.currentPrice ?? 0, 2)} ',
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          width: 100,
          height: 40,
          decoration: BoxDecoration(border: Border.all()),
          child: Row(
            children: [
              priceIndicator(priceModel.priceChangePercentage1hInCurrency),
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
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          width: 100,
          height: 40,
          decoration: BoxDecoration(border: Border.all()),
          child: Row(
            children: [
              priceIndicator(priceModel.priceChangePercentage24hInCurrency),
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
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          width: 100,
          height: 40,
          decoration: BoxDecoration(border: Border.all()),
          child: Row(
            children: [
              priceIndicator(priceModel.priceChangePercentage7dInCurrency),
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
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(8.0),
          width: 150,
          height: 40,
          decoration: BoxDecoration(border: Border.all()),
          child: Text(NumberFormatter.commaValue(priceModel.totalVolume ?? 0)),
        ),
        Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(right: 8.0),
          padding: EdgeInsets.all(8.0),
          width: 150,
          height: 40,
          decoration: BoxDecoration(border: Border.all()),
          child: Text(NumberFormatter.commaValue(priceModel.marketCap ?? 0)),
        ),
      ],
    );
  }
}
