import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plugin_vnpt/flutter_plugin_vnpt.dart';
import 'package:flutternative/flutternative.dart';
import 'package:fluttervnpt/fluttervnpt.dart';
import 'package:pluginflutter/pluginflutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _deviceInfo = "empty";
  TextEditingController controller = TextEditingController();

  String kichban3 = "empty";
  TextEditingController controller1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Core'),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 12, right: 12, top: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "1. Kịch bản 1:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              SizedBox(height: 8),
              Text(
                "Value:   ${this._deviceInfo}",
                style:
                    TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter the Value',
                  )),
              SizedBox(height: 16),
              RaisedButton(
                padding: EdgeInsets.all(8),
                onPressed: () {
                  this.gotoFlutterPlugin2();
                },
                child: Text("Start and receive data from Flutter native"),
              ),
              SizedBox(height: 16),
              Text(
                "2. Kịch bản 2:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              RaisedButton(
                padding: EdgeInsets.all(8),
                onPressed: () {
                  FlutterPluginVnpt.gotoFlutterNative1();
                },
                child: Text("Start Flutter Native 1"),
              ),
              SizedBox(height: 8),
              RaisedButton(
                padding: EdgeInsets.all(8),
                onPressed: () {
                  Flutternative.gotoFlutterNative2;
                },
                child: Text("Start Flutter Native 2"),
              ),
              SizedBox(height: 8),
              Text(
                "3. Kịch bản 3:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              SizedBox(height: 8),
              Text(
                "Value:   ${this.kichban3}",
                style:
                    TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                  controller: controller1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter the Value',
                  )),
              SizedBox(height: 16),
              RaisedButton(
                padding: EdgeInsets.all(8),
                onPressed: () async {
                  this.gotoFlutterPlugin1();
                },
                child: Text("Start Flutter Plugin"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void gotoFlutterPlugin2({String dataFromPlugin1}) async {
    try {
      Map<String, dynamic> param = {};
      param["type"] = this.controller.text;
      var result = await FlutterVnpt().getDeviceInfo(param);
      if (result != null) {
        this._deviceInfo = result["value"];
        print("---- ${result["value"]}");
        if(result["event"] != null || result["event"] != "") {
          this.gotoFlutterPlugin1(dataFromPlugin2: result["value"]);
        }
      } else {
        this._deviceInfo = "null";
      }
      //this.controller.clear();
      setState(() {});
    } on PlatformException catch (e) {
      this._deviceInfo = e.message;
    }
  }

  void gotoFlutterPlugin1({String dataFromPlugin2}) async {
    try {
      Map<String, dynamic> param = {};
      param["type"] = dataFromPlugin2 ?? this.controller1.text;
      var result = await Pluginflutter().getDeviceInfo(param);
      print("value : ${result.toString()}");
      if (result != null) {
        this.kichban3 = result["value"];
        print("------kich ban 3  ${result["value"]}");
        if(result["event"] != null || result["event"] != "") {
          this.gotoFlutterPlugin2(dataFromPlugin1: result["value"]);
        }
      } else {
        this.kichban3 = "null";
      }
      //this.controller1.clear();
      setState(() {});
    } on PlatformException catch (e) {
      this.kichban3 = e.message;
    }
  }
}
