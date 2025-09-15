import 'package:crypto_price_list/const/favourite_utils.dart';
import 'package:crypto_price_list/const/url_const.dart';
import 'package:crypto_price_list/data/models/detail_model.dart';
import 'package:crypto_price_list/data/wss/wss_detail_service.dart';
import 'package:crypto_price_list/notifier/price_detail/price_detail_state_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

typedef PriceDetailProvider =
    AutoDisposeNotifierProvider<PriceDetailNotifier, PriceDetailStateModel>;

class PriceDetailNotifier extends AutoDisposeNotifier<PriceDetailStateModel> {
  final WssDetailService _service = WssDetailService();
  SharedPrefsUtils favouriteUtils = GetIt.instance.get<SharedPrefsUtils>();

  @override
  PriceDetailStateModel build() {
    _service.connect();
    ref.onDispose(() {
      _dispose();
    });
    return PriceDetailStateModel();
  }

  void clearFavourites() {
    favouriteUtils.clearFavourites();
  }

  void saveFavourite(String name) {
    favouriteUtils.saveFavourite(name);
    bool isFav = favouriteUtils.isFavourite(name);
    state = state.copyWith(isFavourite: isFav);
  }

  void removeFavourite(String name) {
    favouriteUtils.removeFavourite(name);
    bool isFav = favouriteUtils.isFavourite(name);
    state = state.copyWith(isFavourite: isFav);
  }

  void getUpdatePrice(String symbol, String name) {
    _service.sendMessage(UrlConst.getWssMessage(symbol));
    Stream<DetailModel>? detailPrice = _service.getUpdatedPrice();
    bool isFav = favouriteUtils.isFavourite(name);
    state = state.copyWith(isFavourite: isFav);
    detailPrice
        ?.listen((price) {
          state = state.copyWith(
            currentPrice: num.tryParse(price.price ?? ''),
            bidPrice: num.tryParse(price.bestBid ?? ''),
            sellPrice: num.tryParse(price.bestAsk ?? ''),
            time: DateTime.tryParse(price.time ?? ''),
          );
        })
        .onError((e) {});
  }

  void _dispose() {
    _service.disconnect();
  }
}
