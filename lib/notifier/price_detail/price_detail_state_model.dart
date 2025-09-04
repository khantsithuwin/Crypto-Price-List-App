class PriceDetailStateModel {
  num? currentPrice;
  num? bidPrice;
  num? sellPrice;
  DateTime? time;
  bool isFavourite;

  PriceDetailStateModel({
    this.currentPrice,
    this.bidPrice,
    this.sellPrice,
    this.time,
    this.isFavourite = false,
  });

  @override
  String toString() {
    return 'PriceDetailStateModel{currentPrice: $currentPrice, bidPrice: $bidPrice, sellPrice: $sellPrice, time: $time}';
  }

  PriceDetailStateModel copyWith({
    num? currentPrice,
    num? bidPrice,
    num? sellPrice,
    DateTime? time,
    bool? isFavourite,
  }) {
    return PriceDetailStateModel(
      currentPrice: currentPrice ?? this.currentPrice,
      bidPrice: bidPrice ?? this.bidPrice,
      sellPrice: sellPrice ?? this.sellPrice,
      time: time ?? this.time,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
