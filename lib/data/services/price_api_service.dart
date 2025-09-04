import 'package:crypto_price_list/const/url_const.dart';
import 'package:crypto_price_list/const/utils.dart';
import 'package:crypto_price_list/data/models/price_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class PriceApiServices {
  final Dio _dio = GetIt.instance.get<Dio>(instanceName: "price");

  Future<List<PriceModel>> getPriceList({
    String currency = 'usd',
    required int page,
    String? order,
    int perPage = Utils.perPage,
    List<String> ids = const [],
  }) async {
    Map<String, String>? orderMap = order == null || order.isEmpty
        ? null
        : {'order': order};
    if (ids.isNotEmpty) {
      orderMap ??= {};
      orderMap['ids'] = ids.join(',');
    } else {
      orderMap ??= {};
      orderMap = {
        ...orderMap,
        'per_page': perPage.toString(),
        'page': page.toString(),
      };
    }
    final response = await _dio.get(
      UrlConst.list,
      queryParameters: {
        'vs_currency': currency,
        'price_change_percentage': '1h,24h,7d',
        'per_page': perPage,
        'page': page,
        ...orderMap,
      },
    );
    return (response.data as List).map((e) {
      return PriceModel.fromJson(e);
    }).toList();
  }
}
