//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
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
  TextEditingController phoneNumberController = new TextEditingController();
  var url;
  File _image;
  var picker = ImagePicker();
  bool _isMondaySelected = false;
  bool _isTuesdaySelected = false;
  bool _isWednesdaySelected = false;
  bool _isThursdaySelected = false;
  bool _isFridaySelected = false;
  bool _isSaturdaySelected = false;
  bool _isSundaySelected = false;
  TimeOfDay startTime = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay endTime = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay startTimePicked;
  TimeOfDay endTimePicked;

  void _create(
      String ownerID,
      String ownID,
      String name,
      String direction,
      String phoneNumber,
      String price,
      String description,
      BuildContext context) async {
    try {
      String days = availableDays();
      String localStartTime = getTimeFormat(startTime);
      String localEndTime = getTimeFormat(endTime);
      if (checkFields(ownerID, ownID, name, direction, phoneNumber, price,
          description, days, localStartTime, localEndTime, _image)) {
        await uploadPic();
        await firestore
            .collection('RegistroParqueos')
            .document('testing2')
            .setData({
          'CIPropietario': int.parse(ownerID),
          'CIPropio': int.parse(ownID),
          'Nombre': name,
          'Direccion': direction,
          'Telefono': int.parse(phoneNumber),
          'TarifaPorHora': double.parse(price),
          'Descripcion': description,
          'Días': days,
          'HoraInicio': localStartTime,
          'HoraCierre': localEndTime,
          'Imagen': url,
        });
        //Show completed action toast
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Parqueo registrado correctamente"),
        ));
        clean();
        Navigator.of(context).pop();
      } else {
        _showMyDialog(context);
      }
    } catch (e) {
      print(e);
    }
  }

  void _update() async {
    try {
      firestore.collection('RegistroParqueos').document('testing').updateData({
        'firstName': 'testUpdated',
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Null> _selectStartTime(BuildContext context) async {
    startTimePicked = await showTimePicker(
      context: context,
      initialTime: startTime,
    );
    if (startTimePicked != null)
      setState(() {
        startTime = startTimePicked;
      });
  }

  Future<Null> _selectEndTime(BuildContext context) async {
    endTimePicked = await showTimePicker(
      context: context,
      initialTime: endTime,
    );
    if (endTimePicked != null)
      setState(() {
        endTime = endTimePicked;
      });
  }

  Widget _buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Error'),
      content:
          Text("Debe rellenar todos los espacios del formulario correctamente"),
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

  bool checkFields(
      String ownerID,
      String ownID,
      String name,
      String direction,
      String phoneNumber,
      String price,
      String description,
      String availableDays,
      String startHour,
      String endHour,
      File img) {
    if (ownerID != "" &&
        ownID != "" &&
        name != "" &&
        direction != "" &&
        phoneNumber != "" &&
        price != "" &&
        description != "" &&
        availableDays != "" &&
        verifyHours(startHour, endHour) &&
        img != null)
      return true;
    else
      return false;
  }

  String availableDays() {
    String days = "";
    if (_isMondaySelected) days += "1";
    if (_isThursdaySelected) days += "2";
    if (_isWednesdaySelected) days += "3";
    if (_isTuesdaySelected) days += "4";
    if (_isFridaySelected) days += "5";
    if (_isSaturdaySelected) days += "6";
    if (_isSundaySelected) days += "7";
    return days;
  }

  String getTimeFormat(TimeOfDay time) {
    String timeHourString = (time.hour).toString();
    String timeMinuteString = (time.minute).toString();

    if (timeMinuteString.length == 1) {
      if (timeMinuteString == '0')
        timeMinuteString += '0';
      else {
        timeMinuteString = '0' + timeMinuteString;
      }
    }
    return "$timeHourString:$timeMinuteString";
  }

  bool verifyHours(String startTimeString, String endTimeString) {
    int initialHour = int.parse(
        startTimeString.split(":")[0] + startTimeString.split(":")[1]);
    int finalHour =
        int.parse(endTimeString.split(":")[0] + endTimeString.split(":")[1]);
    if (initialHour < finalHour) {
      return true;
    } else {
      return false;
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

    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    url = dowurl.toString();

    print("Referencia en Firestore: " + url);
  }

  void clean() {
    setState(() {
      ownerIDController.clear();
      ownIDController.clear();
      nameController.clear();
      directionController.clear();
      phoneNumberController.clear();
      priceController.clear();
      descriptionController.clear();
      url = null;
      _image = null;
      picker = null;
    });
  }

  Future createDayPickDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text('Elegir días hábiles'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    CheckboxListTile(
                      title: Text("Lunes"),
                      secondary: Icon(Icons.today_outlined),
                      controlAffinity: ListTileControlAffinity.platform,
                      onChanged: (bool value) {
                        setState(() {
                          _isMondaySelected = value;
                        });
                      },
                      value: _isMondaySelected,
                    ),
                    CheckboxListTile(
                      title: Text("Martes"),
                      secondary: Icon(Icons.today_outlined),
                      controlAffinity: ListTileControlAffinity.platform,
                      onChanged: (bool value) {
                        setState(() {
                          _isTuesdaySelected = value;
                        });
                      },
                      value: _isTuesdaySelected,
                    ),
                    CheckboxListTile(
                      title: Text("Miercoles"),
                      secondary: Icon(Icons.today_outlined),
                      controlAffinity: ListTileControlAffinity.platform,
                      onChanged: (bool value) {
                        setState(() {
                          _isWednesdaySelected = value;
                        });
                      },
                      value: _isWednesdaySelected,
                    ),
                    CheckboxListTile(
                      title: Text("Jueves"),
                      secondary: Icon(Icons.today_outlined),
                      controlAffinity: ListTileControlAffinity.platform,
                      onChanged: (bool value) {
                        setState(() {
                          _isThursdaySelected = value;
                        });
                      },
                      value: _isThursdaySelected,
                    ),
                    CheckboxListTile(
                      title: Text("Viernes"),
                      secondary: Icon(Icons.today_outlined),
                      controlAffinity: ListTileControlAffinity.platform,
                      onChanged: (bool value) {
                        setState(() {
                          _isFridaySelected = value;
                        });
                      },
                      value: _isFridaySelected,
                    ),
                    CheckboxListTile(
                      title: Text("Sábado"),
                      secondary: Icon(Icons.today_outlined),
                      controlAffinity: ListTileControlAffinity.platform,
                      onChanged: (bool value) {
                        setState(() {
                          _isSaturdaySelected = value;
                        });
                      },
                      value: _isSaturdaySelected,
                    ),
                    CheckboxListTile(
                      title: Text("Domingo"),
                      secondary: Icon(Icons.today_outlined),
                      controlAffinity: ListTileControlAffinity.platform,
                      onChanged: (bool value) {
                        setState(() {
                          _isSundaySelected = value;
                        });
                      },
                      value: _isSundaySelected,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  child: Text("Aceptar"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Parqueo"),
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
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  LengthLimitingTextInputFormatter(7)
                ],
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
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  LengthLimitingTextInputFormatter(7)
                ],
              ),
              Container(
                height: 15.0,
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre completo',
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
                controller: phoneNumberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Telefono del parqueo',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  LengthLimitingTextInputFormatter(7)
                ],
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
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                ],
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
                height: 10.0,
              ),
              ButtonTheme(
                minWidth: 380.0,
                height: 50.0,
                child: RaisedButton(
                    child: Text('Elegir Días de Atención'),
                    color: Colors.lightBlue[100],
                    onPressed: () {
                      createDayPickDialog(context);
                    }),
              ),
              Container(
                height: 10.0,
              ),
              Text('Horario de atención:'),
              new Container(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.alarm),
                      iconSize: 50,
                      onPressed: () {
                        _selectStartTime(context);
                      },
                    ),
                    Text('Desde ${startTime.hour}:${startTime.minute}',
                        style: TextStyle(fontSize: 17)),
                    Container(
                      width: 35,
                    ),
                    IconButton(
                      icon: Icon(Icons.alarm),
                      iconSize: 50,
                      onPressed: () {
                        _selectEndTime(context);
                      },
                    ),
                    Text('Hasta ${endTime.hour}:${endTime.minute}',
                        style: TextStyle(fontSize: 17)),
                  ],
                ),
              ),
              Container(
                height: 210.0,
                width: 210.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _image == null
                        ? AssetImage("assets/insert-picture.png")
                        : FileImage(_image), // here add your image file path
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                height: 5.0,
              ),
              RaisedButton(
                child: Text("Elegir una foto"),
                onPressed: getImage,
              ),
              Container(
                height: 5.0,
              ),
              ButtonTheme(
                minWidth: 380.0,
                height: 50.0,
                child: RaisedButton(
                    child: Text('REGISTRAR'),
                    color: Colors.lightBlue,
                    onPressed: () {
                      _create(
                          ownerIDController.text,
                          ownIDController.text,
                          nameController.text,
                          directionController.text,
                          phoneNumberController.text,
                          priceController.text,
                          descriptionController.text,
                          context);
                    }),
              ),
              Container(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
