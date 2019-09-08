import 'package:flutter/material.dart';
import 'package:new_login/enums/view_states.dart';
import 'package:new_login/scoped_models/register_model.dart';
import 'package:new_login/ui/base_view.dart';

class Register extends StatefulWidget {
  final bool isSeller;
  Register({Key key, @required this.isSeller}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterModel>(
      builder: (context, child, model) {
        return Scaffold(
          resizeToAvoidBottomPadding: true,
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.height,
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //     fit: BoxFit.fitHeight,
                  //     image: NetworkImage(
                  //         "https://www.gstatic.com/webp/gallery/1.jpg"),
                  //   ),
                  // ),
                ),
                _buildRegisterCard(model)
              ],
            ),
          ),
        );
      },
    );
  }

  Container _buildRegisterCard(RegisterModel model) {
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
              _buildRegisterCardTitle(),
              _buildRegisterCardTextFormFeild(model),
              _buildMessageBox(model.state),
              _buildRegisterButton(model),
            ],
          ),
        ),
      ]),
    );
  }

  Container _buildRegisterCardTitle() {
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
              'Sign Up',
              style: TextStyle(fontSize: 20.0, color: Colors.blueGrey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterCardTextFormFeild(RegisterModel model) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextFormField(
              controller: model.nameController,
              decoration: new InputDecoration(
                hintText: 'Name',
              ),
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.email),
            title: new TextFormField(
              controller: model.emailController,
              decoration: new InputDecoration(
                hintText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.phone),
            title: new TextFormField(
              controller: model.phoneController,
              decoration: new InputDecoration(
                hintText: 'Phone',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.lock),
            title: new TextFormField(
              controller: model.passwordController,
              decoration: new InputDecoration(
                hintText: 'Password',
              ),
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.lock_outline),
            title: new TextFormField(
              controller: model.confPasswordController,
              decoration: new InputDecoration(
                hintText: 'Confirm Password',
              ),
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildRegisterButton(RegisterModel model) {
    return new Container(
      padding: EdgeInsets.only(top: 25.0, bottom: 15.0),
      child: Center(
        child: SizedBox(
          height: 50.0,
          width: 150.0,
          child: new MaterialButton(
              textColor: Color(0xFFFDFDFD),
              color: Color(0XFF8A2763),
              splashColor: Colors.orange,
              child: Text("Register"),
              onPressed: () {
                model.saveData(isSeller: widget.isSeller);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0))),
        ),
      ),
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

      case ViewState.PasswordNotMatched:
        return Center(child: Text('Password Not matched'));
        break;

      default:
        return Center(child: Text(''));
        break;
    }
  }
}
