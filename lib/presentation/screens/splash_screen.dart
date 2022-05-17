import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/presentation/screens/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 1))
        ..repeat(reverse: true);
  late final Animation<double> _animation = Tween<double>(begin: 1.0, end: 1.2)
      .animate(CurvedAnimation(
          parent: _animationController, curve: Curves.easeInOut));

  @override
  void initState() {
    super.initState();

    _navigateHome();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 150,
        ),
        ScaleTransition(
          scale: _animation,
          child: Center(
            child: SizedBox(
              width: 200.w,
              height: 200.h,
              child: Image.asset("assets/images/burger.png"),
            ),
          ),
        ),
        Text(
          "F00D",
          style: TextStyle(
              fontFamily: "GreatVibes",
              fontSize: 60.sp,
              color: Colors.red,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "Delivary App",
          style: TextStyle(
              fontFamily: "GreatVibes",
              fontSize: 55.sp,
              color: Colors.orange,
              fontWeight: FontWeight.bold),
        ),
      ],
    ));
  }

  void _navigateHome() async {
    await Future.delayed(const Duration(milliseconds: 4000));
    _animationController.stop();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}
