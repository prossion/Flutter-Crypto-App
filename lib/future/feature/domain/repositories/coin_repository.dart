import 'package:dartz/dartz.dart';
import 'package:flutter_crypto/core/error/failure.dart';
import 'package:flutter_crypto/future/feature/domain/entities/coin_entity.dart';

abstract class CoinRepository {
  Future<Either<Failure, List<CoinEntity>>> getAllCoins(int page);
}
