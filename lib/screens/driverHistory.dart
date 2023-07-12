// import 'package:flutter/material.dart';
//
// class DriverPanel extends StatefulWidget {
//   @override
//   _DriverPanelState createState() => _DriverPanelState();
// }
//
// class _DriverPanelState extends State<DriverPanel> {
//   List<String> _ticketHistory = [
//     "Ticket 1",
//     "Ticket 2",
//     "Ticket 3",
//   ];
//
//   List<String> _currentPaidCustomers = [
//     "Customer 1",
//     "Customer 2",
//     "Customer 3",
//     "Customer 4",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Driver Panel"),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 16),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Text(
//               "Ticket History",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           SizedBox(height: 8),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _ticketHistory.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   title: Text(_ticketHistory[index]),
//                 );
//               },
//             ),
//           ),
//           SizedBox(height: 16),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Text(
//               "Current Paid Customers",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           SizedBox(height: 8),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _currentPaidCustomers.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   title: Text(_currentPaidCustomers[index]),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }