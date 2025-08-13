import 'package:crypto_price_list/const/indicator_color.dart';
import 'package:crypto_price_list/const/number_formatter.dart';
import 'package:crypto_price_list/notifier/price_list/price_list_state_model.dart';
import 'package:crypto_price_list/notifier/price_list/price_list_state_notifier.dart';
import 'package:crypto_price_list/widgets/price_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/price_model.dart';

class PriceListPage extends ConsumerStatefulWidget {
  const PriceListPage({super.key});

  @override
  ConsumerState<PriceListPage> createState() => _PriceListPageState();
}

class _PriceListPageState extends ConsumerState<PriceListPage> {
  String selectedSort = '';
  final priceListProvider = PriceListProvider(() => PriceListStateNotifier());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(priceListProvider.notifier).getPriceList();
    });
  }

  @override
  Widget build(BuildContext context) {
    PriceListStateModel stateModel = ref.watch(priceListProvider);
    List<PriceModel> priceList = stateModel.priceList;
    TextTheme textTheme = TextTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cryptocurrency Price List"),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert_outlined),
            onSelected: (value) {
              setState(() {
                selectedSort = value;
              });
              ref.read(priceListProvider.notifier).sort(value);
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<String>(
                  value: "",
                  child: Text(
                    "Default",
                    style: TextStyle(
                      color: selectedSort == "" ? Colors.blue : null,
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: "market_cap_asc",
                  child: Text(
                    "Asc (Market Cap)",
                    style: TextStyle(
                      color: selectedSort == "market_cap_asc"
                          ? Colors.blue
                          : null,
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: "market_cap_desc",
                  child: Text(
                    "Desc (Market Cap)",
                    style: TextStyle(
                      color: selectedSort == "market_cap_desc"
                          ? Colors.blue
                          : null,
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: "volume_asc",
                  child: Text(
                    "Asc (24h Volume)",
                    style: TextStyle(
                      color: selectedSort == "volume_asc" ? Colors.blue : null,
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: "volume_desc",
                  child: Text(
                    "Desc (24h Volume)",
                    style: TextStyle(
                      color: selectedSort == "volume_desc" ? Colors.blue : null,
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (stateModel.loading == true)
            Center(child: CircularProgressIndicator()),
          if (stateModel.loading == false && stateModel.success == true)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: priceList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == priceList.length) {
                      ref.read(priceListProvider.notifier).loadMoreList();
                      return Center(child: CircularProgressIndicator());
                    }
                    PriceModel priceModel = priceList[index];
                    return Card(
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
                                        Image.network(
                                          priceModel.image!,
                                          width: 25,
                                        ),
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
                                Text(
                                  "1h",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '24h',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '7d',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    priceIndicator(
                                      priceModel
                                          .priceChangePercentage1hInCurrency,
                                    ),
                                    Text(
                                      (priceModel.priceChangePercentage1hInCurrency ??
                                              0)
                                          .toStringAsFixed(1),
                                      style: TextStyle(
                                        color: indicatorColor(
                                          priceModel
                                              .priceChangePercentage1hInCurrency,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    priceIndicator(
                                      priceModel
                                          .priceChangePercentage24hInCurrency,
                                    ),
                                    Text(
                                      (priceModel.priceChangePercentage24hInCurrency ??
                                              0)
                                          .toStringAsFixed(1),
                                      style: TextStyle(
                                        color: indicatorColor(
                                          priceModel
                                              .priceChangePercentage24hInCurrency,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    priceIndicator(
                                      priceModel
                                          .priceChangePercentage7dInCurrency,
                                    ),
                                    Text(
                                      (priceModel.priceChangePercentage7dInCurrency ??
                                              0)
                                          .toStringAsFixed(1),
                                      style: TextStyle(
                                        color: indicatorColor(
                                          priceModel
                                              .priceChangePercentage7dInCurrency,
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
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Market Cap',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  NumberFormatter.commaValue(
                                    priceModel.totalVolume ?? 0,
                                  ),
                                ),
                                Text(
                                  NumberFormatter.commaValue(
                                    priceModel.marketCap ?? 0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
