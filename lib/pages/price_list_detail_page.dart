import 'package:crypto_price_list/const/url_const.dart';
import 'package:crypto_price_list/notifier/price_detail/price_detail_notifier.dart';
import 'package:crypto_price_list/notifier/price_detail/price_detail_state_model.dart';
import 'package:crypto_price_list/notifier/price_list/price_list_state_notifier.dart';

import 'package:crypto_price_list/widgets/price_detail_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../widgets/ifram_viewer/iframe_view_common.dart';

class PriceListDetailPage extends ConsumerStatefulWidget {
  const PriceListDetailPage({
    super.key,
    required this.symbol,
    required this.name,
  });

  final String symbol;
  final String name;

  @override
  ConsumerState<PriceListDetailPage> createState() =>
      _PriceListDetailPageState();
}

class _PriceListDetailPageState extends ConsumerState<PriceListDetailPage> {
  final PriceDetailProvider _detailProvider = GetIt.I
      .get<PriceDetailProvider>();
  final PriceListProvider _listProvider = GetIt.I.get<PriceListProvider>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(_detailProvider.notifier)
          .getUpdatePrice(widget.symbol.toUpperCase(), widget.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String link =
        '${UrlConst.chartLink}${widget.symbol.toUpperCase()}USD${UrlConst.chartQueryLink}';
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              bool isFav = ref.watch(_detailProvider).isFavourite;
              return IconButton(
                onPressed: () {
                  PriceDetailNotifier notifier = ref.read(
                    _detailProvider.notifier,
                  );
                  if (isFav) {
                    notifier.removeFavourite(widget.name);
                  } else {
                    notifier.saveFavourite(widget.name);
                  }
                  ref.read(_listProvider.notifier).getFavouriteList();
                },
                icon: isFav
                    ? Icon(Icons.star)
                    : Icon(Icons.star_border_outlined),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.4,
            child: IframeViewer(link: link),
          ),
          Consumer(
            builder: (context, ref, child) {
              PriceDetailStateModel model = ref.watch(_detailProvider);
              DateTime? date = model.time;
              return Column(
                children: [
                  PriceDetailItems(
                    title: "CurrentPrice",
                    value: model.currentPrice?.toString() ?? '-',
                  ),
                  PriceDetailItems(
                    title: "BuyPrice",
                    value: model.currentPrice?.toString() ?? '-',
                  ),
                  PriceDetailItems(
                    title: "SellPrice",
                    value: model.currentPrice?.toString() ?? '-',
                  ),
                  PriceDetailItems(
                    title: "Updated at",
                    value: date == null
                        ? "-"
                        : "${date.day},${date.month},${date.year} ${date.hour}:${date.minute}:${date.second}",
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
