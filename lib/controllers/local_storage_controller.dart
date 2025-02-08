import "../library.dart";

class StorageController extends GetxController {
  // Define a variable to hold the instance of GetStorage
  final GetStorage _storage = GetStorage();

  // Function to save data
  void saveUserData(String key, dynamic value) {
    _storage.write(key, value);
  }

  // Function to get data
  Map<String, dynamic> getUserData(String key) {
    return _storage.read(key) ?? {};
  }

  // Function to clear data
  void clearUserData(String key) {
    _storage.remove(key);
  }
}
