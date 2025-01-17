part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitialState extends HomeState {}

final class HomeLeading extends HomeState {}

final class Homeloaded extends HomeState {
  final List<HomeCarouselItemModel> carouselItem;
  final List<PrudactItemModel> prudacts;

  Homeloaded({
    required this.carouselItem,
    required this.prudacts,
  });
}

final class HomeError extends HomeState {
  final String error;

  HomeError(
    this.error,
  );
}

final class SetFavoriteSuccess extends HomeState {
  final bool isFavorite;
  final String prudactId;

  SetFavoriteSuccess({
    required this.prudactId,
    required this.isFavorite,
  });
}

final class SetFavoriteLeading extends HomeState {
  final String prudactId;

  SetFavoriteLeading(this.prudactId);
}

final class SetFavoriteError extends HomeState {
  final String prudactId;
  final String message;

  SetFavoriteError(this.message, this.prudactId);
}
