import 'package:flutter/material.dart';
import 'package:flutter_crypto/common/app_color.dart';
import 'package:flutter_crypto/future/feature/domain/entities/coin_entity.dart';
import 'package:flutter_crypto/future/feature/presentation/pages/coin_detail_screen.dart';
import 'package:flutter_crypto/future/feature/presentation/widgets/coin_cached_image_widget.dart';

class CoinCard extends StatelessWidget {
  final CoinEntity coin;
  const CoinCard({Key? key, required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CoinDetailScreen(coin: coin),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cellBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                child: CoinCacheImage(
                  imageUrl: coin.icon,
                  width: 60,
                  height: 60,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 12),
                  Text(
                    coin.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    coin.symbol,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      coin.price.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      coin.change.toDouble() < 0
                          ? coin.change.toString() + '%'
                          : '+' + coin.change.toString() + '%',
                      style: TextStyle(
                        color: coin.change < 0 ? Colors.red : Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
