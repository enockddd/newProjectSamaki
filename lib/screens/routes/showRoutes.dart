import 'package:bus_app_screens/model/route.dart';
import 'package:bus_app_screens/screens/CarScreen/CarScreen.dart';
import 'package:bus_app_screens/services/apiService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/car.dart';
import '../../model/users.dart';
import '../../widgets/custom_appbar.dart';
import '../CarScreen/carsScreen.dart';

class ShowRouteScreen extends StatefulWidget {
  @override
  _ShowRouteScreenState createState() => _ShowRouteScreenState();
}

class _ShowRouteScreenState extends State<ShowRouteScreen> {
  Future<List<BusRoute>>? _futureRoutes;
  String? _username;
  String? _email;
  String? _token;

  void _fetchUserDetails() async {
    final apiService = ApiService(); // don't forget to import ApiService at the top
    final Users user = await apiService.getUserFromPrefs();
    setState(() {
      _username = user.username;
      _email = user.email;
      _token = user.token;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchRoutes();
    _fetchUserDetails();
  }


  Future<void> _fetchRoutes() async {
    setState(() {
      _futureRoutes = ApiService().getRoutes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Select Routes ${_username}',
        // username: _username,
        // email: _email,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Available Routes R',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.textColor,
                ),
              ),
              SizedBox(height: 24),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _fetchRoutes,
                  child: FutureBuilder<List<BusRoute>>(
                    future: _futureRoutes,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (snapshot.hasData) {
                        List<BusRoute>? routes = snapshot.data;
                        return ListView.builder(
                          itemCount: routes?.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                List<Car> cars = await ApiService().getCarsByRouteId(routes![index].routeId);
                                if (cars.isNotEmpty) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CarScreen(
                                        cars: cars,
                                        startId: routes![index].startId,
                                        destinationId: routes![index].destinationId,
                                        routeId: routes![index].routeId,
                                      ),
                                    ),
                                  );
                                } else {
                                  // handle the situation when there are no cars
                                }
                              },
                              child: Card(
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                  Text(
                                  'Route Name: ${routes?[index].routeName}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: ColorPalette.textColor,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Start: ${routes?[index].startName} id : ${routes?[index].startId}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: ColorPalette.greyColor,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Destination: ${routes?[index]
                                        .destinationName} id : ${routes?[index].destinationId}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: ColorPalette.greyColor,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'route Id: ${routes?[index].routeId}',
                                    style: TextStyle(
                                    fontSize: 14,
                                    color: ColorPalette.greyColor,
                                  ),
                                ),
                                ],
                              ),
                            ),)
                            ,
                            );
                          },
                        );
                      }
// fallback - if somehow the code reaches here,
// display an empty container to avoid runtime errors.
                      return Container();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}