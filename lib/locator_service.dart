import 'package:flutter_crypto/core/error/platform/network_imfo.dart';
import 'package:flutter_crypto/future/feature/data/datasources/crypto_local_data_source.dart';
import 'package:flutter_crypto/future/feature/data/datasources/crypto_remote_data_source.dart';
import 'package:flutter_crypto/future/feature/data/repositories/coin_repository_impl.dart';
import 'package:flutter_crypto/future/feature/domain/repositories/coin_repository.dart';
import 'package:flutter_crypto/future/feature/domain/usecases/get_all_coin.dart';
import 'package:flutter_crypto/future/feature/presentation/bloc/coin_list_cubit/coin_list_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => CoinListCubit(getAllCrypto: sl()));

  sl.registerLazySingleton(() => GetAllCrypto(sl()));

  sl.registerLazySingleton<CoinRepository>(() => CoinRepositoryImpl(
      localDataSource: sl(), networkInfo: sl(), remoteDataSource: sl()));
  sl.registerLazySingleton<CoinLocalDataSource>(
      () => CoinLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<CoinRemoteDataSource>(
      () => CoinRemoteDataSourceImp(client: http.Client()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
