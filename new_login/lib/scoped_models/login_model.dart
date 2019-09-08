import 'package:flutter/cupertino.dart';
import 'package:new_login/enums/view_states.dart';
import 'package:new_login/services/storage_service.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:new_login/service_locator.dart';

class LoginModel extends Model {
  StorageService storageService = locator<StorageService>();

  // TextEditingController emailController, passwordController;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ViewState _state = ViewState.Idle;
  ViewState get state => _state;

  void checkData({Key key, @required isSeller}) async {
    _setState(ViewState.Busy);

    bool result = await storageService.retrieveData(
        emailController.text, passwordController.text, isSeller);

    if (result == true) {
      _setState(ViewState.Retrieved);
    } else {
      _setState(ViewState.Error);
    }
  }

  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }
}
