import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class LocationHandler {
  static Future<Position> getPosition() async {
    try {
      Position position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );

      return position;
    } catch(e) {
      print("Error occured: $e");
      return null;
    }
  }

  static Future<String> getAddress() async {
    String retVal = '';
    var pos = await getPosition();
    if (pos != null) {
      try {
        final coordinates = new Coordinates(pos.latitude, pos.longitude);
        List<Address> addresses = await Geocoder.local
            .findAddressesFromCoordinates(coordinates);
        Address first = addresses.first;
        retVal = "${first.featureName} : ${first.addressLine}";
      } catch(e) {
        print("Error occured: $e");
      }
    }

    return retVal;
  }
}