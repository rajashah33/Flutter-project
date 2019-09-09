import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_login/ui/shared/app_config.dart';

class StorageService {
  Future<bool> saveData(
      name, email, phone, password, gender, dob, isSeller) async {
    var url;
    if (isSeller == false) {
      url = '${baseURL}register_customer.php';
    } else {
      url = '${baseURL}register_seller.php';
    }
    final response = await http.post(url, body: {
      "userName": name,
      "userEmail": email,
      "userPhone": phone,
      "userPassword": password,
      "userGender": gender,
      "userDOB": dob,
    });
    Map<String, dynamic> map = json.decode(response.body);
    if (map['status'] == '1') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> retrieveData(
      String email, String password, bool isSeller) async {
    String url;
    if (isSeller == false)
      url = '${baseURL}test_customer.php';
    else
      url = '${baseURL}test_seller.php';

    final response = await http.post(url, body: {
      "userEmail": email,
      "userPassword": password,
    });
    Map<String, dynamic> map = json.decode(response.body);
    if (map['status'] == '1') {
      return true;
    } else {
      return false;
    }
  }
}
