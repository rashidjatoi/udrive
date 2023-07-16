import 'package:connectivity_plus/connectivity_plus.dart';

class CheckInternetService {
  static Future<String> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      return "You're not connected to a network";
    } else {
      return "You're connected to a ${connectivityResult.name} network";
    }
  }
}
