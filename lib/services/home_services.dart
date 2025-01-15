import 'package:shop_online/models/prudact_item_model.dart';
import 'package:shop_online/services/firestor_services.dart';
import 'package:shop_online/utils/api_paths.dart';

abstract class HomeServices {
  Future<List<PrudactItemModel>> fetchProducts();
}

class HomeServicesImpl implements HomeServices {
  final firestoreServices = FirestoreServices.instance;
  @override
  Future<List<PrudactItemModel>> fetchProducts() async {
    final result = await firestoreServices.getCollection<PrudactItemModel>(
      path: ApiPaths.products(),
      builder: (data, documentId) => PrudactItemModel.fromMap(
        data,
        documentId,
      ),
    );
    return result;
  }
}
