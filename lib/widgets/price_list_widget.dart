import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/price_model.dart';
import '../notifier/price_list/price_list_state_model.dart';
import '../notifier/price_list/price_list_state_notifier.dart';
import 'price_items_mobile_widget.dart';
import 'price_items_web_widget.dart';

class PriceLIstWidget extends ConsumerWidget {
  PriceLIstWidget({
    super.key,
    required this.priceListProvider,
    this.isFav = false,
  });

  final PriceListProvider priceListProvider;
  final bool isFav;

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context, ref) {
    double width = MediaQuery.of(context).size.width;
    PriceListStateModel stateModel = ref.watch(priceListProvider);
    List<PriceModel> priceList = isFav
        ? stateModel.favList
        : stateModel.priceList;
    return Column(
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
                itemCount: isFav ? priceList.length : priceList.length + 1,
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
                          itemCount: isFav
                              ? priceList.length
                              : priceList.length + 1,
                          itemBuilder: (context, index) {
                            if (index == priceList.length) {
                              ref
                                  .read(priceListProvider.notifier)
                                  .loadMoreList();
                              return Center(child: CircularProgressIndicator());
                            }
                            PriceModel priceModel = priceList[index];
                            return PriceItemsWebWidget(priceModel: priceModel);
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
    );
  }
}
