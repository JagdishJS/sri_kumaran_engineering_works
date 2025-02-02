import "dart:io";
import "package:excel/excel.dart";
import "../library.dart";

class CommonController extends GetxController {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var deviceId = 'Unknown'.obs;

  @override
  void onInit() {
    super.onInit();
    updateFCMToken();
    requestPermission();
  }

  void requestPermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      print("Storage permission granted");
    } else {
      print("Storage permission denied");
    }
  }

  // Function to get device info
  Future<void> getDeviceId() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (GetPlatform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId.value = "${androidInfo.device}_${androidInfo.brand}";
      }
    } catch (e) {
      deviceId.value = "Unknown_ID_";
    }
  }

  updateFCMToken() async {
    await getDeviceId();
    String? token = await _fcm.getToken();
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(deviceId.value).get();
    if (userDoc.exists) {
    } else {
      await _firestore.collection('users').doc(deviceId.value).set({
        'device_id': deviceId.value,
        'fcm_token': token,
        'lastOpened': FieldValue.serverTimestamp(),
      });
    }
  }
}
