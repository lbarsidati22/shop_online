import 'package:shop_online/models/category_model.dart';
import 'package:shop_online/models/home_carousel_item_model.dart';
import 'package:shop_online/models/prudact_item_model.dart';
import 'package:shop_online/services/firestor_services.dart';
import 'package:shop_online/utils/api_paths.dart';

abstract class HomeServices {
  Future<List<PrudactItemModel>> fetchProducts();
  Future<List<HomeCarouselItemModel>> fecthCarouselItems();
  Future<List<CategoryModel>> fetchCategories();
}

class HomeServicesImpl implements HomeServices {
  final firestoreServices = FirestoreServices.instance;
  @override
  Future<List<PrudactItemModel>> fetchProducts() async {
    final result = await firestoreServices.getCollection<PrudactItemModel>(
      path: ApiPaths.products(),
      builder: (data, documentId) => PrudactItemModel.fromMap(
        data,
      ),
    );
    return result;
  }

  @override
  Future<List<HomeCarouselItemModel>> fecthCarouselItems() async {
    final result = await firestoreServices.getCollection<HomeCarouselItemModel>(
      path: ApiPaths.announcements(),
      builder: (data, documentId) => HomeCarouselItemModel.fromMap(
        data,
      ),
    );
    return result;
  }

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    final result = await firestoreServices.getCollection<CategoryModel>(
      path: ApiPaths.categorises(),
      builder: (data, documentId) => CategoryModel.fromMap(
        data,
      ),
    );
    return result;
  }
}
