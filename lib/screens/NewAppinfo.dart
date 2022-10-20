import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:myapp/per_user.dart';
import 'package:myapp/screens/HomePage.dart';
import 'package:myapp/screens/NewAPP.dart';
import 'package:myapp/screens/nav.dart';
import 'package:myapp/screens/widgets/theme_helper.dart';

class NewAPPinfo extends StatefulWidget {
  String username;
  String useremail;
  String userphone;
  String id;
  String name;
  String lastname;
  DateTime dob;
  NewAPPinfo(
      {Key? key,
      required this.name,
      required this.lastname,
      required this.dob,
      required this.id,
      required this.useremail,
      required this.userphone,
      required this.username})
      : super(key: key);

  @override
  State<NewAPPinfo> createState() => _NewAPPinfoState();
}

class _NewAPPinfoState extends State<NewAPPinfo> {
  int currentStep = 0;

  var _Types = [];
  String? note;

  String? type;
  bool istypeselected = false;

  TextEditingController _fromdate = TextEditingController();
  TextEditingController _todate = TextEditingController();
  TextEditingController PersonalNotes = TextEditingController();

  Future gettypesdata() async {
    var res = await http.post(
        Uri.parse("http://207.180.221.91:5000/selecttype"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        });
    var rese = json.decode(res.body);

    setState(() {
      _Types = rese;
    });
  }

  Future gettypesnotes() async {
    var res = await http.post(
        Uri.parse("http://207.180.221.91:5000/selectnote"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'TYPE': type.toString(),
        });
    var rese = json.decode(res.body);

    setState(() {
      note = rese[0]['T_NOTES'].toString();
    });
    print(note);
  }

  Future SendApp() async {
    var res = await http.post(Uri.parse("http://207.180.221.91:5000/sendapp"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'p_id': widget.id,
          'type': type.toString(),
          'fromdate': _fromdate.text.toString(),
          'todate': _todate.text.toString(),
          'requestdate':
              DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
          'p_notes': PersonalNotes.text
        });
  }

