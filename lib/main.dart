import 'package:bus_app_screens/screens/cardRegistrationScreen/cardRegistrationClass.dart';
import 'package:bus_app_screens/screens/login.dart';
import 'package:bus_app_screens/screens/new_home_screen.dart';
import 'package:bus_app_screens/screens/route_screen.dart';
import 'package:bus_app_screens/screens/routes/showRoutes.dart';
import 'package:bus_app_screens/screens/userRegistrationScreen/userRegistationClass.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(BusStationApp());
}

class BusStationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Station App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home:
      //BusStationRegisterScreen(),
      //CardRegistrationScreen(),
      //BusStationLoginScreen()
      //RouteScreen(),
      BusStationLoginScreen (),
      //HomeScreen(),
    );
  }
}