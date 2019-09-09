import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_login/enums/view_states.dart';
import 'package:new_login/scoped_models/register_model.dart';
import 'package:new_login/ui/base_view.dart';
import 'package:new_login/ui/login_view.dart';
import 'package:new_login/ui/shared/app_colors.dart';
import 'package:new_login/ui/shared/ui_helper.dart';

class Register extends StatefulWidget {
  final bool isSeller;
  Register({Key key, @required this.isSeller}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameFocus = new FocusNode();
  final emailFocus = new FocusNode();
  final phoneFocus = new FocusNode();
  final passwordFocus = new FocusNode();
  final confPasswordFocus = new FocusNode();
  DateTime date;
  String dobText = 'Date of Birth';
  var _gender = ['Male', 'Female', 'Other'];
  var _currentItemSelected;

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterModel>(
      builder: (context, child, model) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
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
          color: Colors.white.withOpacity(0.9),
          elevation: 8.0,
          child: new Wrap(
            children: <Widget>[
              _buildRegisterCardTitle(),
              _buildRegisterCardTextFormFeild(model),
              _buildMessageBox(model.state),
              _buildGenderDOB(model),
              _buildRegisterButton(model),
              _buildAlreadyAccount(),
            ],
          ),
        ),
      ]),
    );
  }

  Container _buildRegisterCardTitle() {
    var _heading = (widget.isSeller == true)
        ? 'Create & start Selling'
        : 'Create & start Buying';
    return new Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Center(
            child: new Text(
              _heading,
              style: TextStyle(fontSize: 25.0, color: primaryColor),
            ),
          ),
          // Center(
          //   child: new Text(
          //     'Create Account',
          //     style: TextStyle(fontSize: 20.0, color: Colors.blueGrey),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildRegisterCardTextFormFeild(RegisterModel model) {
    return Container(
      child: Column(
        children: <Widget>[
          // UIHelper.verticalSpaceSmall(),
          UIHelper.inputField(
            placeholder: 'Name',
            controller: model.nameController,
            icon: Icon(Icons.person),
            currentFocus: nameFocus,
            onFieldSubmitted: (v) {
              nameFocus.unfocus();
              FocusScope.of(context).requestFocus(emailFocus);
            },
          ),
          UIHelper.inputField(
            placeholder: 'Email',
            controller: model.emailController,
            icon: Icon(Icons.email),
            inputType: TextInputType.emailAddress,
            currentFocus: emailFocus,
            onFieldSubmitted: (v) {
              emailFocus.unfocus();
              FocusScope.of(context).requestFocus(phoneFocus);
            },
          ),
          UIHelper.inputField(
            placeholder: 'Phone',
            controller: model.phoneController,
            icon: Icon(Icons.phone),
            inputType: TextInputType.phone,
            currentFocus: phoneFocus,
            onFieldSubmitted: (v) {
              phoneFocus.unfocus();
              FocusScope.of(context).requestFocus(passwordFocus);
            },
          ),
          UIHelper.inputField(
            placeholder: 'Password',
            controller: model.passwordController,
            isPassword: true,
            icon: Icon(Icons.lock_outline),
            currentFocus: passwordFocus,
            onFieldSubmitted: (v) {
              passwordFocus.unfocus();
              FocusScope.of(context).requestFocus(confPasswordFocus);
            },
          ),
          UIHelper.inputField(
            placeholder: 'Confirm Password',
            controller: model.confPasswordController,
            isPassword: true,
            icon: Icon(Icons.lock),
            currentFocus: confPasswordFocus,
            onFieldSubmitted: (v) {
              confPasswordFocus.unfocus();
              // FocusScope.of(context).requestFocus(passwordFocus);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGenderDOB(RegisterModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        DropdownButton<String>(
          hint: Text(
            'Gender',
          ),
          items: _gender.map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(
                dropDownStringItem,
              ),
            );
          }).toList(),
          onChanged: (String newValueSelected) {
            setState(() {
              this._currentItemSelected = newValueSelected;
              model.gender = newValueSelected;
            });
          },
          value: _currentItemSelected,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text(
                dobText,
              ),
              color: Colors.grey.shade200,
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: date == null ? DateTime.now() : date,
                  firstDate: DateTime(1960),
                  lastDate: DateTime(2020),
                ).then((_date) {
                  setState(() {
                    date = _date;
                    dobText = DateFormat('dd MMM yyyy').format(date);
                    model.dob = date.toString().substring(0, 10);
                  });
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRegisterButton(RegisterModel model) {
    return new Container(
      child: Center(
        child: UIHelper.designButton(
          title: 'Create',
          onPressed: () {
            model.saveData(isSeller: widget.isSeller);
          },
        ),
      ),
    );
  }

  Widget _buildAlreadyAccount() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Already have account? ',
              style: new TextStyle(color: Color(0xFF2E3233))),
          GestureDetector(
            child: Text(
              "Sign In",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: primaryColor,
                  fontSize: 17.0),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
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
