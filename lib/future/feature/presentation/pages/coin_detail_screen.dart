import 'package:flutter/material.dart';
import 'package:flutter_crypto/future/feature/domain/entities/coin_entity.dart';
import 'package:flutter_crypto/future/feature/presentation/widgets/coin_cached_image_widget.dart';

class CoinDetailScreen extends StatelessWidget {
  final CoinEntity coin;

  const CoinDetailScreen({Key? key, required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Characteristic'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            Text(
              coin.name,
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              child: CoinCacheImage(
                width: 100,
                height: 100,
                imageUrl: coin.icon,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Price: ${coin.price.toStringAsFixed(1)} \$',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            ...buildText('Volume:', coin.volume.toString() + ' \$'),
            ...buildText(
              'Price change per hour:',
              coin.change.toDouble() < 0
                  ? coin.change.toString() + '%'
                  : '+' + coin.change.toString() + '%',
            ),
            ...buildText(
              'Price change per day: ',
              coin.change1d.toDouble() < 0
                  ? coin.change1d.toString() + '%'
                  : '+' + coin.change1d.toString() + '%',
            ),
            ...buildText(
              'Price change per week:',
              coin.change1w.toDouble() < 0
                  ? coin.change1w.toString() + '%'
                  : '+' + coin.change1w.toString() + '%',
            ),
            ...buildText('Links:', coin.links),
          ],
        ),
      ),
    );
  }

  List<Widget> buildText(String text, String value) {
    return [
      Text(
        text,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      SizedBox(
        height: 6,
      ),
      Text(
        value,
        style: TextStyle(
          color: Colors.white70,
        ),
      ),
      SizedBox(
        height: 12,
      ),
    ];
  }
}
