import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class MyMap extends StatefulWidget {
  static const routeName = '/myMap';

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? newGoogleMapController;
  MapType _currentMapType=MapType.normal;
  final Set<Marker> _markers = {};
  // var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
  static const LatLng _center = const LatLng(45.521563, -122.677433);

  LatLng _lastMapPosition = _center;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  void locationPosition() async {
    try{
      Position position= await _determinePosition();
      _lastMapPosition=LatLng(position.latitude,position.longitude);
      CameraPosition cameraPosition= new CameraPosition(target: _lastMapPosition, zoom: 15);
      newGoogleMapController?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    }catch(error){
      throw(error);
    }
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    newGoogleMapController=controller;
    locationPosition();
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
// This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: "5 Star Rating",
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
    print(_lastMapPosition);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps Sample App'),
        backgroundColor: Colors.green[700],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            onCameraMove: _onCameraMove,
            myLocationButtonEnabled: true,
            markers: _markers,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            mapType: _currentMapType,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
          Icon(
            Icons.location_pin,
            size: 30,
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        FloatingActionButton(
                          onPressed: () => _onMapTypeButtonPressed(),
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          backgroundColor: Colors.green,
                          child: const Icon(Icons.map, size: 36.0),
                        ),
                        FloatingActionButton(
                          onPressed: _onAddMarkerButtonPressed,
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          backgroundColor: Colors.green,
                          child: const Icon(Icons.add_location, size: 36.0),
                        ),
                      ],
                    ),
                  ),
                ],
              )) /**/
        ],
      ),
    );
  }
}

