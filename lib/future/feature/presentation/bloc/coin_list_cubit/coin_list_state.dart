import 'package:equatable/equatable.dart';
import 'package:flutter_crypto/future/feature/domain/entities/coin_entity.dart';

abstract class CoinState extends Equatable {
  const CoinState();

  @override
  List<Object?> get props => [];
}

class CoinEmpty extends CoinState {
  @override
  List<Object?> get props => [];
}

class CoinLoading extends CoinState {
  final List<CoinEntity> oldCoinList;
  final bool isFirstFetch;

  CoinLoading(this.oldCoinList, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldCoinList];
}

class CoinLoaded extends CoinState {
  final List<CoinEntity> coinList;

  CoinLoaded(this.coinList);

  @override
  List<Object?> get props => [coinList];
}

class CoinError extends CoinState {
  final String message;

  CoinError({required this.message});
}
