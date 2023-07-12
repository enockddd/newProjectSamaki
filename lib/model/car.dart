class Car {
  final int carId;
  final String carName;
  final int carNumber;
  final int carSitCount;
  final double carCost;
  final bool isCarAvailable;

  Car({
    required this.carId,
    required this.carName,
    required this.carNumber,
    required this.carSitCount,
    required this.carCost,
    required this.isCarAvailable,
  });



  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      carId: json['car_id'],
      carName: json['car_name'],
      carNumber: json['car_number'],
      carSitCount: json['car_sit_count'],
      carCost: json['car_cost'].toDouble(),
      isCarAvailable: json['is_car_available'] == 1,
    );
  }

  @override
  String toString() {
    return 'Car{carId: $carId, carName: $carName, carNumber: $carNumber, carSitCount: $carSitCount, carCost: $carCost, isCarAvailable: $isCarAvailable}';
  }
}
