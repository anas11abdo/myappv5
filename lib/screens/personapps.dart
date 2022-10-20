import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myapp/files.dart';
import 'package:myapp/screens/SingleFile.dart';

class PersonApps extends StatefulWidget {
  String id;
  PersonApps({Key? key, required this.id}) : super(key: key);

  @override
  State<PersonApps> createState() => _PersonAppsState();
}

class _PersonAppsState extends State<PersonApps> {
  Future<List<Files>> files = GetApp();
  String name = '';

  static Future<List<Files>> GetApp() async {
    String url = "http://207.180.221.91:5000/getapps";
    var res = await http.post(Uri.parse(url), headers: <String, String>{
      'Context-Type': 'application/json;charSet=UTF-8'
    });
    var rese = json.decode(res.body);
    print(rese);
    return rese.map<Files>(Files.fromJson).toList();
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
            title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            name = '';
                          });
                        },
                      ),
                      hintText: 'Search...',
                      border: InputBorder.none),
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
              ),
            )),
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: FutureBuilder<List<Files>>(
                  future: files,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final file = snapshot.data!;
                      return buildFiles(file);
                    } else {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Loading")
                          ]);
                    }
                  },
                ))));
  }

  Widget buildFiles(List<Files> files) => ListView.builder(
      itemCount: files.length,
      itemBuilder: (context, index) {
        final file = files[index];
        if (file.p_id.toString() == widget.id) {
          return Container(
              height: 120.0,
              margin: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 24.0,
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                      height: 124.0,
                      margin: const EdgeInsets.only(left: 46.0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color.fromRGBO(143, 148, 251, 1),
                          Color.fromRGBO(143, 148, 251, .6),
                        ]),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            offset: Offset(0.0, 10.0),
                          ),
                        ],
                      ),
                      child: Container(
                        margin:
                            const EdgeInsets.fromLTRB(70.0, 12.0, 16.0, 0.0),
                        constraints: const BoxConstraints.expand(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(height: 4.0),
                            Text(
                              file.first_name,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            Container(height: 6.0),
                            Text(
                              file.p_id,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 13),
                            ),
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                height: 2.0,
                                width: 150.0,
                                color: const Color(0xff00c6ff)),
                            Row(
                              children: <Widget>[
                                Container(width: 0.5),
                                TextButton(
                                  child: const Text("عرض التفاصيل",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white)),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SingleFile(
                                                  firstname: file.first_name,
                                                  lastname: file.last_name,
                                                  appid: file.file_id,
                                                  presonal_id: file.p_id,
                                                  request_date:
                                                      file.request_date,
                                                  file_status: file.status,
                                                  reason_refuse:
                                                      file.reason_refuse,
                                                  type: file.app_type,
                                                  fromdate: file.from_date,
                                                  todate: file.to_date,
                                                )));
                                  },
                                ),
                                //  Container(width: 24.0),
                                //  Container(width: 8.0),
                                //  TextButton(child: const Text("تحميل PDF",style: TextStyle(fontSize: 12,color: Colors.white)),
                                //  onPressed: (){
                                //    //openFile(pdf: file.app_pdf, fileName: file.file_name);
                                //  },),
                              ],
                            ),
                          ],
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16.0),
                    alignment: FractionalOffset.centerLeft,
                    child: const Image(
                      image: AssetImage("images/a.png"),
                      height: 92.0,
                      width: 92.0,
                    ),
                  )
                ],
              ));
        } else {}
        return Container();
      });
}
