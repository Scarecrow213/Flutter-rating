import 'package:flutter/material.dart';
import 'package:flutterapitut/Controllers/databasehelper.dart';
import 'package:flutterapitut/view/dashboard.dart';
import 'package:flutterapitut/view/register.dart';


class EditData extends StatefulWidget{

  List list;
  int index;
  EditData({this.index , this.list}) ;


  @override
  EditDataState  createState() => EditDataState();
}

class EditDataState extends State<EditData> {
  DatabaseHelper databaseHelper = new DatabaseHelper();

    TextEditingController _subjectController  ;
    TextEditingController _ratingController  ;
    TextEditingController _studentController  ;
    TextEditingController _dateController  ;

  @override
  void initState(){
        _subjectController = new TextEditingController(text: widget.list[widget.index]['subject']);
        _ratingController = new TextEditingController(text: widget.list[widget.index]['rating']);
        _studentController = new TextEditingController(text: widget.list[widget.index]['student']);
        _dateController = new TextEditingController(text: widget.list[widget.index]['date']);
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Update Product',
      home: Scaffold(
        appBar: AppBar(
          title:  Text('Update Product'),
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
                    databaseHelper.editData(widget.list[widget.index]['id']
                        , _subjectController.text.trim(), _ratingController.text.trim(), _studentController.text.trim(), _dateController.text.trim());
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new Dashboard(),
                        )
                    );
                  },
                  color: Colors.blue,
                  child: new Text(
                    'Update',
                    style: new TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.blue),),
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 44.0),),




            ],
          ),
        ),
      ),
    );
  }



  void _showDialog(){
    showDialog(
        context:context ,
        builder:(BuildContext context){
          return AlertDialog(
            title: new Text('Failed'),
            content:  new Text('Check your email or password'),
            actions: <Widget>[
              new RaisedButton(

                child: new Text(
                  'Close',
                ),

                onPressed: (){
                  Navigator.of(context).pop();
                },

              ),
            ],
          );
        }
    );
  }



}















