import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/models/add_to_cart_model.dart';
import 'package:shop_online/services/auth_services.dart';
import 'package:shop_online/services/cart_services.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  final cartServices = CartServicesEmpl();
  final authServices = AuthSrevicesImpl();

  int quantity = 1;
  Future<void> getCartsItems() async {
    emit(CartLeading());
    try {
      final currentUser = authServices.currentUser();
      final cartItems = await cartServices.fetchCartItems(currentUser!.uid);

      emit(CartLoaded(_subtotal(cartItems), cartItems));
    } catch (e) {}
    //  emit(CartLoaded(_subtotal, dummyCart));
  }

  Future<void> incrementCounter(AddToCartModel cartItem,
      [int? initialValue]) async {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity++;

    try {
      emit(QuantityCounterLeading());
      final currentUser = authServices.currentUser();
      final updatedCartItem = cartItem.copyWith(quantity: quantity);
      await cartServices.setCartItem(currentUser!.uid, updatedCartItem);

      emit(QuantityCounterLoaded(
          value: quantity, prudactId: updatedCartItem.prudact.id));
      final cartItems = await cartServices.fetchCartItems(currentUser.uid);
      emit(SubtotalUpdated(subtotal: _subtotal(cartItems)));
    } catch (e) {
      emit(QuantityCounterError(e.toString()));
    }
  }

  Future<void> decrementCounter(AddToCartModel cartItem,
      [int? initialValue]) async {
    if (initialValue != null) {
      quantity = initialValue;
    }
    if (quantity > 1) {
      quantity--;
    }
    try {
      emit(QuantityCounterLeading());
      final currentUser = authServices.currentUser();
      final updatedCartItem = cartItem.copyWith(quantity: quantity);
      await cartServices.setCartItem(currentUser!.uid, updatedCartItem);

      emit(QuantityCounterLoaded(
          value: quantity, prudactId: updatedCartItem.prudact.id));
      final cartItems = await cartServices.fetchCartItems(currentUser.uid);
      emit(SubtotalUpdated(subtotal: _subtotal(cartItems)));
    } catch (e) {
      emit(QuantityCounterError(e.toString()));
    }
  }

  double _subtotal(List<AddToCartModel> cartItems) => cartItems.fold<double>(
      0,
      (previousValue, item) =>
          previousValue + (item.prudact.price * item.quantity));
}