  @override
  void initState() {
    gettypesdata();
    super.initState();
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
          title: const Text('معلومات التطبيق'),
          centerTitle: true,
        ),
        body: Theme(
          data: Theme.of(context).copyWith(
            colorScheme:
                ColorScheme.light(primary: Color.fromARGB(255, 131, 104, 252)),
          ),
          child: Stepper(
            type: StepperType.horizontal,
            steps: getSteps(),
            currentStep: currentStep,
            onStepContinue: () {
              final isLastStep = currentStep == getSteps().length - 1;
              if (isLastStep) {
                if (type.toString() == "null" ||
                    _fromdate.text.toString() == "" ||
                    _todate.text.toString() == "") {
                  print("يجب تعبأة جميع البيانات المطلوبه");
                } else {
                  if (PersonalNotes.text == "") {
                    PersonalNotes.text = " ";
                  }
                  SendApp();
                  print("data sent");
                  Navigator.pop(
                      context,
                      MaterialPageRoute(
                          builder: (context) => nav(
                              userphone: widget.userphone,
                              username: widget.username,
                              useremail: widget.useremail)));
                }
              } else {
                setState(() => currentStep += 1);
              }
            },
            // controlsBuilder: (context, {onStepContinue, onStepCancel}) {
            //   final isLastStep = currentStep == getSteps().length - 1;
            //   return Container(
            //     margin: EdgeInsets.only(top: 50),
            //     child: Row(children: [
            //       Expanded(
            //         child: ElevatedButton(
            //           child: Text(isLastStep ? 'confirm' : 'NEXT'),
            //           onPressed: onStepContinue,
            //         ),
            //       ),
            //       const SizedBox(
            //         width: 12,
            //       ),
            //       if (currentStep != 0)
            //         Expanded(
            //             child: ElevatedButton(
            //           child: Text('BACK'),
            //           onPressed: onStepCancel,
            //         ))
            //     ]),
            //   );
            // },
            onStepTapped: (Step) => setState(() => currentStep = Step),
            onStepCancel: currentStep == 0
                ? null
                : () => setState(() => currentStep -= 1),
          ),
        ));
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text(' '),
          content: Column(
            children: [
              Card(
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  title: Text(
                    widget.id,
                    style: const TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  title: Text(
                    widget.name + " " + widget.lastname,
                    style: const TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  title: Text(
                    DateFormat("yyyy-MM-dd").format(widget.dob),
                    style: const TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text(' '),
          content: Column(
            children: [
              if (_Types.isEmpty)
                const Center(child: CircularProgressIndicator())
              else
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: DropdownButton<String>(
                      underline: Container(),
                      hint: const Text("اختار نوع المعاملة"),
                      isDense: true,
                      isExpanded: true,
                      items: _Types.map((ctry) {
                        return DropdownMenuItem<String>(
                            value: ctry["TYPE"], child: Text(ctry["TYPE"]));
                      }).toList(),
                      value: type,
                      onChanged: (value) {
                        setState(() {
                          type = value!;
                          istypeselected = true;
                          gettypesnotes();
                        });
                      },
                    ),
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                enabled: false,
                minLines: 6,
                maxLines: 10,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    hintText: note,
                    hintStyle: const TextStyle(color: Colors.black),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _fromdate,
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today_rounded),
                    labelText: "اختار تاريخ البدأ"),
                onTap: () async {
                  DateTime? picfromdate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(3000));

                  if (picfromdate != null) {
                    setState(() {
                      _fromdate.text =
                          DateFormat("yyyy-MM-dd").format(picfromdate);
                      print(_fromdate);
                    });
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "يجب ادخال تاريخ بداية المعاملة";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _todate,
                decoration: const InputDecoration(
                    icon: const Icon(Icons.calendar_today_rounded),
                    labelText: "اختار تاريخ النهاية"),
                onTap: () async {
                  DateTime? pictodate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(3000));

                  if (pictodate != null) {
                    setState(() {
                      _todate.text = DateFormat("yyyy-MM-dd").format(pictodate);
                    });
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'يجب ادخال تاريخ نهاية المعاملة';
                  } else {
                    return null;
                  }
                },
              )
            ],
          ),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text(' '),
          content: Container(
            child: TextFormField(
              minLines: 8,
              maxLines: 15,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                  hintText: "الرجاء ادخال بعض الملاحظات ان وجدت",
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              controller: PersonalNotes,
            ),
          ),
        ),
        Step(
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: const Text(' '),
          content: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color: Color.fromARGB(255, 167, 104, 238)),
                    borderRadius: BorderRadius.circular(20.0)),
                child: ListTile(
                    title: Center(
                      child: Text("المعلومات الشخصية"),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 5),
                        Text(widget.id),
                        SizedBox(height: 4),
                        Text(widget.name),
                        SizedBox(height: 4),
                        Text(DateFormat("yyyy-MM-dd").format(widget.dob)),
                        SizedBox(height: 5),
                      ],
                    )),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color: Color.fromARGB(255, 167, 104, 238)),
                    borderRadius: BorderRadius.circular(20.0)),
                child: ListTile(
                    title: Center(
                      child: Text("معلومات المعاملة"),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 5),
                        Text(type.toString()),
                        SizedBox(height: 4),
                        Text(_fromdate.text),
                        SizedBox(height: 4),
                        Text(_todate.text),
                        SizedBox(height: 5),
                      ],
                    )),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color: Color.fromARGB(255, 167, 104, 238)),
                    borderRadius: BorderRadius.circular(20.0)),
                child: ListTile(
                    title: Center(
                      child: Text("الملاحظات"),
                    ),
                    subtitle: Column(
                      children: [
                        SizedBox(height: 5),
                        Text(PersonalNotes.text),
                        SizedBox(height: 5),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ];
}
