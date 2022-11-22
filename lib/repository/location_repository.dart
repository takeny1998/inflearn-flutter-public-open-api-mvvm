import 'package:geolocator/geolocator.dart';

class LocationRepository {
  final _geolocator = Geolocator();

  Future getCurrentLocation() async {
    Position position = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }
}
