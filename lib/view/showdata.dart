import 'package:flutter/material.dart';
import 'package:flutterapitut/Controllers/databasehelper.dart';
import 'package:flutterapitut/view/dashboard.dart';
import 'package:flutterapitut/view/editdata.dart';
import 'package:flutterapitut/view/register.dart';


class ShowData extends StatefulWidget{

  List list;
  int index;
  ShowData({this.index , this.list}) ;


  @override
  ShowDataState  createState() => ShowDataState();
}

class ShowDataState extends State<ShowData> {
  DatabaseHelper databaseHelper = new DatabaseHelper();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Data',
      home: Scaffold(
        appBar: AppBar(
          title:  Text('Data'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
                onPressed: ()=>Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new Dashboard(),
                    )
                ),
            )
          ],
        ),
        body: Container(
          child: ListView(
            padding: const EdgeInsets.only(top: 62,left: 12.0,right: 12.0,bottom: 12.0),
            children: <Widget>[

              Container(
                height: 50,
                child: new Text(
                 "Student name : ${ widget.list[widget.index]['student']}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              Container(
                height: 50,
                child: new Text(
                  " Subject : ${widget.list[widget.index]['subject']}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              new Padding(padding: new EdgeInsets.only(top: 35.0),),

              Container(
                height: 50,
                child: new Text(
                  " Rate : ${widget.list[widget.index]['rate']}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              new Padding(padding: new EdgeInsets.only(top: 35.0),),

              Container(
                height: 50,
                child: new Text(
                  " Date : ${widget.list[widget.index]['date']}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  child: new FlatButton(
                    onPressed: ()=>Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new EditData(list:widget.list , index:widget.index),
                        )
                    ) ,
                    color: Colors.green,
                    child: new Text(
                      'Edit',
                      style: new TextStyle(
                        color: Colors.white,
                      ),),
                  ),
                ),

                Container(
                  height: 50,
                  child: new FlatButton(
                    onPressed: (){
                      databaseHelper.deleteData(widget.list[widget.index]['id']);
                      Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) => new Dashboard(),
                          )
                      );
                    },
                    color: Colors.blue,
                    child: new Text(
                      'Delete',
                      style: new TextStyle(
                        color: Colors.red,
                      ),),
                  ),
                ),
              ],
            )
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















