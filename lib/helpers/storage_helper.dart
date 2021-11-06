import 'package:get_storage/get_storage.dart';

class StorageHelper {
  static final GetStorage storage = GetStorage();

  static bool isFirstTime() {
    return storage.read<bool>('isFirstTimeUserKey@1eff') ?? false;
  }
}
