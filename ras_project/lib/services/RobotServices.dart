import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ras_project/global/env.dart';
import 'package:ras_project/model/BusModel.dart';
import 'package:ras_project/services/AuthServices.dart';

class RobotService {
  bool correctAnswer = true;
  late AuthService authService = AuthService();

  Future<List<RobotModel>> getrobots() async {
    await authService.getUserFromStorage();
    try {
      final response = await http.get(Uri.parse(
          "$BASE_URL_BACKEND/getrobots/" + authService.user.id.toString()));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body)['data'];
        var robots = jsonData
            .map<RobotModel>((json) => RobotModel.fromJson(json))
            .toList();
        return robots;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<RobotModel> getrobotById(id) async {
    var bikes;
    try {
      final response =
          await http.get(Uri.parse("$BASE_URL_BACKEND/getrobotById/$id"));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body)['data'];
        var bikes = RobotModel.fromJson(jsonData);
        return bikes;
      } else {
        return bikes;
      }
    } catch (e) {
      return bikes;
    }
  }

  Future<String> UpdateRobotEtat(int id) async {
    try {
      final response = await http
          .put(Uri.parse('$BASE_URL_BACKEND/UpdateEtat/' + id.toString()));
      print(response.body);
      String message = jsonDecode(response.body)['Message'];
      return message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> DeleteRobot(int id) async {
    try {
      final response = await http
          .delete(Uri.parse('$BASE_URL_BACKEND/DeleteRobot/' + id.toString()));
      String message = jsonDecode(response.body)['Message'];
      return message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateRobot(int id, double latitude, double longitude) async {
    try {
      final Map<String, dynamic> requestBody = {
        'latitude': latitude,
        'longitude': longitude,
      };

      final response = await http.put(
        Uri.parse('$BASE_URL_BACKEND/update/$id'),
        body: jsonEncode(requestBody),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body)['data'];
      } else if (response.statusCode == 404) {
        return jsonDecode(response.body)['data'];
      } else {
        return "Error: ${response.statusCode}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }

  Future<bool> AddRobot(String id, String name, double lat, double long,
      String battery, String niveau) async {
    try {
      await authService.getUserFromStorage();
      final request = {
        "id": id,
        "name": name,
        "latitude": lat,
        "longitude": long,
        "user_id": authService.user.id.toString(),
        "battery": int.parse(battery.toString()),
        "niveau": int.parse(niveau.toString()),
      };
      final response = await http.post(Uri.parse('$BASE_URL_BACKEND/AddRobot'),
          body: jsonEncode(request),
          headers: {'Content-Type': 'application/json'});
      String message = jsonDecode(response.body)['message'];
      if (message.contains("already exists")) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
