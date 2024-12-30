part of 'prudact_details_cubit.dart';

sealed class PrudactDetailsState {}

final class PrudactDetailsInitial extends PrudactDetailsState {}

final class PrudactDetailsLeading extends PrudactDetailsState {}

final class PrudactDetailsLoaded extends PrudactDetailsState {
  final PrudactItemModel prudacts;

  PrudactDetailsLoaded({
    required this.prudacts,
  });
}

final class PrudactDetailsErrror extends PrudactDetailsState {
  final String message;

  PrudactDetailsErrror({
    required this.message,
  });
}

final class QuantityCounterLoaded extends PrudactDetailsState {
  final int value;

  QuantityCounterLoaded({required this.value});
}

final class SizeSelected extends PrudactDetailsState {
  final PrudactSize size;

  SizeSelected({
    required this.size,
  });
}

final class PrudactAdedToCart extends PrudactDetailsState {
  final String prudactId;

  PrudactAdedToCart({
    required this.prudactId,
  });
}

final class PrudactAddingToCart extends PrudactDetailsState {}
