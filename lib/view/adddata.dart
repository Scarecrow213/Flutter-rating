import 'package:flutter/material.dart';
import 'package:flutterapitut/Controllers/databasehelper.dart';
import 'package:flutterapitut/view/dashboard.dart';
import 'package:flutterapitut/view/register.dart';


class AddData extends StatefulWidget{

  AddData({Key key , this.title}) : super(key : key);
  final String title;



  @override
  AddDataState  createState() => AddDataState();
}

class AddDataState extends State<AddData> {
  DatabaseHelper databaseHelper = new DatabaseHelper();



  final TextEditingController _subjectController = new TextEditingController();
  final TextEditingController _ratingController = new TextEditingController();
  final TextEditingController _studentController = new TextEditingController();
  final TextEditingController _dateController = new TextEditingController();



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Add record',
      home: Scaffold(
        appBar: AppBar(
          title:  Text('Add record'),
        ),
        body: Container(
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
                  controller: _ratingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Rating',
                    hintText: 'Input student`s rate',
                    icon: new Icon(Icons.rate_review),
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

              Container(
                height: 60,
                child: new TextField(
                  controller: _dateController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    hintText: 'Input date: YYYY-MM-DD',
                    icon: new Icon(Icons.date_range),
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 44.0),),

              Container(
                height: 50,
                child: new RaisedButton(
                  onPressed: (){
                    databaseHelper.addData(
                        _subjectController.text.trim(), _ratingController.text.trim(), _studentController.text.trim(), _dateController.text.trim());
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new Dashboard(),
                        )
                    );
                  },
                  color: Colors.blue,
                  child: new Text(
                    'Add',
                    style: new TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.blue),),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }



}















