import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:public_open_api_mvvm/model/store.dart';
import 'package:public_open_api_mvvm/repository/location_repository.dart';
import 'package:public_open_api_mvvm/repository/store_repository.dart';

class StoreModel with ChangeNotifier {
  List<Store> stores = [];
  final _storeRepository = StoreRepository();
  final _locationRepository = LocationRepository();
  var isLoading = true;

  StoreModel() {
    fetch();
  }
  Future fetch() async {
    isLoading = true;
    notifyListeners();

    Position position = await _locationRepository.getCurrentLocation();
    stores = await _storeRepository.fetch(
        position.altitude, position.longitude);
    isLoading = false;
    notifyListeners();
  }
}