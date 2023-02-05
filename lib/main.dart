import 'package:flutter/material.dart';
import 'Home.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _myActivities = [
    {
      "display": "Running",
      "value": "Running",
    },
  ];
  late String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    _myActivitiesResult = '';
  }

  _saveForm() {
    var form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }

  var myList = [
    {"name": "Kotlin", "id": "0"},
    {"name": "Flutter", "id": "1"},
    {"name": "Java", "id": "2"},
    {"name": "Android", "id": "3"},
    {"name": "Nodejs", "id": "4"},
    {"name": "Fortlan", "id": "5"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Home());
  }
}
