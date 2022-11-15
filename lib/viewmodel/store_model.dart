import 'package:flutter/foundation.dart';
import 'package:public_open_api_mvvm/model/store.dart';
import 'package:public_open_api_mvvm/repository/store_repository.dart';

class StoreModel with ChangeNotifier {
  List<Store> stores = [];
  final _storeRepository = StoreRepository();
  var isLoading = true;

  StoreModel() {
    fetch();
  }
  Future fetch() async {
    isLoading = true;
    notifyListeners();

    stores = await _storeRepository.fetch();
    isLoading = false;
    notifyListeners();
  }
}