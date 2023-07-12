import 'package:bus_app_screens/screens/login.dart';
import 'package:bus_app_screens/screens/userRegistrationScreen/userRegistationClass.dart';
import 'package:bus_app_screens/services/apiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardRegistrationScreen extends StatefulWidget {
  @override
  _CardRegistrationScreenState createState() =>
      _CardRegistrationScreenState();
}

class _CardRegistrationScreenState extends State<CardRegistrationScreen> {
  final TextEditingController _cardNoController = TextEditingController();
  final TextEditingController _expireDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _cardNameController = TextEditingController();

  final _apiService = ApiService();

  _register() async {
    try {
      final account = await _apiService.cardRegistration(
          _cardNoController.text,
          _expireDateController.text,
          _cvvController.text,
          _cardNameController.text,
          context);

      // Display success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Card registered successfully!'),
      ));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BusStationLoginScreen(),
        ),
      );
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Registration failed!'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Mwendokasi.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Card Registration',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: _cardNoController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: 'Enter Card Number',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16), // limit length to 16 digits
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: _expireDateController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: 'Enter Card Expiry Date',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4), // limit length to 4 digits
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: _cvvController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: 'Enter CVV',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3), // limit length to 4 digits
                    ],
                    obscureText: true, // Use this line if you want the CVV to be hidden while typing
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: _cardNameController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: 'Enter Card Name',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _register,
                  child: Text('Register Card'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
