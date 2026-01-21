import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await _notifications.initialize(settings);
  }

  static Future<void> showOtpNotification(String otp) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'otp_channel',
      'OTP Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails details =
        NotificationDetails(android: androidDetails);

    await _notifications.show(
      0,
      'OTP Verification',
      'Your OTP is $otp',
      details,
    );
  }
}




class OtpDemoScreen extends StatelessWidget {
  const OtpDemoScreen({super.key});

  String generateOtp() {
    return (1000 + Random().nextInt(9000)).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Demo')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            String otp = generateOtp();
            LocalNotificationService.showOtpNotification(otp);
          },
          child: const Text('Generate OTP'),
        ),
      ),
    );
  }
}
