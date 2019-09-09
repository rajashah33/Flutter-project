import 'package:flutter/material.dart';
import 'package:new_login/scoped_models/home_model.dart';
import 'package:new_login/ui/shared/ui_helper.dart';
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
                UIHelper.designButton(
                  title: 'Customer',
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
                UIHelper.designButton(
                  title: 'Seller',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(
                            isSeller: true,
                          ),
                        ));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
