import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'features/product/data/datasources/product_local_data_source_contract.dart';
import 'features/product/data/datasources/product_local_data_source_impl.dart';
import 'features/product/data/datasources/product_remote_data_source_contract.dart';
import 'features/product/data/datasources/product_remote_data_source_impl.dart';
import 'features/product/data/network/network_info.dart';
import 'features/product/data/network/network_info_impl.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // 🌐 External packages
  sl.registerLazySingleton(() => http.Client());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());


  // 📶 Network Info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // // 🗃️ Local Data Source
  // sl.registerLazySingleton(() => ProductLocalDataSourceImpl(sl()));
sl.registerLazySingleton<ProductLocalDataSourceContract>(
  () => ProductLocalDataSourceImpl(sl()),
);

  // 🌍 Remote Data Source
  // sl.registerLazySingleton(() => ProductRemoteDataSourceImpl(client: sl()));
sl.registerLazySingleton<ProductRemoteDataSourceContract>(
  () => ProductRemoteDataSourceImpl(client: sl()),
);

  // 🏭 Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(), // ✅ now this is injected too
    ),
  );
}
