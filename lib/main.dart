import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(mainApp());
}

DevicePreview mainApp() {
  return DevicePreview(
    enabled: false,
    builder: (_) => ScreenUtilInit(
      designSize: const Size(394, 916),
      builder: (_, __) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

        return GetMaterialApp(
          title: "booking_doctor_mobile",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          themeMode: ThemeMode.light,
        );
      },
    ),
  );
}
