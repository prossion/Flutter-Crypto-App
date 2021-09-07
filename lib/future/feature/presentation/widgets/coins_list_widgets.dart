import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crypto/future/feature/domain/entities/coin_entity.dart';
import 'package:flutter_crypto/future/feature/presentation/bloc/coin_list_cubit/coin_list_cubit.dart';
import 'package:flutter_crypto/future/feature/presentation/bloc/coin_list_cubit/coin_list_state.dart';
import 'package:flutter_crypto/future/feature/presentation/widgets/coin_card_widget.dart';

class CoinsList extends StatelessWidget {
  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<CoinListCubit>(context).loadedCoin();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return BlocBuilder<CoinListCubit, CoinState>(builder: (context, state) {
      List<CoinEntity> coins = [];
      bool isLoading = false;
      if (state is CoinLoading && state.isFirstFetch) {
        return _loadingIndicator();
      } else if (state is CoinLoading) {
        coins = state.oldCoinList;
        isLoading = true;
      } else if (state is CoinLoaded) {
        coins = state.coinList;
      } else if (state is CoinError) {
        return Text(
          state.message,
          style: TextStyle(color: Colors.white, fontSize: 25),
        );
      }
      return ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < coins.length) {
            return CoinCard(coin: coins[index]);
          } else {
            Timer(Duration(microseconds: 30), () {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });
            return _loadingIndicator();
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.grey[400],
          );
        },
        itemCount: coins.length + (isLoading ? 1 : 0),
      );
    });
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
