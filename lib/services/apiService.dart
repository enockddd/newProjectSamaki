import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/accounts.dart';
import '../model/car.dart';
import '../model/route.dart';
import '../model/users.dart';
import '../screens/receipts/receiptsClass.dart';  // Import your Car model here
import 'package:twilio_flutter/twilio_flutter.dart';


class ApiService {
 // final String url = "http://192.168.43.26:5000";
  final String url = "http://192.168.100.26:5000";



  String parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');


    }

    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final resp = utf8.decode(base64Url.decode(normalized));

    return resp;
  }
//////////////////////////////////////////////////////////gettoken
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<String?> getTokenFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
//////////////////////////////////////////////gettoken////////////////

  Future<Users> getUserFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return Users(
      userId: prefs.getInt('user_id'),
      email: prefs.getString('email'),
      username: prefs.getString('username'),
      userRole: prefs.getString('user_role'),
      token: prefs.getString('token'),
      phoneNumber: prefs.getString('phone_number')
    );
  }

  Future<void> saveUserToPrefs(Users user) async {
    final prefs = await SharedPreferences.getInstance();

    if (user.userId != null) {
      prefs.setInt('user_id', user.userId!);
    }
    if (user.email != null) {
      prefs.setString('email', user.email!);
    }
    if (user.username != null) {
      prefs.setString('username', user.username!);
    }
    if (user.userRole != null) {
      prefs.setString('user_role', user.userRole!);
    }
    if (user.token != null) {
      prefs.setString('token', user.token!);
    }
    print("sharedPreference : ${user.token}");
    print("sharedPreference : ${user.userRole}");
  }

  Future<Accounts> getAccountFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return Accounts(
      accountId: prefs.getInt('account_id'),
      cardNo: prefs.getString('card_no'),
      expireDate: prefs.getString('expire_date'),
      cvv: prefs.getString('cvv'),
      balance: prefs.getDouble('balance'),
      cardName: prefs.getString('card_name'),
    );
  }

  Future<void> saveAccountToPrefs(Accounts account) async {
    final prefs = await SharedPreferences.getInstance();

    if (account.accountId != null) {
      prefs.setInt('account_id', account.accountId!);
    }
    if (account.cardNo != null) {
      prefs.setString('card_no', account.cardNo!);
    }
    if (account.expireDate != null) {
      prefs.setString('expire_date', account.expireDate!);
    }
    if (account.cvv != null) {
      prefs.setString('cvv', account.cvv!);
    }
    if (account.balance != null) {
      prefs.setDouble('balance', account.balance!);
    }
    if (account.cardName != null) {
      prefs.setString('card_name', account.cardName!);
    }
    print("sharedPreference : ${account.accountId}");
    print("sharedPreference : ${account.cardNo}");
  }

  Future<Accounts> cardRegistration(String cardNo, String expireDate, String cvv, String cardName, BuildContext context) async {
    try {
      var response = await http.post(
        Uri.parse(url + '/api/v1/cardRegistration'), // Actual API endpoint
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'card_no': cardNo,
          'expire_date': expireDate,
          'cvv': cvv,
          'card_name': cardName,
        }),
      );

      if (response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);

        // Decode the JWT token
        final decodedToken = parseJwt(jsonData['token']);
        final payloadMap = json.decode(decodedToken);

        Accounts account = Accounts(
          accountId: payloadMap['account_id'] as int?,
          cardNo: payloadMap['card_no'] as String?,
          expireDate: payloadMap['expire_date'] as String?,
          cardName: payloadMap['card_name'] as String?,
        );

        await saveAccountToPrefs(account);

        return account;
      } else {
        var jsonData = jsonDecode(response.body);
        String errorMessage = jsonData['error'];
        if (errorMessage == null || errorMessage.isEmpty) {
          errorMessage = 'An error occurred';
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      print(e);
      throw Exception('Error while connecting to API');
    }
  }


  Future<Users?> registerUser(Users user, BuildContext context) async {
    var response = await http.post(
      Uri.parse(url + '/api/v1/user_registration'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    // Print the response body
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      // Successfully registered
      // Return the registered user
      return Users.fromJson(jsonDecode(response.body));
    } else {
      // Parse the response body for error message
      var errorResponse = jsonDecode(response.body);
      String errorMessage = errorResponse['error'] ?? 'Unknown error';

      if (response.statusCode == 400) {
        throw Exception(errorMessage);
      } else if (response.statusCode == 409) {
        throw Exception(errorMessage);
      } else {
        throw Exception(
            'Failed to register user. Status code: ${response.statusCode}. Error: $errorMessage');
      }
    }
  }


  Future<Users> userloginWithEmailPassword(String email, String password, BuildContext context) async {
    try {
      var response = await http.post(
        Uri.parse(url + '/api/v1/login_session'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        final decodedToken = parseJwt(jsonData['token']);
        final payloadMap = json.decode(decodedToken);

        Users user = Users(
          userId: payloadMap['user_id'] as int?,
          email: payloadMap['email'] as String?,
          username: payloadMap['username'] as String?,
          userRole: payloadMap['user_role'] as String?,
          token: jsonData['token'] as String?,
          phoneNumber: payloadMap['phone_number'] as String?,
        );

        SharedPreferences prefs = await SharedPreferences.getInstance();

        if (user.userId != null) {
          await prefs.setInt('user_id', user.userId!);
        }
        if (user.username != null) {
          await prefs.setString('username', user.username!);
        }
        if (user.email != null) {
          await prefs.setString('email', user.email!);
        }
        if (user.userRole != null) {
          await prefs.setString('user_role', user.userRole!);
        }
        if (user.token != null) {
          await prefs.setString('token', user.token!);
        }

        print(prefs.getInt('user_id')); // for debugging
        print(prefs.getString('username')); // for debugging
        print(prefs.getString('email')); // for debugging
        print(prefs.getString('user_role')); // for debugging
        print(prefs.getString('token')); // for debugging

        await saveUserToPrefs(user);

        return user;
      } else {
        var jsonData = jsonDecode(response.body);
        String errorMessage = jsonData['error'];
        if (errorMessage == null || errorMessage.isEmpty) {
          errorMessage = 'An error occurred';
        }
        throw Exception(errorMessage);
      }
    } catch(e) {
      print(e); // you can handle the error in a better way, this is for demonstration
      throw Exception('Error while connecting to API');
    }
  }






  Future<List<Car>> getCars() async {
    final response = await http.get(Uri.parse(url+'/api/v1/cars'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Car> cars = body
          .map(
            (dynamic item) => Car.fromJson(item),
      )
          .toList();
          print(cars);
      return cars;
    } else {
      throw Exception("Failed to load cars");
    }
  }


  Future<Car> getCar(int carId) async {
    final response = await http.get(Uri.parse(url+'/api/v1/cars'));

    if (response.statusCode == 200) {
      List<dynamic> carsData = jsonDecode(response.body);

      // Find the car with the specified carId
      Map<String, dynamic>? carData = carsData.firstWhere((car) => car['car_id'] == carId, orElse: () => null);

      if (carData != null) {
        Car car = Car.fromJson(carData);
        return car;
      } else {
        throw Exception('Car not found');
      }
    } else {
      throw Exception('Failed to load cars');
    }
  }




  // Future<List<BusRoute>> getRoutes() async {
  //   final response = await http.get(Uri.parse('$url/api/v1/routes'));
  Future<List<BusRoute>> getRoutes() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$url/api/v1/routes'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> routesData = jsonDecode(response.body);
      List<BusRoute> routes = routesData.map((route) => BusRoute.fromJson(route)).toList();

      return routes;
    } else {
      throw Exception('Failed to load routes');
    }
  }
  Future<List<Car>> getCarsByRouteId(int routeId) async {
    final token = await _getToken();
    final response = await http.get(Uri.parse('$url/api/v1/getCarByRouteId/$routeId',),
      headers: {'Authorization': 'Bearer $token'},);
    if (response.statusCode == 200) {
      List<dynamic> carsData = jsonDecode(response.body);
      List<Car> cars = carsData.map((car) => Car.fromJson(car)).toList();

      return cars;
    } else {
      throw Exception('Failed to load cars for route $routeId');
    }
  }

  Future<void> makePayment(
      BuildContext context,
      String cardNumber,
      String expiryDate,
      String cvv,
      int carId,
      int startId,
      int destinationId,
      int routeId,
      String amount,
      ) async {
    final token = await _getToken();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final body = {
      'card_no': cardNumber,
      'expire_date': expiryDate,
      'cvv': cvv,
      'car_id': carId.toString(),
      'start_id': startId.toString(),
      'destination_id': destinationId.toString(),
      'route_id': routeId.toString(),
      'amount': amount,
    };
    print(body);

    try {
      final response = await http.post(
        Uri.parse(url + '/api/v1/makePayment'),
        headers: headers,
        body: json.encode(body),
      );

      print('Response Body: ${response.body}');
      print('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 201) {
        var responseBody = jsonDecode(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentResultScreen(
              message: responseBody['message'],
              carName: responseBody['car_name'],
              startName: responseBody['start_name'],
              destinationName: responseBody['destination_name'],
              routeName: responseBody['route_name'],
              paymentId: responseBody['payment_id'].toString(),
              createdDate: responseBody['created_date'],
              receiptNumber: responseBody['receipt_number'],
            ),
          ),
        );
/////////////////////////////////twillo//////////////////////////
        final twilioFlutter = TwilioFlutter(
          accountSid: 'ACd856d3584c5e4a9ebe92d0273b7e86b8',
          authToken: 'ff3ae7b0b1dd4c6323559c9ed68b20d9',
          twilioNumber: "+19282724917",
        );
        // Send SMS to user's phone number
        String number = responseBody['phone_number'];
        String phoneNumber = '$number'; // Replace with the actual phone number
        String carName = responseBody['car_name'];
        String startName = responseBody['start_name'];
        String destinationName = responseBody['destination_name'];
        String routeName = responseBody['route_name'];
        String paymentId = responseBody['payment_id'].toString();
        String createdDate = responseBody['created_date'];
        String receiptNumber = responseBody['receipt_number'];

        String message = 'Payment successful.\n'
            'Car Name: $carName\n'
            'Start Name: $startName\n'
            'Destination Name: $destinationName\n'
            'Route Name: $routeName\n'
            'Payment ID: $paymentId\n'
            'Date: $createdDate\n'
            'Receipt Number: $receiptNumber';

        await twilioFlutter.sendSMS(
          toNumber: phoneNumber,
          messageBody: message,
        );
     ///////////////////////////////twillo///////////////////////////
      } else {
        throw Exception('Failed to make payment.');
      }
    } catch (error) {
      throw Exception('Failed to make payment. Please try again.');
    }
  }








// Future<Car> getCar(int carId) async {
  //   final response = await http.get(Uri.parse(url+'/api/v1/cars/$carId'));
  //
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> body = jsonDecode(response.body);
  //     Car car = Car.fromJson(body);
  //
  //     return car;
  //   } else {
  //     throw Exception("Failed to load car");
  //   }
  // }

}



