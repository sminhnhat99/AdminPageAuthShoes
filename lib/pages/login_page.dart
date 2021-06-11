import 'package:admin_flutter/dashboard/dashboard_admin.dart';
import 'package:flutter/material.dart';
import 'package:admin_flutter/ProgressHUD.dart';
import 'package:admin_flutter/api/api_service.dart';
import 'package:admin_flutter/model/login_model.dart';
import 'package:admin_flutter/share_token.dart';
class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailClear = TextEditingController();
  final _passClear = TextEditingController();
  APIService apiservice;
  final formfieldKey = GlobalKey<FormFieldState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  String getsharetoken;
  AdminPreferences adminprefs;
  TextEditingController _controller;
  bool hidePassword = true;
  LoginRequestModel requestModel;
  bool isApiCallProgress = false;


  @override
  void initState() {
    super.initState();
    requestModel = new LoginRequestModel();
    AdminPreferences.instance.setStringValue('token', '');
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProgress,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF212332),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(
                width: 500.0,
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                margin: EdgeInsets.symmetric(vertical: 85.0, horizontal: 450.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color(0xFF2A2D3E),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 10.0),
                          blurRadius: 20.0)
                    ]),
                child: Form(
                  key: globalFormKey,
                  child: Column(
                    children: [
                      SizedBox(height: 25.0),
                      Text(
                        'Admin Login',
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 60.0)
                      ),
                      SizedBox(height: 20.0),
                      new TextFormField(
                        controller: _emailClear,
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (input) => requestModel.email = input,
                        validator: (input) => !input.contains("@")
                            ? "Email ID should be valid"
                            : null,
                        decoration: new InputDecoration(
                            hintText: "Email Address",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF2697FF)
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color(0xFF2697FF),
                            )),
                      ),
                      SizedBox(height: 20.0),
                      new TextFormField(
                        controller: _passClear,
                        obscureText: hidePassword,
                        keyboardType: TextInputType.text,
                        onSaved: (input) => requestModel.password = input,
                        validator: (input) => input.length < 3
                            ? "Password should be more than 3 characters"
                            : null,
                        decoration: new InputDecoration(
                            hintText: "Password",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF2697FF)
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xFF2697FF),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.4),
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            )),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      // ignore: deprecated_member_use
                      FlatButton(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 80,
                        ),
                        onPressed: () {
                          if (validateAndSave()) {
                            setState(() {
                              isApiCallProgress = true;
                            });

                            // Call API //

                            APIService apiService = new APIService();
                            apiService.login(requestModel).then((value) {
                              setState(() {
                                isApiCallProgress = false;
                              });

                              if (value != null) {
                                setState(() {
                                  isApiCallProgress = false;
                                });
                                if (value.success == 1) {
                                  AdminPreferences.instance.setStringValue('token', value.token);
                                  _emailClear.clear();
                                  _passClear.clear();
                                  final snackBar = SnackBar(
                                    content: Text('Login Successful!!'),
                                  );
                                  // ignore: deprecated_member_use
                                  scaffoldKey.currentState.showSnackBar(snackBar);
                                  setState(() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardAdmin()));
                                  });
                                } else {
                                  final snackBar = SnackBar(content: Text(
                                    "Login unsucessful, please check your username or password",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                    backgroundColor: Colors.white,
                                  );
                                  // ignore: deprecated_member_use
                                  scaffoldKey.currentState.showSnackBar(snackBar);
                                }
                              }

                            });
                          }
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Color(0xFF2697FF),
                        shape: StadiumBorder(),
                      )
                    ],
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
