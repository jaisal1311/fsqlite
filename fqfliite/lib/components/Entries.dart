import 'package:flutter/material.dart';
import '../db/DatabaseProvider.dart';

class Entries extends StatefulWidget {
  final results;

  const Entries({Key key, this.results}) : super(key: key);

  @override
  _EntriesState createState() => _EntriesState();
}

class _EntriesState extends State<Entries> {
  List<Map<String, dynamic>> results;

  @override
  void initState() {
    super.initState();
    fetchResults();
  }

  fetchResults() async {
    var res = await DatabaseProvider.instance.queryAll();
    setState(() {
      results = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: results.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 50,
                child: Text(results[index][DatabaseProvider.COLUMN_NAME]));
          }),
    );
  }
}
