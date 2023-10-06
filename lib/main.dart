import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uber_app/controllers/auth_controller.dart';
import 'package:uber_app/provider/app_data.dart';
import 'package:uber_app/vendor/controllers/banner_controller.dart';
import 'package:uber_app/views/screens/auth/login_screen.dart';
import 'package:uber_app/views/screens/auth/welcome_screen/welcome_register_screen.dart';

void main() async {
  // Ensure that Flutter is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase.
  await Firebase.initializeApp().then((value) {
    // Initialize your controllers or services here.
    // If you're using GetX, you can put your controllers here.
    Get.put(AuthController());
  });

  // Wrap your app with ProviderScope to use Riverpod for state management.
  runApp(
    riverpod.ProviderScope(
      child: MultiProvider(providers: [
        ChangeNotifierProvider(create: (
          _,
        ) {
          return AppData();
        })
      ], child: const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: WelcomeRegisterScren(),
      builder: EasyLoading.init(),
      initialBinding: BindingsBuilder(
        () {
          Get.put<BannerController>(
            BannerController(),
          );
        },
      ),
    );
  }
}
