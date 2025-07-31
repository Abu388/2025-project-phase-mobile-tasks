import 'package:flutter_test/flutter_test.dart';
import 'package:hello_app/features/product/data/datasources/product_local_data_source_contract.dart';
import 'package:hello_app/features/product/data/datasources/product_remote_data_source_contract.dart';
import 'package:hello_app/features/product/data/models/product_model.dart';
import 'package:hello_app/features/product/data/network/network_info.dart';
import 'package:hello_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_repository_impl_test.mocks.mocks.dart';

@GenerateMocks([ProductLocalDataSourceContract, ProductRemoteDataSourceContract, NetworkInfo])
void main() {
  late ProductRepositoryImpl repository;
  late MockProductLocalDataSourceContract mockLocalDataSource;
  late MockProductRemoteDataSourceContract mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockLocalDataSource = MockProductLocalDataSourceContract();
    mockRemoteDataSource = MockProductRemoteDataSourceContract();
    mockNetworkInfo = MockNetworkInfo();

    repository = ProductRepositoryImpl(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final testProduct = ProductModel(
    id: '1',
    name: 'Test',
    imagePath: 'images/test.jpg',
    desc: 'description',
    price: '100',
  );

  group('getAllProducts', () {
    test('should get data from remote when online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getAllProducts()).thenAnswer((_) async => [testProduct]);

      final result = await repository.getAllProducts();

      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteDataSource.getAllProducts());
      expect(result, [testProduct]);
    });

    test('should get data from local when offline', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getAllProducts()).thenReturn([testProduct]);

      final result = await repository.getAllProducts();

      verify(mockNetworkInfo.isConnected);
      verify(mockLocalDataSource.getAllProducts());
      expect(result, [testProduct]);
    });
  });
}
