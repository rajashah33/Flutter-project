import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_login/ui/shared/app_config.dart';

class StorageService {
  Future<bool> saveData(name, email, phone, password, isSeller) async {
    var url;
    if (isSeller == true)
      url = baseURL + 'test_customer.php';
    else
      url = baseURL + 'test_seller.php';
    print('kkkkkkkkkkkkkkkkk' + url);
    final response = await http.post(url, body: {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
    });
    Map<String, dynamic> map = json.decode(response.body);
    if (map['status'] == '1') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> retrieveData(String email, password, bool isSeller) async {
    var url;
    if (isSeller == true)
      url = baseURL + 'test_customer.php';
    else
      url = baseURL + 'test_seller.php';

    final response = await http.post(url, body: {
      "email": email,
      "password": password,
    });
    Map<String, dynamic> map = json.decode(response.body);
    if (map['status'] == '1') {
      return true;
    } else {
      return false;
    }
  }
}
