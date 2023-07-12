import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shimmer/shimmer.dart';


class PaymentResultScreen extends StatefulWidget {
  final String message;
  final String carName;
  final String startName;
  final String destinationName;
  final String routeName;
  final String paymentId;
  final String createdDate;
  final String receiptNumber;

  const PaymentResultScreen({
    Key? key,
    required this.message,
    required this.carName,
    required this.startName,
    required this.destinationName,
    required this.routeName,
    required this.paymentId,
    required this.createdDate,
    required this.receiptNumber
  }) : super(key: key);

  @override
  _PaymentResultScreenState createState() => _PaymentResultScreenState();
}

class _PaymentResultScreenState extends State<PaymentResultScreen> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((_) {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _loading
            ? Shimmer.fromColors(
          baseColor: Colors.blue,
          highlightColor: Colors.lightBlueAccent,
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
          ),
        )
            : Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Message: ${widget.message}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text('Car Name: ${widget.carName}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Text('Start Name: ${widget.startName}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Text('Destination Name: ${widget.destinationName}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Text('Route Name: ${widget.routeName}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Text('Payment ID: ${widget.paymentId}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Text(' Date: ${widget.createdDate}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Text(' ticket number : ${widget.receiptNumber}', style: TextStyle(fontSize: 16)),
              ],
            )
          ),
        ),
      ),
    );
  }
}

