import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/models/add_to_cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  int quantity = 1;
  void getCartsItems() {
    emit(CartLeading());
    final subTotal = dummyCart.fold<double>(
        0, (previuseValue, item) => previuseValue + item.prudact.price);
    emit(CartLoaded(subTotal, dummyCart));
  }

  void incrementCounter(String prudactId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity++;

    emit(
      QuantityCounterLoaded(value: quantity, prudactId: prudactId),
    );
  }

  void decrementCounter(String prudactId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }

    quantity--;

    emit(
      QuantityCounterLoaded(value: quantity, prudactId: prudactId),
    );
  }
}
