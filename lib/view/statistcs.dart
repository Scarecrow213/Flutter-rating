import 'package:flutter/material.dart';
import 'package:flutterapitut/Controllers/databasehelper.dart';
import 'package:flutterapitut/view/showstat.dart';

import 'dashboard.dart';

class Statistics extends StatefulWidget{

  Statistics({Key key}) : super(key : key);

  @override
  State<StatefulWidget> createState() => StatisticsState();
}

class StatisticsState extends State<Statistics> {
  DatabaseHelper databaseHelper = new DatabaseHelper();

  final TextEditingController _subjectController = new TextEditingController();
  final TextEditingController _studentController = new TextEditingController();
  final TextEditingController _startDateController = new TextEditingController();
  final TextEditingController _endDateController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Statistics',
      home: Scaffold(
        appBar: AppBar(
          title:  Text('Statistics'),
        ),
        body: Form(
            key: _formKey,
            child: Container(
              child: ListView(
                padding: const EdgeInsets.only(top: 42,left: 12.0,right: 12.0,bottom: 12.0),
                children: <Widget>[
                  Container(
                    height: 60,
                    child: new TextField(
                      controller: _subjectController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Subject',
                        hintText: 'Input subject',
                        icon: new Icon(Icons.book),
                      ),
                    ),
                  ),

                  Container(
                    height: 60,
                    child: new TextField(
                      controller: _studentController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Student',
                        hintText: 'Input student`s name',
                        icon: new Icon(Icons.account_box_rounded),
                      ),
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.only(top: 22.0),),

                  Container(
                    height: 60,
                    child: new TextFormField(
                      controller: _startDateController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Start Date',
                        hintText: 'Input start date: YYYY-MM-DD',
                        icon: new Icon(Icons.date_range),
                      ),
                      validator: (value) {
                        var result = value.isNotEmpty && _endDateController.text.isEmpty ? "End Date must enter" : null;
                        return result;
                      },
                    ),
                  ),

                  Container(
                    height: 60,
                    child: new TextFormField(
                      controller: _endDateController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'End Date',
                        hintText: 'Input end date: YYYY-MM-DD',
                        icon: new Icon(Icons.date_range),
                      ),
                      validator: (value) {
                        var result = value.isNotEmpty && _startDateController.text.isEmpty ? "Start Date must enter" : null;
                        return result;
                      },
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.only(top: 44.0),),

                  Container(
                    height: 50,
                    child: new RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          databaseHelper.getStatMin(
                              _subjectController.text.trim(), _studentController.text.trim(), _startDateController.text.trim(), _endDateController.text.trim());
                          Navigator.of(context).push(
                              new MaterialPageRoute(
                                builder: (BuildContext context) => new ShowStat(name:"MIN", subject:_subjectController.text.trim(), student: _studentController.text.trim(), startDate:_startDateController.text.trim(), endDate:_endDateController.text.trim()),
                              )
                          );
                        } else {
                          _showDialog();
                        }
                      },
                      color: Colors.green,
                      child: new Text(
                        'MIN',
                        style: new TextStyle(
                            color: Colors.white,
                            backgroundColor: Colors.green),),
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.only(top: 22.0),),

                  Container(
                    height: 50,
                    child: new RaisedButton(
                      onPressed: (){
                        databaseHelper.getStatAverage(
                            _subjectController.text.trim(), _studentController.text.trim(), _startDateController.text.trim(), _endDateController.text.trim());
                        Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (BuildContext context) => new ShowStat(name:"AVG", subject:_subjectController.text.trim(), student: _studentController.text.trim(), startDate:_startDateController.text.trim(), endDate:_endDateController.text.trim()),
                            )
                        );
                      },
                      color: Colors.blue,
                      child: new Text(
                        'AVG',
                        style: new TextStyle(
                            color: Colors.white,
                            backgroundColor: Colors.blue),),
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.only(top: 22.0),),

                  Container(
                    height: 50,
                    child: new RaisedButton(
                      onPressed: (){
                        databaseHelper.getStatMax(
                            _subjectController.text.trim(), _studentController.text.trim(), _startDateController.text.trim(), _endDateController.text.trim());
                        Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (BuildContext context) => new ShowStat(name:"MAX", subject:_subjectController.text.trim(), student: _studentController.text.trim(), startDate:_startDateController.text.trim(), endDate:_endDateController.text.trim()),
                            )
                        );
                      },
                      color: Colors.redAccent,
                      child: new Text(
                        'MAX',
                        style: new TextStyle(
                            color: Colors.white,
                            backgroundColor: Colors.redAccent),),
                    ),
                  ),
                ],
              ),
            ),
            )
        )


      );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Failed'),
            content: new Text('Enter two dates'),
            actions: <Widget>[
              new RaisedButton(
                child: new Text(
                  'Close',
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

}