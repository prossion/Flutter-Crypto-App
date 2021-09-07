import 'dart:convert';
import 'package:flutter_crypto/core/error/exception.dart';
import 'package:flutter_crypto/future/feature/data/models/coin_model.dart';
import 'package:http/http.dart' as http;

abstract class CoinRemoteDataSource {
  /// Calls the https://api.coinstats.app/public/v1/coins?skip=0&limit=20&currency=USD endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CoinModel>> getAllCoins(int elements);
}

class CoinRemoteDataSourceImp implements CoinRemoteDataSource {
  final http.Client client;

  CoinRemoteDataSourceImp({required this.client});

  @override
  Future<List<CoinModel>> getAllCoins(int elements) => _getCoinsFromUrl(
      'https://api.coinstats.app/public/v1/coins?skip=0&limit=$elements&currency=USD');

  Future<List<CoinModel>> _getCoinsFromUrl(String url) async {
    print(url);
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final coins = json.decode(response.body);
      return (coins['coins'] as List)
          .map((coin) => CoinModel.fromJson(coin))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
