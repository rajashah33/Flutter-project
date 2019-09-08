import 'package:flutter/cupertino.dart';
import 'package:new_login/enums/view_states.dart';
import 'package:new_login/services/storage_service.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:new_login/service_locator.dart';

class RegisterModel extends Model {
  StorageService storageService = locator<StorageService>();

  // TextEditingController emailController,
  //     nameController,
  //     phoneController,
  //     passwordController,
  //     confPasswordController;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPasswordController = TextEditingController();

  ViewState _state;
  ViewState get state => _state;
  void saveData({Key key, @required bool isSeller}) async {
    var result;
    if (confPasswordController.text == passwordController.text) {
      _setState(ViewState.Busy);
      result = await storageService.saveData(
          nameController.text,
          emailController.text,
          phoneController.text,
          passwordController.text,
          isSeller);
      if (result == true) {
        _setState(ViewState.Retrieved);
      } else {
        _setState(ViewState.Error);
      }
    } else {
      _setState(ViewState.PasswordNotMatched);
    }
  }

  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }
}
