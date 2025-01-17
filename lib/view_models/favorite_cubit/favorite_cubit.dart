import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/services/auth_services.dart';
import 'package:shop_online/services/favorite_services.dart';
import 'package:shop_online/view_models/favorite_cubit/favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  final favoriteServices = FavoriteServicesImpl();
  final authServices = AuthSrevicesImpl();
  Future<void> getFavoritePrudacts() async {
    emit(FavoriteLeading());
    try {
      final currentUser = authServices.currentUser();
      final favoritePrudacts =
          await favoriteServices.getFavorite(currentUser!.uid);
      emit(FavoriteLoaded(favoritePrudact: favoritePrudacts));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> removeFavorite(String prudactId) async {
    emit(FavoriteRemoving(prudactId));
    try {
      final currentUser = authServices.currentUser();
      await favoriteServices.removeFavorite(currentUser!.uid, prudactId);
      emit(FavoriteRemoved(prudactId));
      final favoritePrudacts =
          await favoriteServices.getFavorite(currentUser.uid);
      emit(FavoriteLoaded(favoritePrudact: favoritePrudacts));
    } catch (e) {
      emit(FavoriteRemoveError(e.toString()));
    }
  }
}
