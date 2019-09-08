import 'package:flutter/material.dart';
import 'package:new_login/scoped_models/home_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:new_login/service_locator.dart';
import 'login_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<HomeModel>(
      model: locator<HomeModel>(),
      child: ScopedModelDescendant<HomeModel>(
        builder: (context, child, model) => Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  textColor: Color(0xFFFDFDFD),
                  color: Color(0XFFEB1555),
                  splashColor: Colors.orange,
                  child: Text(
                    'Customer',
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(
                            isSeller: false,
                          ),
                        ));
                  },
                ),
                RaisedButton(
                  textColor: Color(0xFFFDFDFD),
                  color: Color(0XFFEB1555),
                  splashColor: Colors.orange,
                  child: Text(
                    'Seller',
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(
                            isSeller: true,
                          ),
                        ));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
