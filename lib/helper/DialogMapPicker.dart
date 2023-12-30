import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:sevin_rm/UI/Screens/main_screen/Local1.dart';

import '../UI/Screens/component/Widght.dart';
import '../UI/Screens/conset/Const.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DialogMapPicker extends StatefulWidget {
  DialogMapPicker({Key? key , required this.latlang , this.nameLocation}) : super(key: key);
  String? nameLocation;
  LatLng latlang ;
  @override
  State<DialogMapPicker> createState() => _DialogMapPickerState();
}

class _DialogMapPickerState extends State<DialogMapPicker> {
  double? lat;
  double? lang;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close , color: Color1,size: 35.sp,)),
              ),
              Expanded(child: Text("Select Your Place" , style: TextStyle(color: Color1 , fontSize: 25.sp))),
              Expanded(
                flex : 8,
                child: PlacePicker(
                  apiKey: "AIzaSyBJjDpq0S-cRzOkfeC2NtIvch3sVxXmWjs",
                  initialPosition:  widget.latlang,
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
                        widget.nameLocation = value.name!;
                      }
                    });
                  },
                  useCurrentLocation: true,
                  resizeToAvoidBottomInset: true,
                  initialMapType: MapType.normal,
                ),
              ),
              Expanded(child: Text("Your Location is :${widget.nameLocation}", style: TextStyle(color: Color1 , fontSize: 25.sp))),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ButtonStaic(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Location1(
                              latLng: lat==null||lang==null ?null : LatLng(lat!,lang!),
                              nameLocation: widget.nameLocation,
                            );
                          }));
                    },
                    title: "OK",
                    colors: [Color1, Color1],
                    radius: 25.0,
                    widthContainer:
                    MediaQuery.of(context).size.width * 0.80,
                    heightContainer: 50.0,
                    boxShadow: [
                      BoxShadow(
                        color: Color1.withOpacity(0.5),
                        spreadRadius: 2.0,
                        blurRadius: 10.0,
                        offset: const Offset(-1, 6),
                      ),
                    ],
                    beginGrident: Alignment.topLeft,
                    endGrident: Alignment.bottomRight,
                    colorText: Color3,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    );
  }
}
