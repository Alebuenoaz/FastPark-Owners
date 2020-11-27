import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  final databaseReference = Firestore.instance;
  int _counter = 0;

  void _createRecord() async {
    _counter++;
    await databaseReference.collection("parqueos")
      .document("1")
      .setData({
        'title': 'Chupate esa Drope',
        'description': 'Parece que funciona Firebase'
      });

    DocumentReference ref = await databaseReference.collection("parqueos")
      .add({
        'title': 'parqueo'+ _counter.toString(),
        'description': 'Descripcion del parqueo nro '+ _counter.toString()
      });
    print(ref.documentID);
  }

  void _getData() {
  databaseReference
      .collection("parqueos")
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

  void _updateData() {
    try {
      databaseReference
        .collection('parqueos')
        .document('1')
        .updateData({'description': 'Seguila chupando Drope'});
    } catch (e) {
      print(e.toString());
    }
  }

  void _deleteData() {
    try {
      databaseReference
        .collection('parqueos')
        .document('1')
        .delete();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FireStore Demo'),
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            child: Text('Create'),
            onPressed: _createRecord,
          ),
          RaisedButton(
            child: Text('Read'),
            onPressed: _getData,
          ),
          RaisedButton(
            child: Text('Update'),
            onPressed: _updateData,
          ),
          RaisedButton(
            child: Text('Delete'),
            onPressed: _deleteData,
          ),
        ],
      )), //center
    );
  }
}
