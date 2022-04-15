import 'package:flutter/material.dart';
import 'package:food_delivery_app/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //_navigateHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 150,
        ),
        Center(
          child: SizedBox(
            width: 200,
            height: 200,
            child: Image.network(
                "https://pngimg.com/uploads/burger_sandwich/burger_sandwich_PNG4135.png"),
          ),
        ),
        // Text(
        //   "F00D",
        //   style: GoogleFonts.dancingScript(
        //     fontSize: 45,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.red,
        //   ),
        // ),
        Text(
          "Delivary App",
          style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
              fontFamily: "updock"),
        ),
      ],
    ));
  }

  void _navigateHome() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AuthenticationWrapper()));
  }
}
