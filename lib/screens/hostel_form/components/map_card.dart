import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class MapCard extends StatefulWidget {
  final TextEditingController latitute, longitute;
  const MapCard({Key? key, required this.latitute ,required this.longitute});
  @override
  _MapCardState createState() => _MapCardState();
}

class _MapCardState extends State<MapCard> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? newGoogleMapController;
  MapType _currentMapType=MapType.normal;

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
  LatLng _lastMapPosition= LatLng(0, 0);
  @override
  void initState() {
    // TODO: implement initState
    _lastMapPosition = LatLng(double.parse(widget.latitute.text), double.parse(widget.latitute.text));
    super.initState();
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
    widget.latitute.text = _lastMapPosition.latitude.toString();
    widget.longitute.text = _lastMapPosition.longitude.toString();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    newGoogleMapController=controller;
    locationPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              scrollGesturesEnabled: false,
              onCameraMove: _onCameraMove,
              myLocationButtonEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              mapType: _currentMapType,
              initialCameraPosition: CameraPosition(
                target: LatLng(double.parse(widget.latitute.text), double.parse(widget.longitute.text),),
                zoom: 15.0,
              ),
            ),
            Icon(
              Icons.location_pin,
              size: 40,
            ),
          ],
        ),
    );
  }
}

