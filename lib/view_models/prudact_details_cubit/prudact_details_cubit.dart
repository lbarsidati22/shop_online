import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/models/prudact_item_model.dart';

part 'prudact_details_state.dart';

class PrudactDetailsCubit extends Cubit<PrudactDetailsState> {
  PrudactDetailsCubit() : super(PrudactDetailsInitial());

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
    final selectedIindex =
        dummyProducts.indexWhere((item) => item.id == prudactId);
    dummyProducts[selectedIindex] = dummyProducts[selectedIindex].copyWith(
      quantity: dummyProducts[selectedIindex].quantity + 1,
    );
    emit(
      QuantityCounterLoaded(value: dummyProducts[selectedIindex].quantity),
    );
  }

  void decrementCounter(String prudactId) {
    final selectedIindex =
        dummyProducts.indexWhere((item) => item.id == prudactId);
    dummyProducts[selectedIindex] = dummyProducts[selectedIindex].copyWith(
      quantity: dummyProducts[selectedIindex].quantity - 1,
    );
    emit(
      QuantityCounterLoaded(value: dummyProducts[selectedIindex].quantity),
    );
  }
}
