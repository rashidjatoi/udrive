import 'package:flutter/foundation.dart';

class AppDataProvider extends ChangeNotifier {
  // late AddressModel pickupAddress;
  String pickupAddress = '';
  // void updatePickupAddress(AddressModel pickup) {
  //   pickupAddress = pickup;
  //   notifyListeners();
  // }

  void updatePickupAddress(pickup) {
    pickupAddress = pickup;
    notifyListeners();
  }
}
