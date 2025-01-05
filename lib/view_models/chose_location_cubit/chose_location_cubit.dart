import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/models/loaction_item_model.dart';

part 'chose_location_state.dart';

class ChoseLocationCubit extends Cubit<ChoseLocationState> {
  ChoseLocationCubit() : super(ChoseLocationInitial());

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
}
