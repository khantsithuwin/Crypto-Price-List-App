class UrlConst {
  static const baseUrl = "https://api.coingecko.com/api/v3/coins/";
  static const list = "markets";
  static const chartLink =
      'https://www.tradingview.com/widgetembed/?symbol=COINBASE:';
  static const chartQueryLink =
      '&interval=60&hidesidetoolbar=1&saveimage=1&toolbarbg=F1F3F6';
  static const wssDetailUrl = 'wss://ws-feed.exchange.coinbase.com';

  static String getWssMessage(String symbol) {
    return '{"type": "subscribe", "product_ids": ["$symbol-USD"], "channels": ["ticker"]}';
  }
}
