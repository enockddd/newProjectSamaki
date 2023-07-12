// import 'package:flutter/material.dart';
// import '../widgets/custom_appbar.dart';
// import 'car_screen.dart';
//
//
// class RouteScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: 'Select a Car'),
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
//                 child: ListView.builder(
//                   itemCount: 10,
//                   itemBuilder: (context, index) {
//                     return InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => CarScreen(),
//                           ),
//                         );
//                       },
//                       child: Card(
//                         elevation: 3,
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Car ${index + 1}',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       color: ColorPalette.textColor,
//                                     ),
//                                   ),
//                                   SizedBox(height: 4),
//                                   Text(
//                                     'Cost: \tsh${(index + 1) * 100}',
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: ColorPalette.greyColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Icon(
//                                 Icons.arrow_forward_ios,
//                                 color: ColorPalette.primaryColor,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }