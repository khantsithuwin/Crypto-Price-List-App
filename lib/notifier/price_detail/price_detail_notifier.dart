import 'package:crypto_price_list/const/url_const.dart';
import 'package:crypto_price_list/data/models/detail_model.dart';
import 'package:crypto_price_list/data/wss/wss_detail_service.dart';
import 'package:crypto_price_list/notifier/price_detail/price_detail_state_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef PriceDetailProvider =
    AutoDisposeNotifierProvider<PriceDetailNotifier, PriceDetailStateModel>;

class PriceDetailNotifier extends AutoDisposeNotifier<PriceDetailStateModel> {
  final WssDetailService _service = WssDetailService();

  @override
  PriceDetailStateModel build() {
    _service.connect();
    return PriceDetailStateModel();
  }

  void getUpdatePrice(String symbol) {
    _service.sendMessage(UrlConst.getWssMessage(symbol));
    Stream<DetailModel>? detailPrice = _service.getUpdatedPrice();
    detailPrice
        ?.listen((price) {
          print("success $price");
          state = state.copyWith(
            currentPrice: num.tryParse(price.price ?? ''),
            bidPrice: num.tryParse(price.bestBid ?? ''),
            sellPrice: num.tryParse(price.bestAsk ?? ''),
            time: DateTime.tryParse(price.time ?? ''),
          );
        })
        .onError((e) {
          print("error $e");
        });
  }

  void dispose() {
    _service.disconnect();
  }
}
