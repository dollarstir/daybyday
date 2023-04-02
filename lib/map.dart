import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class MapScreen extends StatefulWidget {

  MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
 final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController textController =  TextEditingController();
  late BitmapDescriptor usermarkerIcon;
  late BitmapDescriptor officemarkerIcon;
  Position? _currentPosition;
  LatLng targetOffice = LatLng(5.545230, -0.250080);
  bool hasPermission = false;

  void _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      hasPermission = false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        hasPermission = false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      hasPermission = false;
    }

    hasPermission = true;
    // setState(() {});
    setCustomMarkerIcon();
    _getCurrentLocation();
  }

  //  Future<void> _getCurrentPosition() async {
  //   final hasPermission = await _handlePermission();

  //   if (!hasPermission) {
  //     return;
  //   }

  //   // final position =  await Geolocator.getCurrentPosition(
  //   //     desiredAccuracy: LocationAccuracy.high);   
  //   // setState(() {
  //   //   // _locationMessage =
  //   //   //     "${position.latitude},${position.longitude}";
  //   // });
  // }


  @override
  void initState() {
    super.initState();
    _handlePermission();
  }

  void _openMaps() async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${targetOffice.latitude},${targetOffice.longitude}';
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
    if(!hasPermission || _currentPosition == null) {
      return Material(
        child: Center(
          child: Text("Loading map..."),
        )
      );
    }
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
                position: targetOffice,
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
          Positioned(
            top: 24,
            left: 48,
            right: 48,
            child: Material(
              borderRadius: BorderRadius.circular(24.0),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: GooglePlaceAutoCompleteTextField(
                  textEditingController: textController,
                  googleAPIKey: "AIzaSyAy9xR_ioh6A7CZdMDsSaVm0xkaBhTaMU8",
                  inputDecoration: InputDecoration(),
                  debounceTime: 800, // default 600 ms,
                  countries: ["gh"],// optional by default null is set
                  isLatLngRequired:true,// if you required coordinates from place detail
                  getPlaceDetailWithLatLng: (Prediction prediction) {
                    // this method will return latlng with place detail
                     targetOffice = LatLng(
                        double.parse(prediction.lat ?? "${targetOffice.latitude}"), 
                        double.parse(prediction.lng ?? "${targetOffice.longitude}"),
                      );
                      print("===========================");
                      print("${prediction.lat}, ${prediction.lng}");
                      print(targetOffice);
                      print("===========================");
                      _calculateDistance();
                  }, // this callback is called when isLatLngRequired is true
                  itmClick: (Prediction prediction) {
                      textController.text= prediction.description ?? '';
                      // textController.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description.length));
                    }
                ),
              ),
            ),
    
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
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
    _polylineCoordinates.add(targetOffice);
    _addPolyLine();
    _getDistanceInMinutes();
  }

  double _getDistanceInKm() {
    double distanceInMeters = Geolocator.distanceBetween(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        targetOffice.latitude,
        targetOffice.longitude);
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
