import 'package:flutter_crypto/future/feature/domain/entities/coin_entity.dart';

class CoinModel extends CoinEntity {
  CoinModel({
    required id,
    required symbol,
    required name,
    required icon,
    required price,
    required links,
    required change,
    required change1d,
    required change1w,
    required volume,
  }) : super(
          id: id,
          symbol: symbol,
          name: name,
          icon: icon,
          price: price,
          links: links,
          change: change,
          change1d: change1d,
          change1w: change1w,
          volume: volume,
        );

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      icon: json['icon'],
      price: json['price'],
      links: json['websiteUrl'],
      change: json['priceChange1h'],
      change1d: json['priceChange1d'],
      change1w: json['priceChange1w'],
      volume: json['volume'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'icon': icon,
      'price': price.toString(),
      'links': links,
      'priceChange1h': change.toString(),
    };
  }
}
