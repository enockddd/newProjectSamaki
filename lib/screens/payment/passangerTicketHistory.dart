import 'package:flutter/material.dart';

import '../arrivalScreen.dart';

class Ticket {
  final String name;
  final double price;

  Ticket({required this.name, required this.price});
}

class TicketTransaction {
  final Ticket ticket;
  final bool isRefund;
  final DateTime timestamp;

  TicketTransaction({required this.ticket, required this.isRefund})
      : timestamp = DateTime.now();
}

class DriverPanel extends StatefulWidget {
  @override
  _DriverPanelState createState() => _DriverPanelState();
}

class _DriverPanelState extends State<DriverPanel> {
  List<Ticket> _tickets = [
    Ticket(name: "Ticket 1", price: 500),
    Ticket(name: "Ticket 2", price: 800),
    Ticket(name: "Ticket 3", price: 1000),
  ];

  List<String> _currentPaidCustomers = [
    "Customer 1",
    "Customer 2",
    "Customer 3",
    "Customer 4",
  ];

  List<TicketTransaction> _transactions = [];

  double get totalIncome {
    double income = 0.0;
    _transactions.forEach((transaction) {
      if (!transaction.isRefund) {
        income += transaction.ticket.price;
      }
    });
    return income;
  }

  void _sellTicket(Ticket ticket) {
    setState(() {
      _transactions.add(TicketTransaction(ticket: ticket, isRefund: false));
    });
  }

  void _refundTicket(Ticket ticket) {
    setState(() {
      _transactions.add(TicketTransaction(ticket: ticket, isRefund: true));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Panel"),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Color.fromRGBO(255, 255, 255, 0.8), // Opacity set to 80%
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Ticket Sales",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: _tickets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(_tickets[index].name),
                        subtitle: Text(
                            "\tsh${_tickets[index].price.toStringAsFixed(2)}"),
                        trailing: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => _sellTicket(_tickets[index]),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Current Paid Customers",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: _currentPaidCustomers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(_currentPaidCustomers[index]),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => setState(() {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => ArrivalScreen()),
                            // );
                            _currentPaidCustomers.removeAt(index);
                          }),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Ticket Transactions",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: _transactions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(_transactions[index].ticket.name),
                        subtitle: Text(_transactions[index].isRefund
                            ? "Refund"
                            : "Sale" +
                                " - " +
                                _transactions[index].timestamp.toString()),
                        trailing: IconButton(
                          icon: Icon(Icons.undo),
                          onPressed: () =>
                              _refundTicket(_transactions[index].ticket),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Income: sh${totalIncome.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                child: Text("New Customer"),
                onPressed: () => setState(() {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ArrivalScreen()),
                  // );
                  _currentPaidCustomers.add("New Customer");
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Arrival {}
