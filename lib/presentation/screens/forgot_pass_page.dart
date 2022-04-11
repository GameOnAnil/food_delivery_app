import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPassPage extends ConsumerWidget {
  ForgotPassPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password")),
      body: Form(
        key: _globalKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Image.asset("assets/images/forgot.png")),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Enter Email"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 55,
              width: MediaQuery.of(context).size.width * .8,
              child: ElevatedButton(
                  onPressed: () {}, child: const Text("Send Email")),
            )
          ]),
        ),
      ),
    );
  }
}
