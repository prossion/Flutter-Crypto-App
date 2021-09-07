import 'package:flutter_crypto/core/error/exception.dart';
import 'package:flutter_crypto/core/error/platform/network_imfo.dart';
import 'package:flutter_crypto/future/feature/data/datasources/crypto_local_data_source.dart';
import 'package:flutter_crypto/future/feature/data/datasources/crypto_remote_data_source.dart';
import 'package:flutter_crypto/future/feature/data/models/coin_model.dart';
import 'package:flutter_crypto/future/feature/domain/entities/coin_entity.dart';
import 'package:flutter_crypto/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_crypto/future/feature/domain/repositories/coin_repository.dart';

class CoinRepositoryImpl implements CoinRepository {
  final CoinRemoteDataSource remoteDataSource;
  final CoinLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CoinRepositoryImpl(
      {required this.localDataSource,
      required this.networkInfo,
      required this.remoteDataSource});
  @override
  Future<Either<Failure, List<CoinEntity>>> getAllCoins(int page) async {
    return await _getCoins(() {
      return remoteDataSource.getAllCoins(page);
    });
  }

  Future<Either<Failure, List<CoinModel>>> _getCoins(
      Future<List<CoinModel>> Function() getCoins) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCoin = await getCoins();
        localDataSource.coinsToCache(remoteCoin);
        return Right(remoteCoin);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCoin = await localDataSource.getLastCoinFromCache();
        return Right(localCoin);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
