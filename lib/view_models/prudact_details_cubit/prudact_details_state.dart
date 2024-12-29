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
