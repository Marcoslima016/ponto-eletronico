import 'dart:convert';
import '../../../../../../../lib.imports.dart';
import '../../activate.imports.dart';

abstract class IProcessQrResult {
  Future<LoginCredentials> call(String scanResult);
}

class ProcessQrResult implements IProcessQrResult {
  // IProcessQrResult usecaseProcessQrResult = ProcessQrResult();
  Future<LoginCredentials> call(String scanResult) async {
    String dataDecrypted = EncryptUtil.instance.decrypt(scanResult);
    LoginCredentials credentials = LoginCredentials.fromJson(jsonDecode(dataDecrypted));
    return credentials;
  }
}
