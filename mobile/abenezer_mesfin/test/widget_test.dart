import 'package:flutter_test/flutter_test.dart';
import 'package:hello_app/presentation/main.dart';
import 'package:hello_app/data/datasources/product_local_data_source.dart';
import 'package:hello_app/data/repositories/product_repository_impl.dart';

void main() {
  testWidgets('App builds smoke test', (WidgetTester tester) async {
    final productRepository =
        ProductRepositoryImpl(ProductLocalDataSource());

    await tester.pumpWidget(MyApp(productRepository: productRepository));

    // Expect to find the app's home title or any text you use
    expect(find.text('Product Manager'), findsOneWidget);
  });
}
