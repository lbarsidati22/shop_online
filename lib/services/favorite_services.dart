import 'package:shop_online/models/prudact_item_model.dart';
import 'package:shop_online/services/firestor_services.dart';
import 'package:shop_online/utils/api_paths.dart';

abstract class FavoriteServices {
  Future<void> addFavorite(String userId, PrudactItemModel prudact);
  Future<void> removeFavorite(String userId, String prudactId);
  Future<List<PrudactItemModel>> getFavorite(String userId);
}

class FavoriteServicesImpl implements FavoriteServices {
  final firestorServices = FirestoreServices.instance;
  @override
  Future<void> addFavorite(String userId, PrudactItemModel prudact) async {
    await firestorServices.setData(
      path: ApiPaths.favoritePrudact(userId, prudact.id),
      data: prudact.toMap(),
    );
  }

  @override
  Future<List<PrudactItemModel>> getFavorite(String userId) async {
    return await firestorServices.getCollection(
        path: ApiPaths.favoritePrudacts(userId),
        builder: (data, documentId) => PrudactItemModel.fromMap(data));
  }

  @override
  Future<void> removeFavorite(String userId, String prudactId) async {
    await firestorServices.deleteData(
        path: ApiPaths.favoritePrudact(userId, prudactId));
  }
}
