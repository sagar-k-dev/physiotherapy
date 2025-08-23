import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'data/data.dart';
import 'res/res.dart';
import 'utils/navigators/navigators.dart';
import 'utils/utils.dart';

// Files to import
// connectivity_plus, device_info_plus, flutter_screenutil, flutter_secure_storage, get, http, package_info_plus, shared_preferences

void main() async {
  await _setup();
  runApp(const MyApp());
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(DeviceConfig()).init();
  Get.lazyPut(SharedPreferencesManager.new);
  await Future.wait([
    AppConfig.init(
      const EnvConfig(appTitle: AppConstants.appName, appFlavor: AppFlavor.dev),
    ),
    Get.put<DBWrapper>(DBWrapper()).init(),
  ]);
  Get.put<ApiWrapper>(ApiWrapper());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => ScreenUtilInit(
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.purple),
      translations: TranslationsFile(),
      getPages: AppPages.pages,
      initialRoute: AppPages.initial,
    ),
  );
}
