import 'package:shop_online/models/prudact_item_model.dart';
import 'package:shop_online/services/firestor_services.dart';
import 'package:shop_online/utils/api_paths.dart';

abstract class PrudactDetailsServices {
  Future<PrudactItemModel> fetchPrudactDetails(String prudactId);
}

class PrudactDetailsSrevicesImpl implements PrudactDetailsServices {
  final firestoreServices = FirestoreServices.instance;
  @override
  Future<PrudactItemModel> fetchPrudactDetails(String prudactId) async {
    final selectedPrudact =
        await firestoreServices.getDocument<PrudactItemModel>(
            path: ApiPaths.product(prudactId),
            builder: (data, documentId) =>
                PrudactItemModel.fromMap(data, documentId));
    return selectedPrudact;
  }
}
