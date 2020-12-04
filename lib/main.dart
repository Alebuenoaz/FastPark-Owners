//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

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
      routes: <String, WidgetBuilder>{
        '/ParkingRegister': (context) => ParkingRegister()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class ParkingRegister extends StatefulWidget {
  ParkingRegister({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ParkingRegisterState createState() => _ParkingRegisterState();
}

class _MyHomePageState extends State<MyHomePage> {
  final databaseReference = Firestore.instance;
  int _counter = 0;

  void _createRecord() async {
    _counter++;
    await databaseReference.collection("parqueos").document("1").setData({
      'title': 'Chupate esa Drope',
      'description': 'Parece que funciona Firebase'
    });

    DocumentReference ref = await databaseReference.collection("parqueos").add({
      'title': 'parqueo' + _counter.toString(),
      'description': 'Descripcion del parqueo nro ' + _counter.toString()
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
      databaseReference.collection('parqueos').document('1').delete();
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
          FlatButton(
            child: Text('Registrar Parqueo'),
            color: Colors.green,
            onPressed: () {
              Navigator.pushNamed(context, '/ParkingRegister');
            },
          ),
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

class _ParkingRegisterState extends State<ParkingRegister> {
  Firestore firestore = Firestore.instance;
  TextEditingController ownerIDController = new TextEditingController();
  TextEditingController ownIDController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController directionController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  var url;
  File _image;
  var picker = ImagePicker();

  void _create(String ownerID, String ownID, String name, String direction,
      String price, String description, BuildContext context) async {
    try {
      if (checkFields(
          ownerID, ownID, name, direction, price, description, _image)) {
        await uploadPic();
        await firestore
            .collection('RegistroParqueos')
            .document('testUser')
            .setData({
          'CI Propietario': ownerID,
          'CI propio': ownID,
          'Nombre': name,
          'Direccion': direction,
          'Tarifa por hora': price,
          'Descripcion': description,
          'Imagen': url,
        });
        clean();
        Navigator.of(context).pop();
      } else {
        _showMyDialog(context);
      }
    } catch (e) {
      print(e);
    }
  }

  Widget _buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Error'),
      content: Text("Debe rellenar todos los espacios del formulario"),
      actions: [
        FlatButton(
            child: Text("Aceptar"),
            textColor: Colors.blue,
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }

  Future _showMyDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (_) => _buildAlertDialog(context),
    );
  }

  bool checkFields(String ownerID, String ownID, String name, String direction,
      String price, String description, File img) {
    if (ownerID != null &&
        ownID != null &&
        name != null &&
        direction != null &&
        price != null &&
        description != null &&
        img != null)
      return true;
    else
      return false;
  }

  void _read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await firestore
          .collection('RegistroParqueos')
          .document('testUser')
          .get();
      print(documentSnapshot.data);
    } catch (e) {
      print(e);
    }
  }

  void _update() async {
    try {
      firestore.collection('RegistroParqueos').document('testUser').updateData({
        'firstName': 'testUpdated',
      });
    } catch (e) {
      print(e);
    }
  }

  void _delete() async {
    try {
      firestore.collection('RegistroParqueos').document('testUser').delete();
    } catch (e) {
      print(e);
    }
  }

  Future getImage() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadPic() async {
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    url = dowurl.toString();

    print("Referencia en Firestore: " + url);
  }

  void clean() {
    ownerIDController.clear();
    ownIDController.clear();
    nameController.clear();
    directionController.clear();
    priceController.clear();
    descriptionController.clear();
    url = null;
    _image = null;
    picker = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Parqueos"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 15.0,
              ),
              TextField(
                controller: ownerIDController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CI dueño del parqueo',
                ),
              ),
              Container(
                height: 15.0,
              ),
              TextField(
                controller: ownIDController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CI propio',
                ),
              ),
              Container(
                height: 15.0,
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre',
                ),
              ),
              Container(
                height: 15.0,
              ),
              TextField(
                controller: directionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Dirección',
                ),
              ),
              Container(
                height: 15.0,
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Precio por hora (Bs)',
                ),
              ),
              Container(
                height: 15.0,
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Descripción del parqueo',
                ),
              ),
              Container(
                height: 15.0,
              ),
              /*Center(
                child: _image == null
                    ? Text('No image selected.')
                    : Image.file(_image),
              ),*/
              Container(
                height: 210.0,
                width: 210.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    //image: AssetImage("assets/insert-logo.png"),
                    image: _image == null
                        ? AssetImage("assets/insert-logo.png")
                        : FileImage(_image), // here add your image file path
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              RaisedButton(
                child: Text("Elegir una foto"),
                onPressed: getImage,
              ),
              RaisedButton(
                  child: Text('CREAR'),
                  color: Colors.lightBlue,
                  onPressed: () {
                    _create(
                        ownerIDController.text,
                        ownIDController.text,
                        nameController.text,
                        directionController.text,
                        priceController.text,
                        descriptionController.text,
                        context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
