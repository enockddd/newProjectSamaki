class BusRoute {
  final int routeId;
  final String routeName;
  final int carId;
  final int carCount;
  final int startId;
  final String startName;  // add this
  final int destinationId;
  final String destinationName;  // add this

  BusRoute({
    required this.routeId,
    required this.routeName,
    required this.carId,
    required this.carCount,
    required this.startId,
    required this.startName,  // add this
    required this.destinationId,
    required this.destinationName,  // add this
  });

  factory BusRoute.fromJson(Map<String, dynamic> json) {
    return BusRoute(
      routeId: json['route_id'],
      routeName: json['route_name'],
      carId: json['car_id'],
      carCount: json['car_count'],
      startId: json['start_id'],
      startName: json['start_name'],  // add this
      destinationId: json['destination_id'],
      destinationName: json['destination_name'],  // add this
    );
  }
}
