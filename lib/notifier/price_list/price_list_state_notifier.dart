import 'package:crypto_price_list/data/services/price_api_service.dart';
import 'package:crypto_price_list/notifier/price_list/price_list_state_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/price_model.dart';

typedef PriceListProvider =
    NotifierProvider<PriceListStateNotifier, PriceListStateModel>;

class PriceListStateNotifier extends Notifier<PriceListStateModel> {
  final PriceApiServices _apiServices = PriceApiServices();
  int _page = 1;
  String? _order;

  @override
  PriceListStateModel build() {
    return PriceListStateModel();
  }

  Future<void> getPriceList() async {
    try {
      state = state.copyWith(loading: true, success: false, errorMessage: '');
      List<PriceModel> priceList = await _apiServices.getPriceList(page: _page);
      state = state.copyWith(
        priceList: priceList,
        success: true,
        loading: false,
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        success: false,
        errorMessage: e.toString(),
      );
    }
  }

  void loadMoreList() async {
    _page = _page + 1;
    try {
      List<PriceModel> newList = await _apiServices.getPriceList(
        page: _page,
        order: _order,
      );
      state = state.copyWith(priceList: [...state.priceList, ...newList]);
    } catch (e) {
      //
    }
  }

  void sort(String orderValue) async {
    try {
      _order = orderValue;
      state = state.copyWith(loading: true, errorMessage: "", success: false);
      int loadedItems = state.priceList.length;
      List<PriceModel> orderedList = await _apiServices.getPriceList(
        page: 1,
        order: orderValue,
        perPage: loadedItems,
      );
      state = state.copyWith(
        priceList: orderedList,
        loading: false,
        errorMessage: '',
        success: true,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
        loading: false,
        success: false,
      );
    }
  }
}
