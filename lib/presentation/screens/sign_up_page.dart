import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:food_delivery_app/provider/signup_notifier.dart';

class SignUpPage extends ConsumerWidget {
  SignUpPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmpassController = TextEditingController();
  final nameController = TextEditingController();

  void validate(WidgetRef ref) {
    if (_formKey.currentState!.validate()) {
      ref
          .read(signUpNotifierProvider.notifier)
          .signUp(emailController.text, passController.text);
      //Fluttertoast.showToast(msg: "Verified");
    } else {
      Fluttertoast.showToast(
          msg: "Please Enter Detail",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Sign Up Page"),
        elevation: 0.0,
      ),
      body: Consumer(builder: (context, ref, child) {
        final state = ref.watch(signUpNotifierProvider);
        if (state is SignupLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SignupFailure) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text("Failed" + state.exception),
                ),
                IconButton(
                    onPressed: () {
                      ref.read(signUpNotifierProvider.notifier).reset();
                    },
                    icon: Icon(Icons.refresh))
              ],
            ),
          );
        } else if (state is SignupSuccess) {
          Navigator.pop(context);
          return _buildInitialData(context, ref);
        } else {
          return _buildInitialData(context, ref);
        }
      }),
    );
  }

  Widget _buildInitialData(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("assets/images/signup.png"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return 'Name Cannot be empty';
                        }
                        return null;
                      }),
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty || !value.contains('@')) {
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
                  Container(
                    padding: const EdgeInsets.all(10),
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
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Password is too short!';
                        } else if (value != passController.text) {
                          return 'Password Does Not Match';
                        }

                        return null;
                      }),
                      obscureText: true,
                      controller: confirmpassController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      height: 50,
                      width: 250,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          validate(ref);
                        },
                      )),
                ],
              )),
        ),
      ),
    );
  }
}
