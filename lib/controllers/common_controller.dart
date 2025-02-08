import "dart:convert";
import "../library.dart";

class CommonController extends GetxController {
  final storageController = Get.find<StorageController>();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxString deviceId = 'Unknown'.obs;
  RxString userFCMToken = 'Unknown'.obs;
  RxList<UserData> users = <UserData>[].obs;

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
    userFCMToken.value = (await _fcm.getToken())!;
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(deviceId.value).get();
    if (userDoc.exists) {
      await _firestore.collection('users').doc(deviceId.value).update({
        'lastOpened': FieldValue.serverTimestamp(),
        'fcm_token': userFCMToken.value,
      });
    } else {
      await _firestore.collection('users').doc(deviceId.value).set({
        'device_id': deviceId.value,
        'fcm_token': userFCMToken.value,
        'lastOpened': FieldValue.serverTimestamp(),
      });
    }
    getUsersFCMToken();
  }

  getUsersFCMToken() async {
    userFCMToken.value = (await _fcm.getToken())!;
    QuerySnapshot<Map<String, dynamic>> userFCMTokens =
        await _firestore.collection('users').get();
    users.value =
        userFCMTokens.docs.map((doc) => UserData.fromFirestore(doc)).toList();
    // storageController.saveUserData(
    //     "allUsers", userFCMTokens.docs.map((doc) => doc.data()).toList());
    // Remove the user where fcm_token matches the current userFCMToken
    // usersData.removeWhere((user) => user['fcm_token'] == userFCMToken.value);
    // Print the list of user data
    print(userFCMTokens.docs.map((doc) => doc.data()).toList());
  }

  // Function to get the access token for your service account
  Future<String> getAccessToken(String title, String body) async {
    final String serviceAccountJson = await rootBundle
        .loadString('sri-kumaran-ew-firebase-adminsdk-fbsvc-489aa90508.json');
    final Map<String, dynamic> serviceAccount = jsonDecode(serviceAccountJson);

    try {
      // Send POST request with Dio
      final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(serviceAccount),
        ['https://www.googleapis.com/auth/cloud-platform'],
      );

      for (var user in users) {
        print(user.fcmToken);
        final notificationData = {
          'message': {
            'token': user.fcmToken.toString(),
            'notification': {'title': title, 'body': body}
          },
        };
        final response = await client.post(
          Uri.parse(
              'https://fcm.googleapis.com/v1/projects/sri-kumaran-ew/messages:send'),
          headers: {
            'content-type': 'application/json',
          },
          body: jsonEncode(notificationData),
        );
        print(response.body); // Success!
        if (response.statusCode == 200) {}
      }
      client.close();

      // if (response.statusCode == 200) {
      //   return "Success!"; // Success!
      // }
      return "Completed!"; // Completed!
    } catch (e) {
      throw Exception('Failed to retrieve access token');
    }
  }
}

class UserData {
  final Timestamp? lastOpened;
  final String? deviceId;
  final String? fcmToken;

  UserData({
    this.lastOpened,
    this.deviceId,
    this.fcmToken,
  });

  // A factory method to create an instance from Firestore data
  factory UserData.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return UserData(
      lastOpened: data['lastOpened'] as Timestamp,
      deviceId: data['device_id'] ?? '',
      fcmToken: data['fcm_token'] ?? '',
    );
  }

  // Method to convert the model to a map for storing in Firestore
  Map<String, dynamic> toMap() {
    return {
      'lastOpened': lastOpened, // Convert DateTime to Timestamp
      'device_id': deviceId,
      'fcm_token': fcmToken,
    };
  }
}
