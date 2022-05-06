import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/presentation/screens/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/presentation/screens/login_page.dart';
import 'package:food_delivery_app/utils/my_shared_pref.dart';

Widget defaultHome = LoginPage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MySharedPreference.init();

  bool isLoggedIn = MySharedPreference.userExists();
  log(isLoggedIn.toString());
  if (isLoggedIn) {
    defaultHome = const HomePage();
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: defaultHome);
  }
}

// class AuthenticationWrapper extends StatelessWidget {
//   const AuthenticationWrapper({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final Future<FirebaseApp> _init = Firebase.initializeApp();
//     return FutureBuilder(
//       future: _init,
//       builder: ((context, snapshot) {
//         if (snapshot.hasError) {
//           return const Center(child: Text("Something went wrong"));
//         }
//         if (snapshot.connectionState == ConnectionState.done) {
//           return const AuthChecker();
//         }
//         return const Scaffold(
//           body: Center(child: CircularProgressIndicator()),
//         );
//       }),
//     );
//   }
// }

// class AuthChecker extends ConsumerWidget {
//   const AuthChecker({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(authStateProvider);

//     return state.when(
//         data: ((data) {
//           if (data != null) {
//             return const HomePage();
//           } else {
//             return LoginPage();
//           }
//         }),
//         error: (e, s) {
//           return const Center(child: Text("Some error"));
//         },
//         loading: () => const Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             ));
//   }
// }
