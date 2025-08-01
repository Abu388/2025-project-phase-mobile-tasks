import 'package:flutter_test/flutter_test.dart';
// import your contracts, models, network info, repository
import 'package:hello_app/features/product/data/datasources/product_local_data_source_contract.dart';
import 'package:hello_app/features/product/data/datasources/product_remote_data_source_contract.dart';
import 'package:hello_app/features/product/data/models/product_model.dart';
import 'package:hello_app/features/product/data/network/network_info.dart';
import 'package:hello_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// import the generated mocks (correct import)
import 'product_repository_impl_test.mocks.dart';


@GenerateMocks([
  ProductLocalDataSourceContract,
  ProductRemoteDataSourceContract,
  NetworkInfo,
])
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

  final testProductModel = ProductModel(
    id: '1',
    name: 'Test Product',
    imagePath: 'images/test.jpg',
    desc: 'Test Description',
    price: '100',
  );

  group('getAllProducts', () {
    test('should get data from remote when online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getAllProducts())
          .thenAnswer((_) async => [testProductModel.toEntity()]);


      final result = await repository.getAllProducts();

      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteDataSource.getAllProducts());

      // compare with the entity type, converting the model to entity
      expect(result, [testProductModel.toEntity()]);
    });

    test('should get data from local when offline', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getAllProducts())
          .thenAnswer((_) async => [testProductModel.toEntity()]);


      final result = await repository.getAllProducts();

      verify(mockNetworkInfo.isConnected);
      verify(mockLocalDataSource.getAllProducts());

      // compare with entity type
      expect(result, [testProductModel.toEntity()]);
    });
  });
}
