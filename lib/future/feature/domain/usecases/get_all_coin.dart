import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_crypto/core/error/failure.dart';
import 'package:flutter_crypto/core/usecases/usecase.dart';
import 'package:flutter_crypto/future/feature/domain/entities/coin_entity.dart';
import 'package:flutter_crypto/future/feature/domain/repositories/coin_repository.dart';

class GetAllCrypto extends UseCase<List<CoinEntity>, PageCoinParams> {
  final CoinRepository cryprtoRepository;

  GetAllCrypto(this.cryprtoRepository);

  Future<Either<Failure, List<CoinEntity>>> call(PageCoinParams params) async {
    return await cryprtoRepository.getAllCoins(params.elements);
  }
}

class PageCoinParams extends Equatable {
  final int elements;

  PageCoinParams({required this.elements});

  @override
  List<Object?> get props => [elements];
}
