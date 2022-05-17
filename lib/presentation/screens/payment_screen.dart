import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PaymentScreen extends StatefulWidget {
  final String totalAmount;
  const PaymentScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState(totalAmount);
}

class _PaymentScreenState extends State<PaymentScreen> {
  final String totalAmount;

  _PaymentScreenState(this.totalAmount);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width.w;
    final screenHeight = MediaQuery.of(context).size.height.h;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Payment Method'),
      ),
      body: Container(
        padding: EdgeInsets.all(15.r),
        child: Column(
          children: [
            SizedBox(height: 15.r),
            Text(
              "Your Total Amount",
              style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            Text(
              "Rs." + totalAmount,
              style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 8,
            ),
            // For Button
            Expanded(
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                children: [
                  khaltiButton(context, screenWidth, screenHeight),
                  esewaButton(screenWidth, screenHeight),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _makeKhaltiPayment() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: 10,
        productIdentity: 'dells-sssssg5-g5510-2021',
        productName: 'Product Name',
      ),
      preferences: [
        PaymentPreference.khalti,
      ],
      onSuccess: (su) {
        const successsnackBar = SnackBar(
          content: Text('Payment Successful'),
        );
        ScaffoldMessenger.of(context).showSnackBar(successsnackBar);
        Navigator.of(context).popUntil(ModalRoute.withName("/cartlist"));
      },
      onFailure: (fa) {
        const failedsnackBar = SnackBar(
          content: Text('Payment Failed:'),
        );
        ScaffoldMessenger.of(context).showSnackBar(failedsnackBar);
      },
      onCancel: () {
        const cancelsnackBar = SnackBar(
          content: Text('Payment Cancelled'),
        );
        ScaffoldMessenger.of(context).showSnackBar(cancelsnackBar);
      },
    );
  }

  Widget esewaButton(double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 200.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                color: Colors.black.withOpacity(0.3),
                blurRadius: 3,
              ),
            ]),
        child: Column(
          children: [
            Image.network(
              "https://esewa.com.np/common/images/esewa-icon-large.png",
              width: screenWidth * .34,
              height: 150.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: FittedBox(
                child: Text(
                  'Pay With Esewa',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 43, 109, 28),
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget khaltiButton(
      BuildContext context, double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: _makeKhaltiPayment,
      child: Container(
        height: 200.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                color: Colors.black.withOpacity(0.3),
                blurRadius: 3,
              ),
            ]),
        child: Column(
          children: [
            Image.network(
              "https://avatars.githubusercontent.com/u/31564639?s=280&v=4",
              width: screenWidth * .4,
              height: 150.h,
            ),
            FittedBox(
              child: Text(
                'Pay With Khalti',
                style:
                    TextStyle(color: const Color(0xFF56328c), fontSize: 22.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
