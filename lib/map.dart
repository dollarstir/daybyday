import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:polyline/polyline.dart' as poly;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapScreen extends StatefulWidget {
  final LatLng userLocation = LatLng(5.638808409615907,-0.10603934071450621);
  final LatLng nearestOfficeLocation = LatLng(5.643859,-0.2378298);

  MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Position? _currentPosition;
  Marker? _userMarker;
  Marker? _officeMarker;
  Polyline? _polyline;
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> _polylineCoordinates = [];
  Map<PolylineId, Polyline> _polyLines = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _userMarker = Marker(markerId: MarkerId('user'), position: widget.userLocation);
    _officeMarker = Marker(markerId: MarkerId('office'), position: widget.nearestOfficeLocation);
    _setPolyline();
  }

  void _getCurrentLocation() async {
    Position currentPosition = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = currentPosition;
      _userMarker = Marker(
        markerId: MarkerId('user'),
        position: LatLng(currentPosition.latitude, currentPosition.longitude),
      );
      _setPolylinesOnMap();
    });
  }

  String googleAPIKey = 'AIzaSyAy9xR_ioh6A7CZdMDsSaVm0xkaBhTaMU8';

  void _setPolyline() async {
    if (googleAPIKey == null || _currentPosition == null) {
      return;
    }

    var result = await PolylinePoints().getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      PointLatLng(widget.nearestOfficeLocation.latitude, widget.nearestOfficeLocation.longitude),
    );

    if (result.points.isNotEmpty) {
      List<LatLng> polylineCoordinates = result.points.map((point) => LatLng(point.latitude, point.longitude)).toList();
      setState(() {
        _polyline = Polyline(
          polylineId: PolylineId('route'),
          color: Colors.blue,
          points: polylineCoordinates,
        );
        _polylines.add(_polyline!);
        _polylineCoordinates = polylineCoordinates;
        _setPolylinesOnMap();
      });
    }
  }

  void _setPolylinesOnMap() {
    if (_polylineCoordinates.isNotEmpty) {
      _polyLines.clear();
      PolylineId id = PolylineId('poly');
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.blue,
        width: 4,
        points: _polylineCoordinates,
      );
      _polyLines[id] = polyline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.userLocation,
          zoom: 15,
        ),
        markers: {
          _userMarker!,
          _officeMarker!,
        },
        polylines: _polylines,

      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    ),
  );
}
}
