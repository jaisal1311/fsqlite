import 'package:flutter/material.dart';
import 'package:fqfliite/db/DatabaseProvider.dart';
import './Form.dart';
import './Entries.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> results = [];

  @override
  void initState() {
    super.initState();
    fetchResults();
  }

  fetchResults() async {
    var res = await DatabaseProvider.instance.queryAll();

    setState(() {
      print('setstate');
      results = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Demo sqflite')),
      body: Column(
        children: [
          Container(
            child: FormSQL(),
          ),
          results.length == 0
              ? Text(' No data available ')
              : Entries(results: results)
        ],
      ),
    );
  }
}
