import 'package:get_storage/get_storage.dart';
import 'package:vloo_tv_v2/app/data/models/pairing_result.dart';

enum Role {
  owner,
  member;

  String? get value => name;
}

class SharedPreferences {
  static final box = GetStorage();
  static const String _keyQrCode = 'QrCode';
  static const String _keyStoredMediaFlag = 'StoredMediaFlag';
  static const String _keyPairingResultFlag = 'PairingResult';

  static void saveQrCode(String code) async {
    box.write(_keyQrCode, code);
  }

  static void saveStoredMediaFlag(bool flag) async {
    box.write(_keyStoredMediaFlag, flag);
  }

  static void savePairingResultObject(PairingResult model) async {
    box.write(_keyPairingResultFlag, model.toJson());
  }

  static String? getQrCode() {
    return box.read(_keyQrCode);
  }

  static bool getStoredMediaFlag() {
    return box.read(_keyStoredMediaFlag) ?? false;
  }

  static PairingResult getPairingResultObject() {
    return PairingResult.fromJson(box.read(_keyPairingResultFlag));
  }

  static void deleteQrCode() async {
    box.remove(_keyQrCode);
  }
}
