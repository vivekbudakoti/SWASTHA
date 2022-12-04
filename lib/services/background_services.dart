// import 'dart:async';
// import 'dart:math';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       // this will executed when app is in foreground or background in separated isolate
//       onStart: onStart,

//       // auto start service
//       autoStart: true,
//       isForegroundMode: true,
//     ),
//     iosConfiguration: IosConfiguration(
//       // auto start service
//       autoStart: true,

//       // this will executed when app is in foreground in separated isolate
//       onForeground: onStart,

//       // you have to enable background fetch capability on xcode project
//       onBackground: onIosBackground,
//     ),
//   );
//   service.startService();
// }

// // to ensure this executed
// // run app from xcode, then from xcode menu, select Simulate Background Fetch
// bool onIosBackground(ServiceInstance service) {
//   WidgetsFlutterBinding.ensureInitialized();

//   return true;
// }

// void onStart(ServiceInstance service) async {
//   // Only available for flutter 3.0.0 and later
//   DartPluginRegistrant.ensureInitialized();
//   double x = 0.0;
//   double y = 0.0;
//   double z = 0.0;

//   int steps = 0;
//   double previousDistacne = 0.0;
//   double distance = 0.0;

//   // For flutter prior to version 3.0.0
//   // We have to register the plugin manually

//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });

//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }

//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });

//   double getValue(double x, double y, double z) {
//     double magnitude = sqrt(x * x + y * y + z * z);
//     previousDistacne = preferences.getDouble("preValue") ?? 0.0;
//     double modDistance = magnitude - previousDistacne;
//     preferences.setDouble("preValue", magnitude);
//     return modDistance;
//   }

//   // bring to foreground
//   Timer.periodic(const Duration(seconds: 1), (timer) async {
//     SensorsPlatform.instance.accelerometerEvents.listen((event) {
//       x = event.x;
//       y = event.y;
//       z = event.z;
//       distance = getValue(x, y, z);
//       if (distance > 6) {
//         steps++;
//       }
//       preferences.setInt('steps', steps);
//     });

//     if (service is AndroidServiceInstance) {
//       service.setForegroundNotificationInfo(
//         title: "Steps Count $steps",
//         content: "Keep Moving",
//       );
//     }

//     /// you can see this log in logcat

//     // test using external plugin
//   });
// }
