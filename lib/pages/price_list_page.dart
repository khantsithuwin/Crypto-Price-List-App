import 'package:crypto_price_list/notifier/price_list/price_list_state_model.dart';
import 'package:crypto_price_list/notifier/price_list/price_list_state_notifier.dart';
import 'package:crypto_price_list/widgets/price_items_web_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/price_model.dart';
import '../widgets/price_items_mobile_widget.dart';

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

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    PriceListStateModel stateModel = ref.watch(priceListProvider);
    List<PriceModel> priceList = stateModel.priceList;
    double width = MediaQuery.of(context).size.width;

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
          if (stateModel.loading == false &&
              stateModel.success == true &&
              width < 600)
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
                    return PriceItemsMobileWidget(priceModel: priceModel);
                  },
                ),
              ),
            ),
          if (stateModel.loading == false &&
              stateModel.success == true &&
              width >= 600)
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 1200,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.0),
                            margin: EdgeInsets.only(left: 8.0),
                            width: 150,
                            decoration: BoxDecoration(border: Border.all()),
                            child: Text("Name"),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            width: 100,
                            decoration: BoxDecoration(border: Border.all()),
                            child: Text("Symbol"),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.all(8.0),
                            width: 150,
                            decoration: BoxDecoration(border: Border.all()),
                            child: Text("Current Price"),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            width: 100,
                            decoration: BoxDecoration(border: Border.all()),
                            child: Text("1h Change"),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            width: 100,
                            decoration: BoxDecoration(border: Border.all()),
                            child: Text("24h Change"),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            width: 100,
                            decoration: BoxDecoration(border: Border.all()),
                            child: Text("7d Change"),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.all(8.0),
                            width: 150,
                            decoration: BoxDecoration(border: Border.all()),
                            child: Text("24h Volume"),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.all(8.0),
                            margin: EdgeInsets.only(right: 8.0),
                            width: 150,
                            decoration: BoxDecoration(border: Border.all()),
                            child: Text("Market Cap"),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Scrollbar(
                          controller: _controller,
                          thumbVisibility: true,
                          trackVisibility: true,
                          child: ListView.builder(
                            controller: _controller,
                            itemCount: priceList.length + 1,
                            itemBuilder: (context, index) {
                              if (index == priceList.length) {
                                ref
                                    .read(priceListProvider.notifier)
                                    .loadMoreList();
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              PriceModel priceModel = priceList[index];
                              return PriceItemsWebWidget(
                                priceModel: priceModel,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
