import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    // Prompt permission from the user
    await _firebaseMessaging.requestPermission();

    // Fetch the FCM token and await it to get the actual token.
  //  final String? fcmToken = await _firebaseMessaging.getToken();
/*
    if (fcmToken != null) {
      // Print the FCM token.
      print("This is the Firebase Token: $fcmToken");
    } else {
      print("Failed to get Firebase Token.");
    }
  */
  }  //function to initialize the background and foreground settings

}
