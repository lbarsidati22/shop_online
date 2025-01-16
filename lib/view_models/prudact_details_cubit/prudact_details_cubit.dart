import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/models/add_to_cart_model.dart';
import 'package:shop_online/models/prudact_item_model.dart';
import 'package:shop_online/services/auth_services.dart';
import 'package:shop_online/services/prudact_details_services.dart';

part 'prudact_details_state.dart';

class PrudactDetailsCubit extends Cubit<PrudactDetailsState> {
  PrudactDetailsCubit() : super(PrudactDetailsInitial());
  final prudactDeatilsServices = PrudactDetailsSrevicesImpl();
  final authServices = AuthSrevicesImpl();
  PrudactSize? selectedSize;
  int quantity = 1;
  void getPrudactDetails(String id) async {
    emit(PrudactDetailsLeading());
    try {
      final selectedPrudact =
          await prudactDeatilsServices.fetchPrudactDetails(id);
      emit(PrudactDetailsLoaded(prudacts: selectedPrudact));
    } catch (e) {
      emit(
        PrudactDetailsErrror(message: e.toString()),
      );
    }
    // Future.delayed(
    //   const Duration(seconds: 1),
    //   () {
    //     final selectedProduct =
    //         dummyProducts.firstWhere((item) => item.id == id);
    //     emit(PrudactDetailsLoaded(prudacts: selectedProduct));
    //   },
    // );
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

  Future<void> addToCart(String prudactId) async {
    emit(PrudactAddingToCart());
    try {
      final selectedPrudact =
          await prudactDeatilsServices.fetchPrudactDetails(prudactId);
      final currentUser = authServices.currentUser();
      final cartItem = AddToCartModel(
        id: DateTime.now().toIso8601String(),
        prudact: selectedPrudact,
        size: selectedSize!,
        quantity: quantity,
      );
      await prudactDeatilsServices.addToCart(cartItem, currentUser!.uid);
      emit(PrudactAdedToCart(prudactId: prudactId));
    } catch (e) {
      emit(PrudactAddToCartError(e.toString()));
    }
  }
}
