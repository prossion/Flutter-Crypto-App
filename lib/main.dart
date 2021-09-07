import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crypto/common/app_color.dart';
import 'package:flutter_crypto/future/feature/presentation/bloc/coin_list_cubit/coin_list_cubit.dart';
import 'package:flutter_crypto/future/feature/presentation/pages/coin_screen.dart';
import 'package:flutter_crypto/locator_service.dart' as di;

import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CoinListCubit>(
            create: (context) => sl<CoinListCubit>()..loadedCoin()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          backgroundColor: AppColors.mainBackground,
          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
        home: HomePage(),
      ),
    );
  }
}
