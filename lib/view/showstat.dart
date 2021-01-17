import 'package:flutter/material.dart';
import 'package:flutterapitut/Controllers/databasehelper.dart';
import 'package:flutterapitut/view/dashboard.dart';
import 'package:flutterapitut/view/editdata.dart';
import 'package:flutterapitut/view/register.dart';

class ShowStat extends StatefulWidget {
  String name;
  String subject;
  String student;
  String startDate;
  String endDate;
  String value;

  ShowStat({this.name, this.subject, this.student, this.startDate, this.endDate});

  @override
  ShowStatState createState() => ShowStatState();
}

class ShowStatState extends State<ShowStat> {
  DatabaseHelper databaseHelper = new DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Statistic',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Data'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new Dashboard(),
              )),
            )
          ],
        ),
        body: Container(
          child: ListView(
            padding: const EdgeInsets.only(
                top: 62, left: 12.0, right: 12.0, bottom: 12.0),
            children: <Widget>[
              new FutureBuilder<String>(
                future: databaseHelper.getStat(widget.name, widget.subject, widget.student, widget.startDate, widget.endDate),
                builder: (context, snapshot){
                  if(snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? new Text(
                        "${widget.name} = ${snapshot.data}",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),)
                      : new Center(child: new CircularProgressIndicator(),);
                },
              ),
              // Container(
              //   height: 50,
              //   child: new Text(
              //     "${widget.name} = ${widget.value}",
              //     textAlign: TextAlign.center,
              //     overflow: TextOverflow.ellipsis,
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

}
