import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../version_handler.imports.dart';

class VersionHandlerFirebaseDatasource implements IVersionHandlerDatasource {
  DatabaseReference db = FirebaseDatabase.instance.reference();

  @override
  Future<String> getMinAppVersion() async {
    if (await _isOnline() == false) return "";

    DataSnapshot response;
    try {
      response = await db.child("APP_CONFIG/minAppVersion/").get();
      var p = "";
    } catch (e) {
      return "";
    }
    return response.value;
  }

  //

  //============================================== VERIFICAR CONEXAO =================================================

  //VERIFICAR SE ESTA ONLINE (Futuramente abstrair via camada external/driver)
  Future<bool> _isOnline() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network, make sure there is actually a net connection.
      if (await InternetConnectionChecker().hasConnection) {
        // Mobile data detected & internet connection confirmed.
        return true;
      } else {
        // Mobile data detected but no internet connection found.
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a WIFI network, make sure there is actually a net connection.
      if (await InternetConnectionChecker().hasConnection) {
        // Wifi detected & internet connection confirmed.
        return true;
      } else {
        // Wifi detected but no internet connection found.
        return false;
      }
    } else {
      // Neither mobile data or WIFI detected, not internet connection found.
      return false;
    }
  }
}
