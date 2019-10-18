// import 'package:e_library/screen/main_screen.dart';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:e_library/screen/daftar_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final String host = 'http://192.168.1.8/';
  final String url = 'e-library-api/request/auth/login.php';
  TextEditingController _controllerUsername = new TextEditingController();
  TextEditingController _controllerPassword = new TextEditingController();

  login(String email, String password) async {
    var response = await http.post(host + url, body: {
      'email': email,
      'password': password,
    });
    var data = json.decode(response.body);
    if (data['status'] == 1) {
      Navigator.pushReplacementNamed(context, '/splash');
    } else {
      _showToast(data['mesage']);
    }
  }

  _showToast(String msg) {
    Fluttertoast.showToast(
      msg: '$msg',
      toastLength: Toast.LENGTH_LONG,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(30),
          color: Colors.red[900],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 100),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                      size: 100.0,
                      color: Colors.white,
                    ),
                    Center(
                      child: Text(
                        'LOGIN E-Library',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _controllerUsername,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.yellow),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Color(0xffCCCCCC))),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Harap masukan Email!';
                  }
                  // if(value)
                  return null;
                },
              ),
              Padding(padding: EdgeInsets.only(top: 30)),
              TextFormField(
                controller: _controllerPassword,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.yellow),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Color(0xffCCCCCC))),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Harap masukan Password!';
                  }
                  return null;
                },
              ),
              Padding(padding: EdgeInsets.only(top: 30)),
              RaisedButton(
                color: Colors.green[700],
                child: Text(
                  'LOGIN',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    var connectivityResult =
                        await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.none) {
                      _showToast('Mohon periksa koneksi internet anda!');
                    } else {
                      login(_controllerUsername.text, _controllerPassword.text);
                    }
                  }
                },
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              RichText(
                text: TextSpan(text: "Belum punya akun? ", children: <TextSpan>[
                  TextSpan(
                      text: ' Daftar.',
                      style: TextStyle(
                        color: Color(0xffDDDDDD),
                      ),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DaftarScreen(),
                            ),
                          );
                        }),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
