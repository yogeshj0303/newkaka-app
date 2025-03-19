import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;



Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
  print(message.notification?.title);
  print(message.notification?.body);
  print('Message data: ${message.data}');
}
class FirebaseApi {
  Future<void> sendTokenToBackend(String token) async {
    try {
      final response = await http.post(
        Uri.parse('https://newkakaautoparts.com/api/send-token?fcm_token=$token'
        ),
      );

      if (response.statusCode == 200) {
        print('Token successfully sent to backend.');
      } else {
        print('Failed to send token to backend: ${response.body}');
      }
    } catch (e) {
      print('Error sending token to backend: $e');
    }
  }
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final token = await _firebaseMessaging.getToken();
    print('Firebase Token: $token');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

}
