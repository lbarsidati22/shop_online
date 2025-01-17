import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/models/home_carousel_item_model.dart';
import 'package:shop_online/models/prudact_item_model.dart';
import 'package:shop_online/services/auth_services.dart';
import 'package:shop_online/services/favorite_services.dart';
import 'package:shop_online/services/home_services.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());
  final homeServices = HomeServicesImpl();
  final authServices = AuthSrevicesImpl();
  final favoriteServices = FavoriteServicesImpl();

  Future<void> getHomeData() async {
    emit(HomeLeading());
    try {
      final products = await homeServices.fetchProducts();
      final carouselItems = await homeServices.fecthCarouselItems();
      final currentUser = authServices.currentUser();
      final favoritePrudacts =
          await favoriteServices.getFavorite(currentUser!.uid);
      final List<PrudactItemModel> finalPrudacts = products.map((prudact) {
        final isFavorite =
            favoritePrudacts.any((item) => item.id == prudact.id);
        return prudact.copyWith(isFavorite: isFavorite);
      }).toList();
      emit(Homeloaded(carouselItem: carouselItems, prudacts: finalPrudacts));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> setFavorite(PrudactItemModel prudact) async {
    emit(SetFavoriteLeading(prudact.id));
    try {
      final currentUser = authServices.currentUser();
      final favoritePrudact =
          await favoriteServices.getFavorite(currentUser!.uid);
      final isFavorite = favoritePrudact.any(
        (item) => item.id == prudact.id,
      );
      if (isFavorite) {
        await favoriteServices.removeFavorite(currentUser.uid, prudact.id);
      } else {
        await favoriteServices.addFavorite(currentUser.uid, prudact);
      }
      emit(SetFavoriteSuccess(isFavorite: !isFavorite, prudactId: prudact.id));
    } catch (e) {
      emit(SetFavoriteError(e.toString(), prudact.id));
    }
  }
}
