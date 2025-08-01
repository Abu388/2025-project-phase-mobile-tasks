import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/usecases/addProduct.dart';
import '../domain/usecases/delete_product.dart';
import '../domain/usecases/update_product.dart';
import '../domain/usecases/view_all_products.dart';
import '../domain/usecases/view_product.dart';
import 'product_event.dart';
import 'product_state.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ViewAllProductsUsecase viewAllProducts;
  final ViewProductUsecase viewProduct;
  final UpdateProductUsecase updateProduct;
  final DeleteProductUsecase deleteProduct;
  final CreateProductUsecase createProduct;

  ProductBloc({
    required this.viewAllProducts,
    required this.viewProduct,
    required this.updateProduct,
    required this.deleteProduct,
    required this.createProduct,
  }) : super(InitialState()) {
    on<LoadAllProductEvent>(_onLoadAllProducts);
    on<GetSingleProductEvent>(_onGetSingleProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
    on<CreateProductEvent>(_onCreateProduct);
  }

  Future<void> _onLoadAllProducts(
      LoadAllProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    try {
      final products = await viewAllProducts();
      emit(LoadedAllProductState(products));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> _onGetSingleProduct(
      GetSingleProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    try {
      final product = await viewProduct(event.id);
      if (product != null) {
        emit(LoadedSingleProductState(product));
      } else {
        emit(ErrorState("Product not found"));
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> _onUpdateProduct(
      UpdateProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    try {
      await updateProduct(event.product);
      final products = await viewAllProducts();
      emit(LoadedAllProductState(products));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> _onDeleteProduct(
      DeleteProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    try {
      await deleteProduct(event.id);
      final products = await viewAllProducts();
      emit(LoadedAllProductState(products));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> _onCreateProduct(
      CreateProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    try {
      await createProduct(event.product);
      final products = await viewAllProducts();
      emit(LoadedAllProductState(products));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
