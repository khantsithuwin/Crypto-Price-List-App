import 'dart:convert';

import 'package:crypto_price_list/const/url_const.dart';
import 'package:crypto_price_list/data/models/detail_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WssDetailService {
  WebSocketChannel? _channel;

  void connect() {
    _channel = WebSocketChannel.connect(Uri.parse(UrlConst.wssDetailUrl));
  }

  void sendMessage(String message) {
    _channel?.sink.add(message);
  }

  Stream<DetailModel>? getUpdatedPrice() {
    return _channel?.stream.map((e) => DetailModel.fromJson(jsonDecode(e)));
  }

  void disconnect() {
    _channel?.sink.close();
  }
}
