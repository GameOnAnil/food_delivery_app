import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/presentation/screens/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/presentation/screens/splash_screen.dart';
import 'package:food_delivery_app/utils/my_shared_pref.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

Widget defaultHome = const SplashScreen();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await MySharedPreference.init();

  bool isLoggedIn = MySharedPreference.userExists();
  log("Logged In " + isLoggedIn.toString());
  if (isLoggedIn) {
    defaultHome = const HomePage();
  }
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390.0, 844.0),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context) {
          return KhaltiScope(
              publicKey: "test_public_key_8c1d7e770e1748c4bed2ffc2f3509ba8",
              builder: (context, navigationKey) {
                return MaterialApp(
                    navigatorKey: navigationKey,
                    supportedLocales: const [
                      Locale('en', 'US'),
                      Locale('ne', 'NP'),
                    ],
                    localizationsDelegates: const [
                      KhaltiLocalizations.delegate,
                    ],
                    debugShowCheckedModeBanner: false,
                    title: 'Flutter Demo',
                    theme: ThemeData(
                      primarySwatch: Colors.deepPurple,
                    ),
                    home: defaultHome);
              });
        });
  }
}
