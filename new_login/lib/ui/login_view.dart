import 'package:flutter/material.dart';
import 'package:new_login/enums/view_states.dart';
import 'package:new_login/scoped_models/login_model.dart';
import 'package:new_login/ui/base_view.dart';
import 'package:new_login/ui/register_view.dart';

import '../style.dart';

class Login extends StatefulWidget {
  final bool isSeller;
  Login({Key key, @required this.isSeller}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // BuildContext get context => null;

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (context, child, model) {
        return Scaffold(
          body: _buildLoginCard(model),
        );
      },
    );
  }

  Container _buildLoginCard(LoginModel model) {
    return Container(
      alignment: Alignment.center,
      padding: new EdgeInsets.only(
        top: 20.0,
        right: 20.0,
        left: 20.0,
        bottom: 0.0,
      ),
      child: new Wrap(children: <Widget>[
        Card(
          color: Color(0xffFFFFFF),
          elevation: 4.0,
          child: new Wrap(
            children: <Widget>[
              _buildLoginCardTitle(),
              _buildLoginCardTextFormFeild(model),
              _buildLoginButton(model),
              _buildMessageBox(model.state),
              _buildForgetPasswordSection(model),
            ],
          ),
        ),
      ]),
    );
  }

  Container _buildLoginCardTitle() {
    var _heading =
        (widget.isSeller == true) ? 'Welcome Seller' : 'Welcome Customer';
    return new Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Center(
            child: new Text(
              _heading,
              style: TextStyle(fontSize: 25.0, color: Colors.lightBlue),
            ),
          ),
          Center(
            child: new Text(
              'Sign In',
              style: TextStyle(fontSize: 20.0, color: Colors.blueGrey),
            ),
          ),
        ],
      ),
    );
  }

  Column _buildLoginCardTextFormFeild(LoginModel model) {
    return Column(
      children: <Widget>[
        new ListTile(
          leading: const Icon(Icons.person),
          title: new TextFormField(
            controller: model.emailController,
            decoration: new InputDecoration(
              hintText: 'Email',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        new ListTile(
          leading: const Icon(Icons.vpn_key),
          title: new TextFormField(
            controller: model.passwordController,
            obscureText: true,
            decoration: new InputDecoration(
              hintText: 'Password',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
      ],
    );
  }

  Container _buildLoginButton(LoginModel model) {
    return Container(
      padding: EdgeInsets.only(top: 25.0, bottom: 15.0),
      child: Center(
        child: SizedBox(
          height: 50.0,
          width: 150.0,
          child: new RaisedButton(
            textColor: Color(0xFFFDFDFD),
            color: Color(0XFF8A2763),
            child: Text("Login"),
            onPressed: () {
              model.checkData(isSeller: widget.isSeller);
            },
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
          ),
        ),
      ),
    );
  }

  Column _buildForgetPasswordSection(LoginModel model) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10.0),
          child: Center(
            child: GestureDetector(
              onTap: () {},
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue[300],
                    fontSize: 16.0),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 40.0, top: 10.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('Don\'t have an account? ',
                  style: new TextStyle(color: Color(0xFF2E3233))),
              GestureDetector(
                child: Text(
                  "Register",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue[300],
                      fontSize: 17.0),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(
                          isSeller: widget.isSeller,
                        ),
                      ));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBox(ViewState state) {
    switch (state) {
      case ViewState.Busy:
        return Center(child: CircularProgressIndicator());
        break;

      case ViewState.Error:
        var v = state.toString();
        print("_____Button body ___  = $v");

        return Center(child: Text('Error'));
        break;

      case ViewState.Retrieved:
        // Fluttertoast.showToast(
        //     msg: "Login Success",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIos: 1);
        return Center(child: Text('Success'));
        break;
      default:
        return Center(child: Text(''));
        break;
    }
  }
}
