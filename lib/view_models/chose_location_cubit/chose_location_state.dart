part of 'chose_location_cubit.dart';

sealed class ChoseLocationState {}

final class ChoseLocationInitial extends ChoseLocationState {}

final class FetchingLocations extends ChoseLocationState {}

final class FetchedLocations extends ChoseLocationState {
  final List<LoactionItemModel> locations;

  FetchedLocations(this.locations);
}

final class FetchLocationsFailure extends ChoseLocationState {
  final String message;

  FetchLocationsFailure({required this.message});
}

final class LocationsAdding extends ChoseLocationState {}

final class LocationAded extends ChoseLocationState {}

final class LocationsAddingFailure extends ChoseLocationState {
  final String message;

  LocationsAddingFailure({required this.message});
}

final class LocationChosen extends ChoseLocationState {
  final LoactionItemModel location;

  LocationChosen(this.location);
}

final class ConfirmAddressLeading extends ChoseLocationState {}

final class ConfirmAddressLoaded extends ChoseLocationState {}

final class ConfirmAddressFailue extends ChoseLocationState {
  final String message;

  ConfirmAddressFailue({required this.message});
}
