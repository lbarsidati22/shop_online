import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/models/home_carousel_item_model.dart';
import 'package:shop_online/models/prudact_item_model.dart';
import 'package:shop_online/services/home_services.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());
  final homeServices = HomeServicesImpl();

  Future<void> getHomeData() async {
    emit(HomeLeading());
    try {
      final products = await homeServices.fetchProducts();
      final carouselItems = await homeServices.fecthCarouselItems();
      emit(Homeloaded(carouselItem: carouselItems, prudacts: products));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
    // Future.delayed((Duration(seconds: 1)), () {
    //   emit(
    //     Homeloaded(
    //       carouselItem: dummyHomeCarouselItems,
    //       prudacts: dummyProducts,
    //     ),
    //   );
    // });
  }
}
