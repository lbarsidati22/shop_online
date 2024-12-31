import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/models/add_to_cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  int quantity = 1;
  void getCartsItems() {
    emit(CartLeading());
    emit(CartLoaded(dummyCart));
  }

  void incrementCounter(String prudactId) {
    quantity++;

    emit(
      QuantityCounterLoaded(value: quantity),
    );
  }

  void decrementCounter(String prudactId) {
    quantity--;

    emit(
      QuantityCounterLoaded(value: quantity),
    );
  }
}
