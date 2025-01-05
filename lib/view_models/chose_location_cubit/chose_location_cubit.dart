import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/models/loaction_item_model.dart';

part 'chose_location_state.dart';

class ChoseLocationCubit extends Cubit<ChoseLocationState> {
  ChoseLocationCubit() : super(ChoseLocationInitial());
  String selectedLoactionID = dummyLocations.first.id;

  void fetchLocations() {
    emit(FetchingLocations());
    Future.delayed(Duration(seconds: 1), () {
      emit(FetchedLocations(dummyLocations));
    });
  }

  void addLocation(String location) {
    emit(LocationsAdding());
    Future.delayed(Duration(seconds: 1), () {
      final siplltedLocation = location.split('-');
      final locationItem = LoactionItemModel(
        id: DateTime.now().toIso8601String(),
        city: siplltedLocation[0],
        country: siplltedLocation[1],
      );
      dummyLocations.add(locationItem);
      emit(LocationAded());
      emit(FetchedLocations(dummyLocations));
    });
  }

  void selectLocation(String id) {
    selectedLoactionID = id;
    final chosenLocation = dummyLocations
        .firstWhere((location) => location.id == selectedLoactionID);

    emit(LocationChosen(chosenLocation));
  }

  void confirmAddress() {
    emit(ConfirmAddressLeading());
    Future.delayed(Duration(seconds: 1), () {
      var chosenAddress = dummyLocations
          .firstWhere((location) => location.id == selectedLoactionID);
      var previousAddress = dummyLocations.firstWhere(
          (location) => location.isChosen == true,
          orElse: () => dummyLocations.first);
      previousAddress = previousAddress.copyWith(isChosen: false);
      chosenAddress = chosenAddress.copyWith(isChosen: true);
      final previouseIndex = dummyLocations
          .indexWhere((location) => location.id == previousAddress.id);
      final chosenIndex = dummyLocations
          .indexWhere((location) => location.id == chosenAddress.id);
      dummyLocations[previouseIndex] = previousAddress;
      dummyLocations[chosenIndex] = chosenAddress;

      emit(ConfirmAddressLoaded());
    });
  }
}
