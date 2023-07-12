import 'dart:convert';

import 'package:bus_app_screens/screens/payment/payment_success_screen.dart';
import 'package:flutter/material.dart';

import '../../services/apiService.dart';
import '../../widgets/custom_appbar.dart';
import '../receipts/receiptsClass.dart';

class PaymentScreen extends StatefulWidget {
  final int carId;
  final int startId;
  final int destinationId;
  final int routeId;

  PaymentScreen({
    required this.carId,
    required this.startId,
    required this.destinationId,
    required this.routeId,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final ApiService apiService = ApiService();

  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _cardExpiryController = TextEditingController();
  TextEditingController _cardCvvController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardExpiryController.dispose();
    _cardCvvController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Payment'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _cardNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Card Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _cardExpiryController,
                    decoration: InputDecoration(
                      labelText: 'Expiry Date',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _cardCvvController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Text('Car ID: ${widget.carId}'),
                Text('Start ID: ${widget.startId}'),
                Text('Destination ID: ${widget.destinationId}'),
                Text('Route ID: ${widget.routeId}'),

                ElevatedButton(
                  onPressed: () async {
                    final cardNumber = _cardNumberController.text;
                    final expiryDate = _cardExpiryController.text;
                    final cvv = _cardCvvController.text;
                    final amount = _amountController.text;

                    try {
                      await apiService.makePayment(
                        context,
                        cardNumber,
                        expiryDate,
                        cvv,
                        widget.carId,
                        widget.startId,
                        widget.destinationId,
                        widget.routeId,
                        amount,
                      );


                      // Payment successful, navigate to success screen if needed
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => PaymentResultScreen(
                      //       message: responseBody['message'],
                      //       carName: responseBody['car_name'],
                      //       startName: responseBody['start_name'],
                      //       destinationName: responseBody['destination_name'],
                      //       routeName: responseBody['route_name'],
                      //       paymentId: responseBody['payment_id'],),
                      //   ),
                      // );
                    } catch (e) {
                      // Handle payment failure scenario
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Payment Failed'),
                          content: Text('Failed to make payment. Please try again.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Text('Pay'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorPalette.primaryColor,
                    textStyle: TextStyle(fontSize: 18),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
