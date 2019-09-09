import 'package:flutter/material.dart';
import 'package:new_login/enums/view_states.dart';
import 'package:new_login/scoped_models/login_model.dart';
import 'package:new_login/ui/base_view.dart';
import 'package:new_login/ui/register_view.dart';
import 'package:new_login/ui/shared/app_colors.dart';
import 'package:new_login/ui/shared/ui_helper.dart';

class Login extends StatefulWidget {
  final bool isSeller;
  Login({Key key, @required this.isSeller}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // BuildContext get context => null;

  final emailFocus = new FocusNode();
  final passwordFocus = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (context, child, model) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Stack(fit: StackFit.expand, children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('images/bgimage1.jpg'),
                  ),
                ),
              ),
              _buildLoginCard(model),
            ]),
          ),
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
          color: Colors.white.withOpacity(0.9),
          elevation: 8.0,
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
              style: TextStyle(fontSize: 28.0, color: primaryColor),
            ),
          ),
          Center(
            child: new Text(
              'Sign in to your Account',
              style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginCardTextFormFeild(LoginModel model) {
    return Container(
      child: Column(
        children: <Widget>[
          UIHelper.verticalSpace(UIHelper.SpaceSmall),
          UIHelper.inputField(
            placeholder: 'Email',
            controller: model.emailController,
            currentFocus: emailFocus,
            onFieldSubmitted: (v) {
              emailFocus.unfocus();
              FocusScope.of(context).requestFocus(passwordFocus);
            },
            inputType: TextInputType.emailAddress,
            icon: Icon(Icons.email),
          ),
          UIHelper.inputField(
            placeholder: 'Password',
            controller: model.passwordController,
            isPassword: true,
            currentFocus: passwordFocus,
            onFieldSubmitted: (v) {
              passwordFocus.unfocus();
            },
            inputType: TextInputType.text,
            icon: Icon(Icons.lock),
          ),
        ],
      ),
    );
  }

  Container _buildLoginButton(LoginModel model) {
    return Container(
      padding: EdgeInsets.only(top: 25.0, bottom: 15.0),
      child: Center(
        child: UIHelper.designButton(
          title: 'Sign In',
          onPressed: () {
            model.checkData(isSeller: widget.isSeller);
          },
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
                    color: primaryColor,
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
              Text('Don\'t have an account? ',
                  style: new TextStyle(color: Color(0xFF2E3233))),
              GestureDetector(
                child: Text(
                  "Register",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: primaryColor,
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
        return Center(child: Text('Error'));
        break;

      case ViewState.Retrieved:
        return Center(child: Text('Success'));
        break;
      default:
        return Center(child: Text(''));
        break;
    }
  }
}
