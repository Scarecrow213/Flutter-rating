import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  String serverUrl = "http://192.168.10.16:3000";
  var status = false;
  var token;

  loginData(String email, String password) async {
    String myUrl = "$serverUrl/login1";
    final response = await http.post(myUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "email": email, "password": password}
          )
    );
    status = response.body.contains('error');
    var data = jsonDecode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["token"]}');
      _save(data["token"]);
    }

  }

  registerData(String name, String email, String password) async {
    String myUrl = "$serverUrl/register1";
    final response = await http.post(myUrl,
        headers: <String, String> {'Accept': 'application/json', 'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(<String, String> {"name": "$name", "email": "$email", "password": "$password"}));
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["token"]}');
      _save(data["token"]);
    }
  }

  Future<List> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/rating/";
    final response = await http.get(myUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $value'
        }
    );
    return jsonDecode(response.body);
  }

  void deleteData(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/rating/$id";
    http.delete(myUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $value'
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  void addData(String subject, String rating, String student, String date) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/rating";

    http.post(myUrl,
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $value'},
        body: jsonEncode(<String, String>{
          "subject": subject,
          "rating": rating,
          "student": student,
          "date": date})
    ).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  void editData(int id, String subject, String rating, String student, String date) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/rating/$id";
    http.put(myUrl,
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $value'},
        body: jsonEncode(<String, String>{
          "subject": subject,
          "rating": rating,
          "student": student,
          "date": date})
    ).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  Future<String> getStat(String stat, String subject,  String student, String startDate, String endDate) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/statistics/$stat";
    String result;
    await http.post(myUrl,
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $value'},
        body: jsonEncode(<String, String>{
          "subject": subject,
          "student": student,
          "startDate": startDate,
          "endDate": endDate}
        )).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
      var r = jsonDecode(response.body);
      result = r['stat'].toString();
    });
    print(result);
    return result;
  }

  Future<String> getStatMin(String subject,  String student, String startDate, String endDate) async {
    return getStat("MIN", subject, student, startDate, endDate);
  }

  Future<String> getStatAverage(String subject,  String student, String startDate, String endDate) async {
    return getStat("AVG", subject, student, startDate, endDate);
  }

  Future<String> getStatMax(String subject,  String student, String startDate, String endDate) async {
    return getStat("MAX", subject, student, startDate, endDate);
  }

  _save(int token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setInt(key, value);
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }
}
