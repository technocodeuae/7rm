import 'package:flutter/cupertino.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

import '../Core/di/di_manager.dart';
import '../Core/shared_prefs/shared_prefs.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:google_maps_flutter_platform_interface/src/types/ui.dart';
class SelectYourLocation extends StatefulWidget {
  const SelectYourLocation({super.key});

  @override
  State<SelectYourLocation> createState() => _SelectYourLocationState();
}

class _SelectYourLocationState extends State<SelectYourLocation> {

  double? lat = DIManager.findDep<SharedPrefs>().getMyLocationLat();
  double? lang = DIManager.findDep<SharedPrefs>().getMyLocationLang();

  String location ='';
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: PlacePicker(
        apiKey: "AIzaSyBJjDpq0S-cRzOkfeC2NtIvch3sVxXmWjs",
        initialPosition:  LatLng(DIManager.findDep<SharedPrefs>().getMyLocationLat() ?? 45.678902,

            DIManager.findDep<SharedPrefs>().getMyLocationLang() ?? 123.456789),
        onCameraMove: (position) {
          print("Position : $position");
        },
        onPlacePicked: (value) {
          print("PLace is : ${value.adrAddress} Name : ${value.name}");
          setState(() {
            if(value.name !=null)
            {
              lat = value.geometry?.location.lat;
              lang = value.geometry?.location.lng;
            setState(() {
              location = value.name!;
              DIManager.findDep<SharedPrefs>().setYourCountry(location);
            });
              // Navigator.of(context).pop();
            }

          });
        },
        useCurrentLocation: true,
        resizeToAvoidBottomInset: true,
        initialMapType: MapType.normal,
      ),
    );
  }
}
