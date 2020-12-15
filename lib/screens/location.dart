import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class LocationMap extends StatefulWidget {
  static const String id = "LOCATION";

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<LocationMap> {
  GoogleMapController controller;

  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    GoogleMapController _mapController;
    LatLng middlePoint = (currentPosition != null)
        ? new LatLng(currentPosition.latitude, currentPosition.longitude)
        : null;

    return Scaffold(
      // appBar: AppBar(
      //       title: Center(child: Text('FastPark!')),
      //     ),
      body: (currentPosition != null)
          ? Stack(children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                          currentPosition.latitude, currentPosition.longitude),
                      zoom: 18.0),
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                  zoomGesturesEnabled: true,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  onCameraMove: (CameraPosition camposition) async {
                    double screenWidth = MediaQuery.of(context).size.width *
                        MediaQuery.of(context).devicePixelRatio;
                    double screenHeight = MediaQuery.of(context).size.height *
                        MediaQuery.of(context).devicePixelRatio;

                    double middleX = screenWidth / 2;
                    double middleY = screenHeight / 2;

                    ScreenCoordinate screenCoordinate = ScreenCoordinate(
                        x: middleX.round(), y: middleY.round());

                    middlePoint =
                        await _mapController.getLatLng(screenCoordinate);
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: new Icon(Icons.location_on,
                    color: Theme.of(context).primaryColor, size: 30),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  splashColor: Theme.of(context).secondaryHeaderColor,
                  color: Theme.of(context).primaryColor,
                  shape: StadiumBorder(),
                  child: Text(
                    'Aceptar',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, middlePoint);
                    //print("Coordenadas: ");
                    //print(middlePoint);
                  },
                ),
              ),
            ])
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
