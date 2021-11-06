import 'package:get_storage/get_storage.dart';

class StorageHelper {
  static final GetStorage storage = GetStorage();

  static bool isFirstTime() {
    return storage.read<bool>(firstTimeKey) ?? true;
  }

  static void markFirstTime() {
    storage.write(firstTimeKey, true);
  }
}

const firstTimeKey = 'isFirstTimeUserKey@1eff';
