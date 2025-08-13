import 'package:crypto_price_list/data/models/price_model.dart';

class PriceListStateModel {
  final bool loading;
  final bool success;
  final String errorMessage;
  final List<PriceModel> priceList;

  PriceListStateModel({
    this.priceList = const [],
    this.loading = true,
    this.success = false,
    this.errorMessage = '',
  });

  PriceListStateModel copyWith({
    List<PriceModel>? priceList,
    bool? loading,
    bool? success,
    String? errorMessage,
  }) {
    return PriceListStateModel(
      priceList: priceList ?? this.priceList,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
