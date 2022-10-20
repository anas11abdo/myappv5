import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/screens/widgets/header_widget.dart';
import 'package:myapp/screens/widgets/theme_helper.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'dart:typed_data';

class SingleFile extends StatefulWidget {
  SingleFile({
    Key? key,
    required this.firstname,
    required this.lastname,
    required this.appid,
    required this.presonal_id,
    required this.request_date,
    required this.file_status,
    required this.reason_refuse,
    required this.fromdate,
    required this.todate,
    required this.type,
  }) : super(key: key);
  String firstname;
  String lastname;
  String appid;
  String presonal_id;
  DateTime request_date;
  String file_status;
  String reason_refuse;
  String type;
  DateTime fromdate;
  DateTime todate;

  @override
  State<StatefulWidget> createState() {
    return _SingleFileState();
  }
}

class _SingleFileState extends State<SingleFile> {
  final _formKey = GlobalKey<FormState>();
  String url = "http://207.180.221.91:5000/getpdf";

  Future getpdf() async {
    var res = await http.post(Uri.parse(url), headers: <String, String>{
      'Context-Type': 'application/json;charSet=UTF-8'
    }, body: <String, String>{
      'appid': widget.appid,
    });
    //  var rese = json.decode(res.body);
    // // var pdf = base64.decode(rese["base64"]);
    // // print(pdf);
    // print(rese);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(143, 148, 251, 1),
                Color.fromRGBO(143, 148, 251, .6),
              ]),
            ),
          ),
          shadowColor: Colors.blue,
          title: const Center(
            child: Text(
              'عرض تفاصيل المعاملة',
            ),
          ),
          backgroundColor: Color.fromARGB(255, 105, 64, 133),
        ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            decoration: ThemeHelper().textInputDecoration(
                              'File Name : ' +
                                  widget.firstname.toString() +
                                  " " +
                                  widget.lastname.toString(),
                            ),
                            enabled: false,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            decoration: ThemeHelper().textInputDecoration(
                                'Parsonal ID :' +
                                    widget.presonal_id.toString()),
                            enabled: false,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            // style: TextStyle(fontWeight: FontWeight.bold),
                            decoration: ThemeHelper().textInputDecoration(
                                "Type : " + widget.type.toString()),
                            enabled: false,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            // style: TextStyle(fontWeight: FontWeight.bold),
                            decoration: ThemeHelper().textInputDecoration(
                                "From date : " +
                                    DateFormat("yyyy-MM-dd")
                                        .format(widget.fromdate)
                                        .toString()),
                            enabled: false,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            // style: TextStyle(fontWeight: FontWeight.bold),
                            decoration: ThemeHelper().textInputDecoration(
                                "To date : " +
                                    DateFormat("yyyy-MM-dd")
                                        .format(widget.todate)
                                        .toString()),
                            enabled: false,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            // style: TextStyle(fontWeight: FontWeight.bold),
                            decoration: ThemeHelper().textInputDecoration(
                                "Request date : " +
                                    DateFormat("yyyy-MM-dd")
                                        .format(widget.request_date)
                                        .toString()),
                            enabled: false,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            decoration: ThemeHelper().textInputDecoration(
                                "File Status : " +
                                    widget.file_status.toString()),
                            enabled: false,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Rection reason: " +
                                    widget.reason_refuse.toString()),
                            enabled: false,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15.0),
                        SizedBox(height: 20.0),
                        RaisedButton(
                          onPressed: () {
                            getpdf();
                            print("done");
                            openfile(widget.firstname);
                            _deleteAppDir();
                          },
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                gradient: LinearGradient(colors: <Color>[
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, .6),
                                ]),
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Center(
                                child: const Text('تحميل PDF'),
                              )),
                        ),
                        SizedBox(height: 30.0),
                        SizedBox(height: 25.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future openFile(String fileName) async {
  //   var anas = getpdf();
  //   final file = await downloadFile(anas, fileName);
  //   if (file == null) return;
  //   print("path: ${file.path}");
  //   OpenFile.open(file.path);
  // }

  // Future<File?> downloadFile(dynamic pdfs, String name) async {
  //   final appStorage = await getApplicationSupportDirectory();
  //   final file = File('${appStorage.path}/$name');
  //   try {
  //     final raf = file.openSync(mode: FileMode.write);
  //     await raf.close();
  //     return file;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  Future<dynamic> downloadFile(String name) async {
    try {
      final response = await Dio().get('http://207.180.221.91:5000/getpdf',
          options: Options(
              responseType: ResponseType.bytes,
              contentType: 'application/octet-stream'));
      var data = {"data": response.data.buffer};
      return data;
    } on DioError catch (error) {
      var data = error.response?.data;
      print(data);
      return data;
    }
  }

  Future<dynamic> openfile(String name) async {
    Uint8List pdfblob = await downloadFile(name);
    final appStorage = await getApplicationSupportDirectory();
    final file = File('${appStorage.path}/$name');
    print(file);
    await file.writeAsBytes(pdfblob);
    await OpenFile.open('${appStorage.path}/$name');
  }

  Future<void> _deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }
}
