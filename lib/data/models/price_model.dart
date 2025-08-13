class PriceModel {
  PriceModel({
      this.id, 
      this.symbol, 
      this.name, 
      this.image, 
      this.currentPrice, 
      this.marketCap, 
      this.marketCapRank, 
      this.fullyDilutedValuation, 
      this.totalVolume, 
      this.high24h, 
      this.low24h, 
      this.priceChange24h, 
      this.priceChangePercentage24h, 
      this.marketCapChange24h, 
      this.marketCapChangePercentage24h, 
      this.circulatingSupply, 
      this.totalSupply, 
      this.maxSupply, 
      this.ath, 
      this.athChangePercentage, 
      this.athDate, 
      this.atl, 
      this.atlChangePercentage, 
      this.atlDate, 
      this.roi, 
      this.lastUpdated, 
      this.priceChangePercentage1hInCurrency, 
      this.priceChangePercentage24hInCurrency, 
      this.priceChangePercentage7dInCurrency,});

  PriceModel.fromJson(dynamic json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    image = json['image'];
    currentPrice = json['current_price'];
    marketCap = json['market_cap'];
    marketCapRank = json['market_cap_rank'];
    fullyDilutedValuation = json['fully_diluted_valuation'];
    totalVolume = json['total_volume'];
    high24h = json['high_24h'];
    low24h = json['low_24h'];
    priceChange24h = json['price_change_24h'];
    priceChangePercentage24h = json['price_change_percentage_24h'];
    marketCapChange24h = json['market_cap_change_24h'];
    marketCapChangePercentage24h = json['market_cap_change_percentage_24h'];
    circulatingSupply = json['circulating_supply'];
    totalSupply = json['total_supply'];
    maxSupply = json['max_supply'];
    ath = json['ath'];
    athChangePercentage = json['ath_change_percentage'];
    athDate = json['ath_date'];
    atl = json['atl'];
    atlChangePercentage = json['atl_change_percentage'];
    atlDate = json['atl_date'];
    roi = json['roi'];
    lastUpdated = json['last_updated'];
    priceChangePercentage1hInCurrency = json['price_change_percentage_1h_in_currency'];
    priceChangePercentage24hInCurrency = json['price_change_percentage_24h_in_currency'];
    priceChangePercentage7dInCurrency = json['price_change_percentage_7d_in_currency'];
  }
  String? id;
  String? symbol;
  String? name;
  String? image;
  num? currentPrice;
  num? marketCap;
  num? marketCapRank;
  num? fullyDilutedValuation;
  num? totalVolume;
  num? high24h;
  num? low24h;
  num? priceChange24h;
  num? priceChangePercentage24h;
  num? marketCapChange24h;
  num? marketCapChangePercentage24h;
  num? circulatingSupply;
  num? totalSupply;
  num? maxSupply;
  num? ath;
  num? athChangePercentage;
  String? athDate;
  num? atl;
  num? atlChangePercentage;
  String? atlDate;
  dynamic roi;
  String? lastUpdated;
  num? priceChangePercentage1hInCurrency;
  num? priceChangePercentage24hInCurrency;
  num? priceChangePercentage7dInCurrency;
PriceModel copyWith({  String? id,
  String? symbol,
  String? name,
  String? image,
  num? currentPrice,
  num? marketCap,
  num? marketCapRank,
  num? fullyDilutedValuation,
  num? totalVolume,
  num? high24h,
  num? low24h,
  num? priceChange24h,
  num? priceChangePercentage24h,
  num? marketCapChange24h,
  num? marketCapChangePercentage24h,
  num? circulatingSupply,
  num? totalSupply,
  num? maxSupply,
  num? ath,
  num? athChangePercentage,
  String? athDate,
  num? atl,
  num? atlChangePercentage,
  String? atlDate,
  dynamic roi,
  String? lastUpdated,
  num? priceChangePercentage1hInCurrency,
  num? priceChangePercentage24hInCurrency,
  num? priceChangePercentage7dInCurrency,
}) => PriceModel(  id: id ?? this.id,
  symbol: symbol ?? this.symbol,
  name: name ?? this.name,
  image: image ?? this.image,
  currentPrice: currentPrice ?? this.currentPrice,
  marketCap: marketCap ?? this.marketCap,
  marketCapRank: marketCapRank ?? this.marketCapRank,
  fullyDilutedValuation: fullyDilutedValuation ?? this.fullyDilutedValuation,
  totalVolume: totalVolume ?? this.totalVolume,
  high24h: high24h ?? this.high24h,
  low24h: low24h ?? this.low24h,
  priceChange24h: priceChange24h ?? this.priceChange24h,
  priceChangePercentage24h: priceChangePercentage24h ?? this.priceChangePercentage24h,
  marketCapChange24h: marketCapChange24h ?? this.marketCapChange24h,
  marketCapChangePercentage24h: marketCapChangePercentage24h ?? this.marketCapChangePercentage24h,
  circulatingSupply: circulatingSupply ?? this.circulatingSupply,
  totalSupply: totalSupply ?? this.totalSupply,
  maxSupply: maxSupply ?? this.maxSupply,
  ath: ath ?? this.ath,
  athChangePercentage: athChangePercentage ?? this.athChangePercentage,
  athDate: athDate ?? this.athDate,
  atl: atl ?? this.atl,
  atlChangePercentage: atlChangePercentage ?? this.atlChangePercentage,
  atlDate: atlDate ?? this.atlDate,
  roi: roi ?? this.roi,
  lastUpdated: lastUpdated ?? this.lastUpdated,
  priceChangePercentage1hInCurrency: priceChangePercentage1hInCurrency ?? this.priceChangePercentage1hInCurrency,
  priceChangePercentage24hInCurrency: priceChangePercentage24hInCurrency ?? this.priceChangePercentage24hInCurrency,
  priceChangePercentage7dInCurrency: priceChangePercentage7dInCurrency ?? this.priceChangePercentage7dInCurrency,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['symbol'] = symbol;
    map['name'] = name;
    map['image'] = image;
    map['current_price'] = currentPrice;
    map['market_cap'] = marketCap;
    map['market_cap_rank'] = marketCapRank;
    map['fully_diluted_valuation'] = fullyDilutedValuation;
    map['total_volume'] = totalVolume;
    map['high_24h'] = high24h;
    map['low_24h'] = low24h;
    map['price_change_24h'] = priceChange24h;
    map['price_change_percentage_24h'] = priceChangePercentage24h;
    map['market_cap_change_24h'] = marketCapChange24h;
    map['market_cap_change_percentage_24h'] = marketCapChangePercentage24h;
    map['circulating_supply'] = circulatingSupply;
    map['total_supply'] = totalSupply;
    map['max_supply'] = maxSupply;
    map['ath'] = ath;
    map['ath_change_percentage'] = athChangePercentage;
    map['ath_date'] = athDate;
    map['atl'] = atl;
    map['atl_change_percentage'] = atlChangePercentage;
    map['atl_date'] = atlDate;
    map['roi'] = roi;
    map['last_updated'] = lastUpdated;
    map['price_change_percentage_1h_in_currency'] = priceChangePercentage1hInCurrency;
    map['price_change_percentage_24h_in_currency'] = priceChangePercentage24hInCurrency;
    map['price_change_percentage_7d_in_currency'] = priceChangePercentage7dInCurrency;
    return map;
  }

}