import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttervnpt/fluttervnpt.dart';

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
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "1. Demo Plugin 1:",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Value:   ${this._deviceInfo}",
                    style: TextStyle(
                        color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter the Value',
                        errorText: this._validate ? 'Value Can\'t Be Empty' : null,
                      ))
                ],
              ),
              SizedBox(height: 16),
              RaisedButton(
                padding: EdgeInsets.all(8),
                onPressed: () {
                  this.gotoFlutterPlugin1();
                },
                child: Text("Start activity and receive data from Android native"),
              ),
              SizedBox(height: 16),
              RaisedButton(
                padding: EdgeInsets.all(8),
                onPressed: () {
                  this.gotoFlutterPlugin1();
                },
                child: Text("Start activity and receive data from Android native"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void gotoFlutterPlugin1() async {
    print(controller.text);
    if (controller.text.isEmpty) {
      setState(() {
        this._validate = true;
      });
    } else {
      setState(() {
        this._validate = false;
      });
      try {
        Map<String, dynamic> param = {};
        param["type"] = this.controller.text;
        String result = await FlutterVnpt().getDeviceInfo(param);
        if (result != null) {
          this._deviceInfo = result;
        } else {
          this._deviceInfo = "null";
        }
        this.controller.clear();
        setState(() {});
      } on PlatformException catch (e) {
        this._deviceInfo = e.message;
      }
    }
  }
}
