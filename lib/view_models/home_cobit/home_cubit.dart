import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/models/home_carousel_item_model.dart';
import 'package:shop_online/models/prudact_item_model.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  void getHomeData() {
    emit(HomeLeading());
    Future.delayed((Duration(seconds: 1)), () {
      emit(
        Homeloaded(
          carouselItem: dummyHomeCarouselItems,
          prudacts: dummyProducts,
        ),
      );
    });
  }
}
