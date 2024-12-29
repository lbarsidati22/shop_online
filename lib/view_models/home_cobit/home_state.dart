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

  HomeError({
    required this.error,
  });
}
