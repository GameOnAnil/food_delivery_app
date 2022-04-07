// import 'package:flutter/material.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class LoginPage extends ConsumerWidget {
//   LoginPage({Key? key}) : super(key: key);

//   final GlobalKey<FormState> _formKey = GlobalKey();

//   final emailController = TextEditingController();
//   final passController = TextEditingController();

//   void validate(WidgetRef ref) {
//     if (_formKey.currentState!.validate()) {
//       debugPrint(
//           "EMail${emailController.text} and Pass:${passController.text}");
//       ref
//           .watch(authServiceProvider)
//           .signIn(email: emailController.text, password: passController.text);
//     } else {}
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       body: Form(
//         key: _formKey,
//         child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: ListView(
//               children: <Widget>[
//                 Container(
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.all(10),
//                   child: const Text(
//                     'Flutter Firebase Demo',
//                     style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 30),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   child: TextFormField(
//                     validator: ((value) {
//                       if (value!.isEmpty || !value.contains('@')) {
//                         return 'Invalid email!';
//                       }
//                       return null;
//                     }),
//                     controller: emailController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Email',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: TextFormField(
//                     validator: ((value) {
//                       if (value!.isEmpty || value.length < 8) {
//                         return 'Password is too short!';
//                       }
//                       return null;
//                     }),
//                     obscureText: true,
//                     controller: passController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Password',
//                     ),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     //forgot password screen
//                   },
//                   child: const Text(
//                     'Forgot Password',
//                   ),
//                 ),
//                 Container(
//                     height: 50,
//                     padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                     child: ElevatedButton(
//                       child: const Text('Login'),
//                       onPressed: () {
//                         validate(ref);
//                       },
//                     )),
//                 Row(
//                   children: <Widget>[
//                     const Text('Does not have account?'),
//                     TextButton(
//                       child: const Text(
//                         'Sign Up',
//                         style: TextStyle(fontSize: 20),
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => SignUpPage()),
//                         );
//                       },
//                     )
//                   ],
//                   mainAxisAlignment: MainAxisAlignment.center,
//                 ),
//               ],
//             )),
//       ),
//     );
//   }
// }
