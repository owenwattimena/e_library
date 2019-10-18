import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class DaftarScreen extends StatefulWidget {
  @override
  _DaftarScreenState createState() => _DaftarScreenState();
}

class _DaftarScreenState extends State<DaftarScreen> {
  final _formKey = GlobalKey<FormState>();
  final String host = 'http://192.168.1.8/';
  final String url = 'e-library-api/request/auth/register.php';
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerPassword = new TextEditingController();
  TextEditingController _controllerUlangPassword = new TextEditingController();

  register(String email, String password) async {
    var response = await http.post(host + url, body: {
      'email': email,
      'password': password,
    });
    var data = json.decode(response.body);

    _showToast(data['mesage']);
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
          color: Colors.green,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 100),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.book,
                      size: 100.0,
                      color: Colors.white,
                    ),
                    Center(
                      child: Text('DAFTAR',
                          style: TextStyle(fontSize: 30, color: Colors.white)),
                    ),
                  ],
                ),
              ),
              TextFormField(
                controller: _controllerEmail,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.yellow),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Color(0xffCCCCCC))),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Harap masukan Email!';
                  }
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
              TextFormField(
                controller: _controllerUlangPassword,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.yellow),
                    hintText: 'Ulang Password',
                    hintStyle: TextStyle(color: Color(0xffCCCCCC))),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Harap masukan Ulang Password!';
                  } else if (value != _controllerPassword.text) {
                    return 'Ulang Password tidak sama dengan Password!';
                  }
                  return null;
                },
              ),
              Padding(padding: EdgeInsets.only(top: 30)),
              RaisedButton(
                child: Text('DAFTAR'),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    var connectivityResult =
                        await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.none) {
                      _showToast('Mohon periksa koneksi internet anda!');
                    } else {
                      register(_controllerEmail.text, _controllerPassword.text);
                    }
                  }
                },
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              RichText(
                text: TextSpan(text: "Sudah punya akun? ", children: <TextSpan>[
                  TextSpan(
                      text: ' Masuk.',
                      style: TextStyle(
                        color: Color(0xffDDDDDD),
                      ),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
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
