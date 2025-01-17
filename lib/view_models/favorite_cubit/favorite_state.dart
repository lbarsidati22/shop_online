import 'package:shop_online/models/prudact_item_model.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLeading extends FavoriteState {}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError(this.message);
}

class FavoriteLoaded extends FavoriteState {
  final List<PrudactItemModel> favoritePrudact;

  FavoriteLoaded({required this.favoritePrudact});
}

class FavoriteRemoved extends FavoriteState {
  final String prudactId;

  FavoriteRemoved(this.prudactId);
}

class FavoriteRemoving extends FavoriteState {
  final String prudactId;

  FavoriteRemoving(this.prudactId);
}

class FavoriteRemoveError extends FavoriteState {
  final String message;

  FavoriteRemoveError(this.message);
}
