import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:udrive/constants/key_constants.dart';
import 'package:udrive/helpers/request_helper.dart';

class HelperMethods {
  static Future<String> findCordinateMethod(
      Position position, BuildContext context) async {
    String placeAddress = '';

    var connectivityResults = await Connectivity().checkConnectivity();
    if (connectivityResults != ConnectivityResult.mobile &&
        connectivityResults != ConnectivityResult.wifi) {
      return placeAddress;
    }

    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$kMapKey';

    var response = await RequestHelper.getRequest(url);
    if (response != "failed") {
      placeAddress = response['results'][0]['formatted_address'];

      // AddressModel addressModel = AddressModel(
      //     placeName: placeAddress,
      //     latiture: position.latitude,
      //     longitude: position.longitude,
      //     placeId: "",
      //     placeFormattedAddress: "");
      // Provider.of<AppDataProvider>(context, listen: false)
      //     .updatePickupAddress(addressModel);
    }

    return placeAddress;
  }
}
