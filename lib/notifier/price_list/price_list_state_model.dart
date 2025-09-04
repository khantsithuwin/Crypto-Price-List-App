import 'package:crypto_price_list/data/models/price_model.dart';

class PriceListStateModel {
  final bool loading;
  final bool success;
  final String errorMessage;
  final List<PriceModel> priceList;
  final List<PriceModel> favList;

  PriceListStateModel({
    this.priceList = const [],
    this.favList = const [],
    this.loading = true,
    this.success = false,
    this.errorMessage = '',
  });

  PriceListStateModel copyWith({
    List<PriceModel>? priceList,
    List<PriceModel>? favList,
    bool? loading,
    bool? success,
    String? errorMessage,
  }) {
    return PriceListStateModel(
      priceList: priceList ?? this.priceList,
      favList: favList ?? this.favList,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
