import 'package:bus_app_screens/screens/payment/passangerTicketHistory.dart';
import 'package:flutter/material.dart';
import '../../util/spherical.dart';
import '../../widgets/custom_appbar.dart';
import '../arrivalScreen.dart';
import '../driverHistory.dart';

class PaymentSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Payment Success',),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                color: ColorPalette.primaryColor,
                size: 100,
              ),
              SizedBox(height: 24),
              Text(
                'Payment Successful!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.textColor,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Thank you for using our service. Your payment has been successfully processed.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: ColorPalette.textColor,
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  LatLng source = LatLng(37.4219999,-122.0840575);
                  LatLng destination = LatLng(37.7749,-122.4194);
                  // Navigate to the home screen or any other desired screen
                  //Navigator.popUntil(context, (route) => route.isFirst);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ArrivalScreen(),
                  //   ),
                  //);
                },
                child: Text('Back to Home'),
                style: ElevatedButton.styleFrom(
                  primary: ColorPalette.primaryColor,
                  textStyle: TextStyle(fontSize: 18),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}