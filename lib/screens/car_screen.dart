// import 'package:flutter/material.dart';
// import '../widgets/custom_appbar.dart';
// import 'payment_screen.dart';
// import '../services/apiService.dart';  // Import the ApiService
// import '../model/car.dart';  // Import the Car model
//
// class CarScreendd extends StatefulWidget {
//   @override
//   _CarScreenState createState() => _CarScreenState();
// }
//
// class _CarScreenState extends State<CarScreen> {
//   Future<List<Car>>? _carList;
//
//   @override
//   void initState() {
//     super.initState();
//     _carList = ApiService().getCars();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: 'Car Details'),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 'Car Details',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: ColorPalette.textColor,
//                 ),
//               ),
//               SizedBox(height: 24),
//               Expanded(
//                 child: FutureBuilder<List<Car>>(
//                   future: _carList,
//                   builder: (BuildContext context, AsyncSnapshot<List<Car>> snapshot) {
//                     if (snapshot.hasData) {
//                       return ListView.builder(
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Card(
//                             elevation: 3,
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     snapshot.data![index].carName,
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                       color: ColorPalette.textColor,
//                                     ),
//                                   ),
//                                   SizedBox(height: 8),
//                                   Text(
//                                     'Car Number: ${snapshot.data![index].carNumber}',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: ColorPalette.textColor,
//                                     ),
//                                   ),
//                                   SizedBox(height: 8),
//                                   Text(
//                                     'Car Sit Count: ${snapshot.data![index].carSitCount}',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: ColorPalette.textColor,
//                                     ),
//                                   ),
//                                   SizedBox(height: 8),
//                                   Text(
//                                     'Car Cost: \$${snapshot.data![index].carCost}',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: ColorPalette.textColor,
//                                     ),
//                                   ),
//                                   SizedBox(height: 8),
//                                   Text(
//                                     'Is Car Available: ${snapshot.data![index].isCarAvailable ? 'Yes' : 'No'}',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: ColorPalette.textColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     } else if (snapshot.hasError) {
//                       return Text("${snapshot.error}");
//                     }
//                     // By default, show a loading spinner.
//                     return CircularProgressIndicator();
//                   },
//                 ),
//               ),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PaymentScreen(),
//                     ),
//                   );
//                 },
//                 child: Text('Proceed to Payment'),
//                 style: ElevatedButton.styleFrom(
//                   primary: ColorPalette.primaryColor,
//                   textStyle: TextStyle(fontSize: 18),
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
