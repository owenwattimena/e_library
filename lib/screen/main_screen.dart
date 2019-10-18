// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:e_library/screen/pdf_view_screen.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // int search = 1;
  String _barcode, _judul, _pengarang, _penerbit, _urlGambar, _urlEbook;
  var dir;
  // var _pdfPath;
  int status = 0;
  String _message = 'Tekan tombol scan barcode untuk mencari buku';
  // String _
  final String host = 'http://192.168.1.8/';
  final String url = 'e-library-api/request/getBook.php';

  donwloadEbook() async {
    Dio dio = new Dio();
    dir = await DownloadsPathProvider.downloadsDirectory;
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    try {
      print(dir.path);
      await dio.download(_urlEbook, dir.path + '/$_barcode ~ $_judul.pdf',
          onProgress: showDownloadProgress);
    } catch (e) {
      print(e);
      _showDialog('Unduhan gagal', 'Gagal mengunduh file pdf');
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print('received : ' + received.toString());
      print('total : ' + total.toString());
      print((received / total * 100).toStringAsFixed(0) + "%");

      if (received / total * 100 == 100) {
        _showDialog(
            'Unduhan berhasil', 'Lokasi : ${dir.path}/$_barcode ~ $_judul.pdf');
      }
    }
  }

  _showDialog(String title, String content) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  getBook(String barcode) async {
    var response = await http.post(host + url, body: {'barcode': barcode});
    var data = json.decode(response.body);
    this.status = data['status'];

    if (data['status'] == 1) {
      setState(() {
        this._barcode = data['barcode'];
        this._judul = data['judul'];
        this._pengarang = data['pengarang'];
        this._penerbit = data['penerbit'];
        this._urlGambar = host + data['url_gambar'];
        this._urlEbook = host + data['url_ebook'];
      });
    } else {
      setState(() {
        this._message = data['mesage'];
      });
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcode() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    if (barcodeScanRes != '-1') {
      getBook(barcodeScanRes);
    }
  }

  void _logout() {
    // Navigator.popUntil(context, ModalRoute.withName('/login'));
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Library'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _logout(),
          )
        ],
      ),
      body: (this.status == 1)
          ? Container(
              padding: EdgeInsets.all(15),
              child: ListView(children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Image.network(
                        '$_urlGambar',
                        height: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Center(
                      child: Text(
                        '$_barcode',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.file_download,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () async {
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());
                            if (connectivityResult ==
                                    ConnectivityResult.mobile ||
                                connectivityResult == ConnectivityResult.wifi) {
                              // I am connected to a mobile network.
                              await donwloadEbook();
                              // download();
                            } else {
                              setState(() {
                                this.status = 0;
                                this._message =
                                    "Mohon periksa koneksi internet anda!";
                              });
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.picture_as_pdf,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PdfViewScreen(
                                          pdfUrl: this._urlEbook,
                                        )));
                          },
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text('Judul : '),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Text(
                      '$_judul',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text('Pengarang : '),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Text(
                      '$_pengarang',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text('Penerbit : '),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Text(
                      '$_penerbit',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ]),
            )
          : Center(
              child: Text('$_message'),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.center_focus_strong),
        onPressed: () async {
          var connectivityResult = await (Connectivity().checkConnectivity());
          if (connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.wifi) {
            // I am connected to a mobile network.
            scanBarcode();
          } else {
            _showDialog(
                'Internet Error', 'Mohon periksa koneksi internet anda!');
          }
        },
      ),
    );
  }
}
