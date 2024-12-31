import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/models/add_to_cart_model.dart';
import 'package:shop_online/models/prudact_item_model.dart';

part 'prudact_details_state.dart';

class PrudactDetailsCubit extends Cubit<PrudactDetailsState> {
  PrudactDetailsCubit() : super(PrudactDetailsInitial());
  PrudactSize? selectedSize;
  int quantity = 1;
  void getPrudactDetails(String id) {
    emit(PrudactDetailsLeading());
    Future.delayed(
      const Duration(seconds: 1),
      () {
        final selectedProduct =
            dummyProducts.firstWhere((item) => item.id == id);
        emit(PrudactDetailsLoaded(prudacts: selectedProduct));
      },
    );
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

  void selectSize(PrudactSize size) {
    selectedSize = size;
    emit(SizeSelected(size: size));
  }

  void addToCart(String prudactId) {
    emit(PrudactAddingToCart());
    final cartItem = AddToCartModel(
      id: DateTime.now().toIso8601String(),
      prudact: dummyProducts.firstWhere((item) => item.id == prudactId),
      size: selectedSize!,
      quantity: quantity,
    );
    dummyCart.add(cartItem);
    Future.delayed((Duration(seconds: 1)), () {
      emit(PrudactAdedToCart(prudactId: prudactId));
    });
  }
}
