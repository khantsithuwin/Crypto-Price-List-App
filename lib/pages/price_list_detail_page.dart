import 'package:crypto_price_list/const/url_const.dart';
import 'package:crypto_price_list/widgets/ifram_viewer/iframe_view_common.dart';
import 'package:flutter/material.dart';

class PriceListDetailPage extends StatefulWidget {
  const PriceListDetailPage({
    super.key,
    required this.symbol,
    required this.name,
  });

  final String symbol;
  final String name;

  @override
  State<PriceListDetailPage> createState() => _PriceListDetailPageState();
}

class _PriceListDetailPageState extends State<PriceListDetailPage> {
  @override
  Widget build(BuildContext context) {
    String link =
        '${UrlConst.chartLink}${widget.symbol.toUpperCase()}USD${UrlConst.chartQueryLink}';
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Column(
        children: [SizedBox(height: 400, child: IframeViewer(link: link))],
      ),
    );
  }
}
