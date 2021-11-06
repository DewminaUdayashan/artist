import 'package:get_storage/get_storage.dart';

class StorageHelper {
  static final GetStorage storage = GetStorage();

  static bool isFirstTime() {
    final val = storage.read<bool>(firstTimeKey);
    print(val);
    if (val == null) {
      return true;
    } else if (val is bool) {
      return val;
    } else {
      print(val);
      return true;
    }
  }

  static void markFirstTime() {
    print('User Marked');
    storage.write(firstTimeKey, false);
  }
}

const firstTimeKey = 'isFirstTimeUserKey@1eff';
