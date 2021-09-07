import 'dart:convert';
import 'package:flutter_crypto/core/error/exception.dart';
import 'package:flutter_crypto/future/feature/data/models/coin_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CoinLocalDataSource {
  /// Throws [CacheException] if no cached data is present
  Future<List<CoinModel>> getLastCoinFromCache();
  Future<void> coinsToCache(List<CoinModel> coins);
}

const CACHED_COINS_LIST = 'CACHED_COINS_LIST';

class CoinLocalDataSourceImpl implements CoinLocalDataSource {
  final SharedPreferences sharedPreferences;

  CoinLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> coinsToCache(List<CoinModel> coins) {
    final List<String> jsonCoinsList =
        coins.map((coin) => json.encode(coin.toJson())).toList();
    sharedPreferences.setStringList(CACHED_COINS_LIST, jsonCoinsList);
    print('Coins to write cache: ${jsonCoinsList.length}');
    return Future.value(jsonCoinsList);
    //throw UnimplementedError();
  }

  @override
  Future<List<CoinModel>> getLastCoinFromCache() {
    final jsonCoinsList = sharedPreferences.getStringList(CACHED_COINS_LIST);
    if (jsonCoinsList!.isNotEmpty) {
      print('Get coins from cache: ${jsonCoinsList.length}');
      return Future.value(jsonCoinsList
          .map((coins) => CoinModel.fromJson(json.decode(coins)))
          .toList());
    } else {
      throw CacheException();
    }
  }
}
