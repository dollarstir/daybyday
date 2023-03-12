import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  final LatLng nearestOffice = LatLng(5.545230, -0.250080);

  MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  late BitmapDescriptor usermarkerIcon;
  late BitmapDescriptor officemarkerIcon;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    setCustomMarkerIcon();
    _getCurrentLocation();
  }

  void _openMaps() async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${widget.nearestOffice.latitude},${widget.nearestOffice.longitude}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void setCustomMarkerIcon() async {
    usermarkerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)), 'assets/images/marker.png');
    officemarkerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)), 'assets/images/office.png');
  }

  void _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
      });
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(
                  _currentPosition!.latitude, _currentPosition!.longitude),
              zoom: 12.0,
              tilt: 50.0,
              bearing: 210.0),
        ),
      );
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
                target: LatLng(
                    _currentPosition!.latitude, _currentPosition!.longitude),
                // zoom: 10.0,
                zoom: 12.0,
                tilt: 50.0,
                bearing: 210.0),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: Set.from([
              Marker(
                markerId: MarkerId('userMarker'),
                position: LatLng(
                  _currentPosition!.latitude,
                  _currentPosition!.longitude,
                ),
                icon: usermarkerIcon,
                infoWindow: InfoWindow(title: 'Your Location'),
              ),
              Marker(
                markerId: MarkerId('officeMarker'),
                position: widget.nearestOffice,
                icon: officemarkerIcon,
                infoWindow: InfoWindow(title: 'Nearest Office'),
              ),
            ]),
            polylines: Set<Polyline>.of(_polylines.values),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FutureBuilder<int>(
                  future: _getDistanceInMinutes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        'Estimated time to nearest office: ${snapshot.data!} minutes',
                        style: TextStyle(fontSize: 20),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FloatingActionButton(
            onPressed: () {
              _openMaps();
            },
            child: Icon(Icons.directions),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () async {
              _calculateDistance();
            },
            child: Icon(Icons.my_location),
          ),
        ],
        // FloatingActionButton(
        //   onPressed: ()async{
        //     _calculateDistance();
        //     await _getDistanceInMinutes();
        //   },
        //   child: Icon(Icons.directions),
        // ),

        // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  Map<PolylineId, Polyline> _polylines = {};
  void _addPolyLine() async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      width: 3,
      points: _polylineCoordinates,
    );
    _polylines[id] = polyline;

    setState(() {
      _polylines = _polylines;
    });
  }

  List<LatLng> _polylineCoordinates = [];
  void _calculateDistance() async {
    _polylineCoordinates.clear();
    _polylineCoordinates
        .add(LatLng(_currentPosition!.latitude, _currentPosition!.longitude));
    _polylineCoordinates.add(widget.nearestOffice);
    _addPolyLine();
  }

  double _getDistanceInKm() {
    double distanceInMeters = Geolocator.distanceBetween(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        widget.nearestOffice.latitude,
        widget.nearestOffice.longitude);
    return distanceInMeters / 1000;
  }

  Future<int> _getDistanceInMinutes() async {
    if (_currentPosition == null) {
      return 0;
    }
    double distanceInKm = _getDistanceInKm();
    double speedInKmPerHour = 60;
    double timeInHours = distanceInKm / speedInKmPerHour;
    int timeInMinutes = (timeInHours * 60).round();
    return timeInMinutes;
  }
}
