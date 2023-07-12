import 'package:bus_app_screens/screens/new_home_screen.dart';
import 'package:bus_app_screens/screens/routes/showRoutes.dart';
import 'package:bus_app_screens/screens/userRegistrationScreen/userRegistationClass.dart';
import 'package:flutter/material.dart';
import 'package:bus_app_screens/screens/route_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/users.dart';
import '../services/apiService.dart';
import 'cardRegistrationScreen/cardRegistrationClass.dart'; // Import your ApiService here

class BusStationLoginScreen extends StatefulWidget {
  @override
  _BusStationLoginScreenState createState() => _BusStationLoginScreenState();
}

class _BusStationLoginScreenState extends State<BusStationLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _apiService = ApiService(); // Initialize your ApiService here

  Future<bool> hasUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('user_id') && prefs.containsKey('username') && prefs.containsKey('email');
  }

  void main() async {
    bool hasData = await hasUserData();
    print(hasData); // true if user data is present, false otherwise
  }

  _login() async {
    try {
      final user = await _apiService.userloginWithEmailPassword(_emailController.text, _passwordController.text, context);
      print(user);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>
       // ShowRouteScreen()
          MyApp(),
          //RouteScreen(),
      ));
    } catch (e) {
      // You can display a dialog or snackbar here with the error message
      print(e.toString());
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bus Station',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 300,
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 300,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Login'),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationForm(), // Replace with your registration screen
                      ),
                    );
                  },
                  child: Text(
                    "If you don't have an account, register here",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyanAccent, // Changed color to blue
                      decoration: TextDecoration.underline, // Added underline
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CardRegistrationScreen(), // Replace with your registration screen
                      ),
                    );
                  },
                  child: Text(
                    "If you don't have an card, register here",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
