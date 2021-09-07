import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crypto/core/error/failure.dart';
import 'package:flutter_crypto/future/feature/domain/entities/coin_entity.dart';
import 'package:flutter_crypto/future/feature/domain/usecases/get_all_coin.dart';
import 'package:flutter_crypto/future/feature/presentation/bloc/coin_list_cubit/coin_list_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHE_FAILURE_MESSAGE = 'Cache Failure';

class CoinListCubit extends Cubit<CoinState> {
  final GetAllCrypto getAllCrypto;
  CoinListCubit({required this.getAllCrypto}) : super(CoinEmpty());

  int elements = 20;

  void loadedCoin() async {
    if (state is CoinLoading) return;

    final currentState = state;

    var oldCoin = <CoinEntity>[];
    if (currentState is CoinLoaded) {
      oldCoin = currentState.coinList;
    }

    emit(CoinLoading(oldCoin, isFirstFetch: elements == 20));

    final failureOrCoin =
        await getAllCrypto(PageCoinParams(elements: elements));

    failureOrCoin
        .fold((error) => emit(CoinError(message: _mapFailureToMessage(error))),
            (market) {
      elements += 20;
      final coins = (state as CoinLoading).oldCoinList;
      coins.addAll(market);
      print('List length: ${coins.length.toString()}');
      emit(CoinLoaded(coins));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Failure';
    }
  }
}
