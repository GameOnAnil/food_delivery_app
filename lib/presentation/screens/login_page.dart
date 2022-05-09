import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:food_delivery_app/presentation/screens/home_page.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:food_delivery_app/presentation/screens/sign_up_page.dart';
import 'package:food_delivery_app/riverpod/notifier/login_notifier.dart';
import 'package:food_delivery_app/riverpod/providers/providers.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final emailController = TextEditingController();

  final passController = TextEditingController();

  void validate(WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      await ref
          .read(loginStateNotifierProvider.notifier)
          .signIn(emailController.text.trim(), passController.text.trim());
    } else {
      Fluttertoast.showToast(
          msg: "Please Enter Detail",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login Page 2"),
        elevation: 0.0,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(loginStateNotifierProvider);

          ref.listen<LoginState>(loginStateNotifierProvider, (previous, next) {
            if (next is LoginSuccess) {
              Fluttertoast.showToast(msg: "Login success");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            }
          });

          if (state is LoginLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoginFailure) {
            return _buildFailure(state, ref);
          } else if (state is LoginSuccess) {
            // Fluttertoast.showToast(msg: "Login success");
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const HomePage()));
            return _buildInitialDetail(context, ref);
          } else {
            return _buildInitialDetail(context, ref);
          }
        },
      ),
    );
  }

  Padding _buildFailure(LoginFailure state, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text("Error: " + state.exception),
          ),
          IconButton(
              onPressed: () {
                ref.read(loginStateNotifierProvider.notifier).resetState();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
    );
  }

  Widget _buildInitialDetail(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset("assets/images/signin.png"),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    validator: ((value) {
                      // if (value!.isEmpty || !value.contains('@')) {
                      if (value!.isEmpty) {
                        return 'Invalid email!';
                      }
                      return null;
                    }),
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    validator: ((value) {
                      if (value!.isEmpty || value.length < 8) {
                        return 'Password is too short!';
                      }
                      return null;
                    }),
                    obscureText: true,
                    controller: passController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: const ButtonStyle(alignment: Alignment.centerRight),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => ForgotPassPage()),
                      // );
                    },
                    child: const Text(
                      'Forgot Password',
                    ),
                  ),
                ),
                Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        validate(ref);
                      },
                    )),
                const SizedBox(
                  height: 8,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                ),
                const Align(alignment: Alignment.center, child: Text("Or")),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  height: 45,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: SignInButton(
                    Buttons.Google,
                    text: "Sign In with Google",
                    onPressed: () async {
                      try {
                        await ref.read(firebaseServiceProvider).signIn();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                          ModalRoute.withName('/home'),
                        );
                      } catch (e) {
                        Fluttertoast.showToast(msg: e.toString());
                      }
                    },
                    elevation: 0,
                  ),
                ),
                Row(
                  children: <Widget>[
                    const Text('Does not have account?'),
                    TextButton(
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          )),
    );
  }
}
