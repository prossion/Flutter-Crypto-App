import 'package:flutter/material.dart';
import 'package:flutter_crypto/future/feature/presentation/widgets/coins_list_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CoinStats'),
        centerTitle: true,
      ),
      body: CoinsList(),
    );
  }
}
