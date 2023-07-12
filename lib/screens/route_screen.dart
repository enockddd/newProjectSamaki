// import 'package:bus_app_screens/screens/CarScreen/CarScreen.dart';
// import 'package:flutter/material.dart';
// import '../widgets/custom_appbar.dart';
//
// import '../services/apiService.dart'; // Import your ApiService here
// import '../model/car.dart';
// import 'CarScreen/carsScreen.dart'; // Import your Car model here
//
// class RouteScreen extends StatefulWidget {
//   @override
//   _RouteScreenState createState() => _RouteScreenState();
// }
//
// class _RouteScreenState extends State<RouteScreen> {
//   Future<List<Car>>? _futureCars;
//   String? _currentToken;
//
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUserDetails();
//     _fetchCars();
//   }
//
//   void _fetchUserDetails() async {
//     _currentToken = await ApiService().getTokenFromPrefs(); // assume you have a method to get token in ApiService
//   }
//
//   Future<void> _fetchCars() async {
//     setState(() {
//       _futureCars = ApiService().getCars();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: 'Select a Car - ' + (_currentToken ?? '')),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 'Available Cars',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: ColorPalette.textColor,
//                 ),
//               ),
//               SizedBox(height: 24),
//               Expanded(
//                 child: RefreshIndicator(
//                   onRefresh: _fetchCars,
//                   child: FutureBuilder<List<Car>>(
//                     future: _futureCars,
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       } else if (snapshot.hasError) {
//                         return Text("Error: ${snapshot.error}");
//                       } else if (snapshot.hasData) {
//                         List<Car>? cars = snapshot.data;
//                         return ListView.builder(
//                           itemCount: cars?.length,
//                           itemBuilder: (context, index) {
//                             return InkWell(
//                               onTap: () async {
//                                 Car car = await ApiService().getCar(cars![index].carId);
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => CarScreen(cars: cars, startId: null,),
//                                   ),
//                                 );
//                               },
//                               child: Card(
//                                 elevation: 3,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(16.0),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Car ID: ${cars![index].carId}', // This line prints the car ID
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           color: ColorPalette.textColor,
//                                         ),
//                                       ),
//                                       Text(
//                                         'Car Name: ${cars[index].carName}',
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           color: ColorPalette.textColor,
//                                         ),
//                                       ),
//                                       SizedBox(height: 4),
//                                       Text(
//                                         'Cost: \tsh${cars[index].carCost}',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: ColorPalette.greyColor,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       }
//                       // fallback - if somehow the code reaches here,
//                       // display an empty container to avoid runtime errors.
//                       return Container();
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
