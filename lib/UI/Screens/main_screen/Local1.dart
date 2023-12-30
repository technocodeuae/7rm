import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:sevin_rm/Core/di/di_manager.dart';
import 'package:sevin_rm/Core/shared_prefs/shared_prefs.dart';
import 'package:sevin_rm/UI/Screens/HomeScreen/Home.dart';
import 'package:sevin_rm/UI/Screens/conset/Const.dart';
import 'package:sevin_rm/helper/error_dialog_helper.dart';

import '../../util/app_them.dart';
import '../booking/selectingBooking.dart';
import '../component/Widght.dart';
import '../filter/filters.dart';
import '../login/login.dart';
import '../search/search_screen.dart';
import 'bloc/cubit.dart';
import 'bloc/states.dart';

class Location1 extends StatefulWidget {
  Location1({Key? key, this.latLng, this.nameLocation}) : super(key: key);
  LatLng? latLng;
  String? nameLocation;
  @override
  State<Location1> createState() => _Location1State();
}

class _Location1State extends State<Location1> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(DIManager.findDep<SharedPrefs>().getMyLocationLat() ?? 54.37,
        DIManager.findDep<SharedPrefs>().getMyLocationLang() ?? 24.45),
    zoom: 5,
  );
  double? lat = DIManager.findDep<SharedPrefs>().getMyLocationLat();
  double? lang = DIManager.findDep<SharedPrefs>().getMyLocationLang();
  @override
  Widget build(BuildContext context) {
    print(DIManager.findDep<SharedPrefs>().getMyLocationLat());
    print(DIManager.findDep<SharedPrefs>().getMyLocationLang());
    return BlocProvider(
      create: (context) => AppCubitMainPage(),
      child: BlocConsumer<AppCubitMainPage, AppCubitMainPageStates>(
          listener: (context, state) {
        if (state is GetAllStablesErrorStates) {
          DialogHelper.errorDialog(context, "Error", state.error);
        }
      }, builder: (context, state) {
        if (DIManager.findDep<SharedPrefs>().getToken() != null) {
          if (state is AppMainPageInitialStates) {
            BlocProvider.of<AppCubitMainPage>(context)
                .getNearbyStablesLocation(widget.latLng);
            return Center(child: CircularProgressIndicator(color: Color1));
          } else if (state is GetNearbyStablesSuccessStates) {
            return Scaffold(
              body: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/img.png'),
                        fit: BoxFit.fill)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Hello..",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700)),
                            Container(
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.notification_add_outlined,
                                        color: primaryColor,
                                      )),
                                  IconButton(
                                      onPressed: () {

                                        if (DIManager.findDep<SharedPrefs>().getToken() != null){

                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      Filters(
                                                        auctionId:

                                                            0,
                                                      )));
                                        }else {

                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) {
                                                return LoginW();
                                              }));
                                        }



                                      },
                                      icon: Icon(
                                        Icons.filter_alt,
                                        color: primaryColor,
                                        size: 32,
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text("Your location",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0x66000000),
                            )),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                ),
                                label: Text(
                                  DIManager.findDep<SharedPrefs>()
                                      .getYourCountry()
                                      .toString(),
                                  // widget.nameLocation??"Abu Dhabi",
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.black),
                                )),
                            TextButton.icon(
                                onPressed: () async {
                                  showBottomSheet(
                                      context: context,
                                      builder: (context) => Container(
                                            height: 400,
                                            child: PlacePicker(
                                              apiKey:
                                                  "AIzaSyBJjDpq0S-cRzOkfeC2NtIvch3sVxXmWjs",
                                              initialPosition: LatLng(
                                                  DIManager.findDep<
                                                              SharedPrefs>()
                                                          .getMyLocationLat() ??
                                                      45.678902,
                                                  DIManager.findDep<
                                                              SharedPrefs>()
                                                          .getMyLocationLang() ??
                                                      123.456789),
                                              onCameraMove: (position) {
                                                print("Position : $position");
                                              },
                                              onPlacePicked: (value) {
                                                print(
                                                    "PLace is : ${value.adrAddress} Name : ${value.name}");
                                                setState(() {
                                                  if (value.name != null) {
                                                    lat = value
                                                        .geometry?.location.lat;
                                                    lang = value
                                                        .geometry?.location.lng;
                                                    setState(() {
                                                      // location = value.name!;
                                                      DIManager.findDep<
                                                              SharedPrefs>()
                                                          .setYourCountry(
                                                              value.name!);
                                                    });
                                                    // Navigator.of(context).pop();
                                                  }
                                                });
                                              },
                                              useCurrentLocation: true,
                                              resizeToAvoidBottomInset: true,
                                              initialMapType: MapType.normal,
                                            ),
                                          ));
                                  // }
                                },
                                icon: const Icon(
                                  CupertinoIcons.arrow_up_right_diamond,
                                  color: Colors.black,
                                ),
                                label: const Text(
                                  "CHANGE",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                )),
                            // TextButton.icon(
                            //     onPressed: () async{
                            //       double? lat = DIManager.findDep<SharedPrefs>().getMyLocationLat();
                            //       double? lang = DIManager.findDep<SharedPrefs>().getMyLocationLang();
                            //       if(widget.latLng!=null){
                            //         showDialog(context: context, builder: (context) =>
                            //             FixerHelper.MakeMapDialog(widget.nameLocation??"Abu Dhabi",widget.latLng!));
                            //       }
                            //       else {
                            //         LatLng latlng = LatLng(lat ?? 45.678901, lang
                            //             ?? 123.456789);
                            //         showDialog(context: context, builder: (context) =>
                            //             FixerHelper.MakeMapDialog(widget.nameLocation??"Abu Dhabi",latlng));
                            //       }
                            //     },
                            //     icon: const Icon(
                            //       CupertinoIcons.arrow_up_right_diamond,
                            //       color: Colors.black,
                            //     ),
                            //     label: const Text(
                            //       "CHANGE",
                            //       style: TextStyle(fontSize: 12, color: Colors.black),
                            //     ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return SearchScreen();
                            },
                          ));
                        },
                        child: Container(
                          height: 36.sp,
                          padding: EdgeInsets.symmetric(horizontal: 10.sp),
                          child: TextFormField(
                            decoration: InputDecoration(
                                // contentPadding: EdgeInsets.all(5),
                                fillColor: secondaryColor,
                                filled: true,
                                enabled: false,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: secondaryColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: secondaryColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: secondaryColor)),
                                prefixIcon: const Icon(
                                  Icons.search_rounded,
                                  color: Colors.black,
                                ),
                                suffixIcon: const Icon(
                                  Icons.settings_voice_sharp,
                                  color: Colors.black,
                                ),
                                hintText: "Search Flat race, Pony and Stable",
                                hintStyle: const TextStyle(
                                    fontSize: 14, color: Colors.black)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: Stack(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: GoogleMap(
                                  initialCameraPosition: _kGooglePlex,
                                  // buildingsEnabled: true,
                                  // liteModeEnabled: true,

                                  onMapCreated:
                                      (GoogleMapController controller) async {
                                    _controller.complete(controller);
                                  },
                                  markers: state
                                      .stablesNearbyModel.data!
                                      .map((stable) {
                                    return Marker(
                                      markerId: const MarkerId('myLocation'),
                                      position: LatLng(
                                          double.parse(stable.latitude!),
                                          double.parse(stable.longitude!)),
                                      infoWindow:
                                          InfoWindow(title: stable.name),
                                    );
                                  }).toSet(),
                                  zoomControlsEnabled: false,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 250.sp,
                                  padding: EdgeInsets.only(bottom: 20.sp),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return Home(
                                                stableId: state
                                                        .stablesNearbyModel
                                                        .data[index]
                                                        .id ??
                                                    0);
                                          }));
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10.sp,
                                              vertical: 15.sp),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color(0x80BE8FFF),
                                                    blurRadius: 5.sp,
                                                    offset: Offset(3, 5))
                                              ]),
                                          child: Stack(
                                            children: [
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      ////
                                                      width: 280.sp,
                                                      height: 120.sp,
                                                      decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.sp),
                                                      ),
                                                      child: Image.network(
                                                        state
                                                                .stablesNearbyModel
                                                                .data[index]
                                                                .profileImage ??
                                                            'assets/images/main/7rmlogo.png',
                                                        fit: BoxFit.fill,
                                                        errorBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Object error,
                                                                StackTrace?
                                                                    stackTrace) {
                                                          return Image.asset(
                                                              'assets/images/main/7rmlogo.png',
                                                              );
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8.sp,
                                                          left: 8.sp),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Container(
                                                            width: 200.sp,
                                                            child: Text(
                                                              state
                                                                      .stablesNearbyModel
                                                                      .data[
                                                                          index]
                                                                      .name ??
                                                                  "",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.sp,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10.sp,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.star_rate,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                              state
                                                                          .stablesNearbyModel
                                                                          .data[
                                                                              index]
                                                                          .evaluations.isEmpty
                                                                  ? Text(
                                                                      "0.0",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                    )
                                                                  : Text(
                                                                state
                                                                    .stablesNearbyModel
                                                                    .data[
                                                                index]
                                                                    .evaluations[0].averageEvaluation ??
                                                                          "",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                    )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 200.sp,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.sp),
                                                        child: Text(
                                                          state
                                                                  .stablesNearbyModel
                                                                  .data[
                                                                      index]
                                                                  .description ??
                                                              "",
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          softWrap: true,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: InkWell(
                                                  onTap: () {
                                                    if (DIManager.findDep<
                                                                SharedPrefs>()
                                                            .getToken() !=
                                                        null) {
                                                      Navigator.push<void>(
                                                        context,
                                                        MaterialPageRoute<void>(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              BookingScreen(
                                                                  stableId: state
                                                                          .stablesNearbyModel
                                                                          .data[
                                                                              index]
                                                                          .id ??
                                                                      0),
                                                        ),
                                                      );
                                                    } else {
                                                      Navigator.push<void>(
                                                        context,
                                                        MaterialPageRoute<void>(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              LoginW(),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5.sp,
                                                            horizontal: 10.sp),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10.sp),
                                                                topLeft: Radius
                                                                    .circular(10
                                                                        .sp))),
                                                    child: Text("Book",
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: state.stablesNearbyModel.data.length ??
                                        0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
//                   floatingActionButton: FloatingActionButton(
//                     backgroundColor: secondaryColor,
//                     onPressed: () {
// // Sli
//                     },
//                     child: const Icon(
//                       Icons.menu,
//                       color: Colors.white,
//                     ),
//                   ),
            );
          } else if (state is GetNearbyStablesLoadingStates) {
            return Center(child: CircularProgressIndicator(color: Color1));
          } else if (state is GetNearbyStablesErrorStates) {
            return Scaffold(
              body: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/img.png'),
                        fit: BoxFit.fill)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Hello..",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700)),
                            Container(
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.notification_add_outlined,
                                        color: primaryColor,
                                      )),
                                  IconButton(
                                      onPressed: () {

                                        if (DIManager.findDep<SharedPrefs>().getToken() != null){

                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      Filters(
                                                        auctionId:

                                                            0,
                                                      )));
                                        }else {

                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) {
                                                return LoginW();
                                              }));
                                        }



                                      },
                                      icon: Icon(
                                        Icons.filter_alt,
                                        color: primaryColor,
                                        size: 32,
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text("Your location",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0x66000000),
                            )),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                ),
                                label: Text(
                                  DIManager.findDep<SharedPrefs>()
                                      .getYourCountry()
                                      .toString(),
                                  // widget.nameLocation??"Abu Dhabi",
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.black),
                                )),
                            TextButton.icon(
                                onPressed: () async {
                                  showBottomSheet(
                                      context: context,
                                      builder: (context) => Container(
                                            height: 400,
                                            child: PlacePicker(
                                              apiKey:
                                                  "AIzaSyBJjDpq0S-cRzOkfeC2NtIvch3sVxXmWjs",
                                              initialPosition: LatLng(
                                                  DIManager.findDep<
                                                              SharedPrefs>()
                                                          .getMyLocationLat() ??
                                                      45.678902,
                                                  DIManager.findDep<
                                                              SharedPrefs>()
                                                          .getMyLocationLang() ??
                                                      123.456789),
                                              onCameraMove: (position) {
                                                print("Position : $position");
                                              },
                                              onPlacePicked: (value) {
                                                print(
                                                    "PLace is : ${value.adrAddress} Name : ${value.name}");
                                                setState(() {
                                                  if (value.name != null) {
                                                    lat = value
                                                        .geometry?.location.lat;
                                                    lang = value
                                                        .geometry?.location.lng;
                                                    setState(() {
                                                      // location = value.name!;
                                                      DIManager.findDep<
                                                              SharedPrefs>()
                                                          .setYourCountry(
                                                              value.name!);
                                                    });
                                                    // Navigator.of(context).pop();
                                                  }
                                                });
                                              },
                                              useCurrentLocation: true,
                                              resizeToAvoidBottomInset: true,
                                              initialMapType: MapType.normal,
                                            ),
                                          ));
                                  // }
                                },
                                icon: const Icon(
                                  CupertinoIcons.arrow_up_right_diamond,
                                  color: Colors.black,
                                ),
                                label: const Text(
                                  "CHANGE",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                )),
                            // TextButton.icon(
                            //     onPressed: () async{
                            //       double? lat = DIManager.findDep<SharedPrefs>().getMyLocationLat();
                            //       double? lang = DIManager.findDep<SharedPrefs>().getMyLocationLang();
                            //       if(widget.latLng!=null){
                            //         showDialog(context: context, builder: (context) =>
                            //             FixerHelper.MakeMapDialog(widget.nameLocation??"Abu Dhabi",widget.latLng!));
                            //       }
                            //       else {
                            //         LatLng latlng = LatLng(lat ?? 45.678901, lang
                            //             ?? 123.456789);
                            //         showDialog(context: context, builder: (context) =>
                            //             FixerHelper.MakeMapDialog(widget.nameLocation??"Abu Dhabi",latlng));
                            //       }
                            //     },
                            //     icon: const Icon(
                            //       CupertinoIcons.arrow_up_right_diamond,
                            //       color: Colors.black,
                            //     ),
                            //     label: const Text(
                            //       "CHANGE",
                            //       style: TextStyle(fontSize: 12, color: Colors.black),
                            //     ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return SearchScreen();
                            },
                          ));
                        },
                        child: Container(
                          height: 36,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                                // contentPadding: EdgeInsets.all(5),
                                fillColor: secondaryColor,
                                filled: true,
                                enabled: false,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: secondaryColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: secondaryColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: secondaryColor)),
                                prefixIcon: const Icon(
                                  Icons.search_rounded,
                                  color: Colors.black,
                                ),
                                suffixIcon: const Icon(
                                  Icons.settings_voice_sharp,
                                  color: Colors.black,
                                ),
                                hintText: "Search Flat race, Pony and Stable",
                                hintStyle: const TextStyle(
                                    fontSize: 14, color: Colors.black)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Text(state.error.toString()),
                      ),
                    ]),
              ),
//                   floatingActionButton: FloatingActionButton(
//                     backgroundColor: secondaryColor,
//                     onPressed: () {
// // Sli
//                     },
//                     child: const Icon(
//                       Icons.menu,
//                       color: Colors.white,
//                     ),
//                   ),
            );
          }
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "You must login",
                  style: TextStyle(fontSize: 25.sp),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Container(
                width: 100.w,
                child: ButtonStaic(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => LoginW(),
                        ),
                      );
                    },
                    title: "Go to Login",
                    fontSize: 14.sp,
                    colorText: Colors.white,
                    fontWeight: FontWeight.w400,
                    heightContainer: 48,
                    widthContainer: 80.w),
              )
            ],
          );
        }

        return Container();
      }),
    );
  }
}
