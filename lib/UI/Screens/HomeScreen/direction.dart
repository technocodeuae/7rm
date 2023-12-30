import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sevin_rm/UI/Screens/conset/Const.dart';

import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../conset/Const.dart';
import '../conset/Const.dart';

class DirectionPage extends StatefulWidget {
   DirectionPage({required this.longitude,required this.latitude});
  double latitude;
   double longitude;

  @override
  State<DirectionPage> createState() => _DirectionPageState();
}

class _DirectionPageState extends State<DirectionPage> {
  double? lat = DIManager.findDep<SharedPrefs>().getMyLocationLat();
  double? lang = DIManager.findDep<SharedPrefs>().getMyLocationLang();
  late GoogleMapController mapController;
  LatLng origin = LatLng(24.4539, 54.3773); // تحديد الموقع الأول
  LatLng destination = LatLng(25.2769, 55.2962); // تحديد الموقع الثاني

  Set<Polyline> polylines = {}; // مجموعة من Polyline لرسم المسار

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _getDirections() async {
    origin = LatLng(lat ??24.4539,lang ?? 54.3773);
    destination = LatLng(widget.latitude , widget.longitude);
    String apiKey = 'AIzaSyBJjDpq0S-cRzOkfeC2NtIvch3sVxXmWjs'; // استبدل بمفتاح API الخاص بك
    String apiUrl = 'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> routes = data['routes'];
      if (routes.isNotEmpty) {
        Map<String, dynamic> route = routes[0];
        Map<String, dynamic> polyline = route['overview_polyline'];
        String points = polyline['points'];
        List<LatLng> decodedPoints = _decodePolyline(points);
        _drawPolyline(decodedPoints);
      }
    } else {
      throw Exception('Failed to load directions');
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0;
    int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      double latitude = lat / 1e5;
      double longitude = lng / 1e5;
      LatLng position = LatLng(latitude, longitude);
      points.add(position);
    }

    return points;
  }

  void _drawPolyline(List<LatLng> points) {
    origin = LatLng(lat ??24.4539,lang ?? 54.3773);
    destination = LatLng(widget.latitude , widget.longitude);

    Polyline polyline = Polyline(
      polylineId: PolylineId('route1'),
      color: Colors.blue,
      points: points,
      width: 5,
    );

    setState(() {
      polylines.add(polyline);
    });

    LatLngBounds bounds = LatLngBounds(southwest: origin, northeast: destination);
    mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }


  @override
  void initState() {
    _getDirections();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print('------------------------------------------------------------------------------------------');
    print(lat);
    print(lang);
    print('------------------------------------------------------------------------------------------');
    print('------------------------------------------------------------------------------------------');
    print('------------------------------------------------------------------------------------------');
    print('------------------------------------------------------------------------------------------');
    print('------------------------------------------------------------------------------------------');
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.deepPurple,
    ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: origin,
          zoom: 12.0,
        ),

        polylines: polylines,
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     _getDirections();
      //   },
      //   label: Text('حساب الاتجاهات'),
      //   icon: Icon(Icons.directions),
      // ),


    );
  }
}
