import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:google_maps_flutter_platform_interface/src/types/ui.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:sevin_rm/UI/Screens/HomeScreen/details_package.dart';
import 'package:sevin_rm/UI/Screens/main_screen/main_screen.dart';

import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../../data/models/categories/stables_services_package_model.dart';
import '../../../data/models/stables/stables_model.dart';
import '../../util/app_them.dart';
import '../HomeScreen/Home.dart';
import '../HomeScreen/details_package_for_all.dart';
import '../booking/selectingBooking.dart';
import '../conset/Const.dart';
import '../filter/filters.dart';
import '../login/login.dart';
import '../package/package_page.dart';
import '../search/search_screen.dart';
import '../stables/all_stables.dart';

class NearbyScreen extends StatefulWidget {
  StablesPackagesServicesCategoryModel? dataIncludeCategory;
  StablesModel? dataStablesModel;
//
  NearbyScreen(
      {Key? key,
      required this.dataIncludeCategory,
      required this.dataStablesModel})
      : super(key: key);

  @override
  State<NearbyScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<NearbyScreen> {
  int _page = 0;
  int selected_page = 0;
  List category = [
    {
      "image": "assets/images/img_10.png",
      "text": "Ability &",
    },
    {"image": "assets/images/img_11.png", "text": "Flat race"},
    {"image": "assets/images/img_12.png", "text": "Show horse"},
    {"image": "assets/images/img_13.png", "text": "Pony"},
    {
      "image": "assets/images/img_14.png",
      "text": "Race",
    },
  ];
  bool selectService = false;
  String firstName = DIManager.findDep<SharedPrefs>().getUserNamePerson() ?? "";
  String lastName = DIManager.findDep<SharedPrefs>().getUserNamePerson2() ?? "";
  String location = '';

  //
  // @override
  // void initState() async {
  //   location = await getLocationName(myLocation);
  //   super.initState();
  // }

  Future<String> getLocationName(LatLng location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        return placemark.name ?? 'Unnamed Location';
      } else {
        return 'Location Not Found';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  double? lat = DIManager.findDep<SharedPrefs>().getMyLocationLat();
  double? lang = DIManager.findDep<SharedPrefs>().getMyLocationLang();

  final LatLng myLocation = LatLng(
      DIManager.findDep<SharedPrefs>().getMyLocationLat() ?? 45.678902,
      DIManager.findDep<SharedPrefs>().getMyLocationLang() ?? 123.456789);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.sp),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/img.png'), fit: BoxFit.fill)),
        child: widget.dataIncludeCategory == null
            ? Center(
                child: CircularProgressIndicator(
                  color: Color1,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.sp,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.sp),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Hello, $firstName $lastName",
                              style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w700)),
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
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
                                                      auctionId:0,
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
                                      size: 32.sp,
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Text("Your location",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Color(0x66000000),
                        )),

                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                              onPressed: () async {
                                location = await getLocationName(myLocation);
                                print(location);
                              },
                              icon: Icon(
                                Icons.location_on,
                                color: Colors.black,
                              ),
                              label: Text(
                                DIManager.findDep<SharedPrefs>()
                                        .getYourCountry()
                                        .toString() ??
                                    '',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              )),
                          TextButton.icon(
                              onPressed: () async {
                                showBottomSheet(
                                    context: context,
                                    builder: (context) => Container(
                                          height: 400.sp,
                                          child: PlacePicker(
                                            apiKey:
                                                "AIzaSyBJjDpq0S-cRzOkfeC2NtIvch3sVxXmWjs",
                                            initialPosition: LatLng(
                                                DIManager.findDep<SharedPrefs>()
                                                        .getMyLocationLat() ??
                                                    45.678902,
                                                DIManager.findDep<SharedPrefs>()
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
                                                    location = value.name!;
                                                    DIManager.findDep<
                                                            SharedPrefs>()
                                                        .setYourCountry(
                                                            location);
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
                              icon: Icon(
                                CupertinoIcons.arrow_up_right_diamond,
                                color: Colors.black,
                              ),
                              label: Text(
                                "CHANGE",
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.black),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
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
                                borderRadius: BorderRadius.circular(15.sp),
                                borderSide: BorderSide(color: secondaryColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.sp),
                                  borderSide:
                                      BorderSide(color: secondaryColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.sp),
                                  borderSide:
                                      BorderSide(color: secondaryColor)),
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: Colors.black,
                              ),
                              suffixIcon: Icon(
                                Icons.settings_voice_sharp,
                                color: Colors.black,
                              ),
                              hintText: "Search Flat race, Pony and Stable",
                              hintStyle: TextStyle(
                                  fontSize: 14.sp, color: Colors.black)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 26.sp,
                    ),

                    widget.dataIncludeCategory!.services.length == 0 &&
                            widget.dataIncludeCategory!.stables.length == 0 &&
                            widget.dataIncludeCategory!.packages.length == 0
                        ? Center(
                            child: Container(
                              child: Text("No Result"),
                            ),
                          )
                        : Center(),

                    widget.dataIncludeCategory!.services.length == 0
                        ? Center()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Top services",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color: primaryColor,
                                  )),
                            ],
                          ),

                    widget.dataIncludeCategory!.services.length == 0
                        ? Center()
                        : Container(
                            height: 100.sp,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, i) {
                                return Container(
                                  height: 80.sp,
                                  width: 66.sp,
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10.sp, vertical: 15.sp),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                            color: primaryColor,
                                            blurRadius: 5.sp,
                                            offset: Offset(0, 5))
                                      ]),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            print("LLLLLLLLLLLLLL");

                                            Navigator.push<void>(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder:
                                                    (BuildContext context) =>
                                                        MainScreen(pagep: 10),
                                              ),
                                            );
                                            selectService = true;
                                          });
                                        },
                                        child: Image.network(
                                          widget.dataIncludeCategory!.services[i].imagePath ?? '',
                                          width: 40.sp,
                                          height: 40.sp,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Center(
                                              child: Image.asset(
                                                'assets/images/main/7rmlogo.png',
                                                width: 40.sp,
                                                height: 40.sp,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Text(
                                          widget.dataIncludeCategory
                                                  ?.services[i].name ??
                                              '',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              overflow: TextOverflow.ellipsis))
                                    ],
                                  ),
                                );
                              },
                              itemCount:
                                  widget.dataIncludeCategory?.services.length,
                            ),
                          ),
                    // trenner
                    // selectService
                    //     ? Container(
                    //         height: 130,
                    //         child: ListView.builder(
                    //           scrollDirection: Axis.horizontal,
                    //           itemBuilder: (_, i) {
                    //             return Container(
                    //               child: Column(
                    //                 children: [
                    //                   Container(
                    //                       height: 60,
                    //                       width: 60,
                    //                       padding:  EdgeInsets.all(3),
                    //                       margin:  EdgeInsets.symmetric(
                    //                           horizontal: 6, vertical: 15),
                    //                       decoration: BoxDecoration(
                    //                           color: Colors.white,
                    //                           shape: BoxShape.circle,
                    //                           border: Border.all(color: Colors.grey)),
                    //                       child:  CircleAvatar(
                    //                         backgroundImage: AssetImage(
                    //                             'assets/images/img_16.png'),
                    //                       )),
                    //                   Text(
                    //                     category[i]['text'],
                    //                     style:  TextStyle(fontSize: 13),
                    //                   )
                    //                 ],
                    //               ),
                    //             );
                    //           },
                    //           itemCount: category.length,
                    //         ),
                    //       )
                    //     : Container(),
                    widget.dataIncludeCategory!.services.length == 0
                        ? Center()
                        : SizedBox(
                            height: 25.sp,
                          ),
                    widget.dataIncludeCategory!.stables.length == 0
                        ? Center()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Popular Stables nearby",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color: primaryColor,
                                  )),
                              InkWell(
                                onTap: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          AllStaplesPage(
                                              dataStablesModel:
                                                  widget.dataStablesModel),
                                    ),
                                  );
                                },
                                child: Text("View all",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                    )),
                              ),
                            ],
                          ),
                    widget.dataIncludeCategory!.stables.length == 0
                        ? Center()
                        : Container(
                            height: 205.sp,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, i) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) => Home(
                                          stableId: widget.dataIncludeCategory
                                                  ?.stables[i].id ??
                                              0,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 240.sp,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.sp, vertical: 15.sp),
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
                                                width: 250.sp,
                                                height: 105.sp,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp),
                                                ),
                                                child: Image.network(
                                                  widget
                                                          .dataStablesModel!
                                                          .data[i]
                                                          .profileImage ??
                                                      'assets/images/main/7rmlogo.png',
                                                  fit: BoxFit.fill,
                                                  errorBuilder: (BuildContext
                                                          context,
                                                      Object error,
                                                      StackTrace? stackTrace) {
                                                    return Image.asset(
                                                        'assets/images/main/7rmlogo.png',
                                                        );
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.sp),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 120.sp,
                                                      child: Text(
                                                        widget
                                                                .dataIncludeCategory
                                                                ?.stables[i]
                                                                .name ??
                                                            '',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                      ),
                                                    ),
                                                    TextButton.icon(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons.star_rate,
                                                          color: Colors.amber,
                                                        ),
                                                        label: widget
                                                                    .dataIncludeCategory
                                                                    ?.stables[i]
                                                                    .evaluations
                                                                    .length !=
                                                                0
                                                            ? Text(
                                                                widget
                                                                        .dataIncludeCategory
                                                                        ?.stables[
                                                                            i]
                                                                        .evaluations[
                                                                            0]
                                                                        .averageEvaluation
                                                                        .toString() ??
                                                                    '',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              )
                                                            : Text(
                                                                '0',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ))
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 180.sp,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0.sp),
                                                  child: Text(
                                                    widget
                                                            .dataIncludeCategory
                                                            ?.stables[i]
                                                            .description ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                            stableId: widget
                                                                    .dataIncludeCategory
                                                                    ?.stables[i]
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
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5.sp,
                                                  horizontal: 10.sp),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10.sp),
                                                          topLeft:
                                                              Radius.circular(
                                                                  10.sp))),
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
                              itemCount:
                                  widget.dataIncludeCategory?.stables.length,
                            ),
                          ),
                    widget.dataIncludeCategory!.stables.length == 0
                        ? Center()
                        : SizedBox(
                            height: 25.sp,
                          ),
                    widget.dataIncludeCategory!.packages.length == 0
                        ? Center()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Special package & offers",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color: primaryColor,
                                  )),
                              InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                    return PackagePage();
                                  }));
                                },
                                child: Text("View all",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                    )),
                              ),
                            ],
                          ),
                    widget.dataIncludeCategory!.packages.length == 0
                        ? Center()
                        : SizedBox(
                            height: 10.sp,
                          ),
                    widget.dataIncludeCategory!.packages.length == 0
                        ? Center()
                        : Container(
                            height: 242.sp,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    widget.dataIncludeCategory?.packages.length,
                                itemBuilder: (_, i) {
                                  return InkWell(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                        return DetailsPackagePageForAllPackages(
                                            packageId: widget.dataIncludeCategory?.packages[i].packageId ?? 0,
                                            stableId: widget.dataIncludeCategory?.packages[i].stableId ?? 0,
                                  );
                                      }));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(10.sp),
                                      padding: EdgeInsets.only(bottom: 10.sp),
                                      width: 320.sp,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0x80BE8FFF),
                                                blurRadius: 8,
                                                offset: Offset(3, 5))
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 150.sp,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp),
                                                ),
////
                                                ///TODO:changing the Id to an Image but there's no image in the data
                                                child: Image.network(
                                                  widget.dataIncludeCategory
                                                          ?.packages[i].image
                                                          .toString() ??
                                                      'assets/images/main/7rmlogo.png',
                                                  fit: BoxFit.fill,
                                                  errorBuilder: (BuildContext
                                                          context,
                                                      Object error,
                                                      StackTrace? stackTrace) {
                                                    return Image.asset(
                                                        'assets/images/main/7rmlogo.png',
                                                        );
                                                  },
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 150.sp,
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0.sp),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 185.sp,
                                                      child: Text(
                                                        "LOOK AWESOME & SAVE MORE DISCOUNT",
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                      width: 100.sp,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "Book Now",
                                                            style: TextStyle(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        239,
                                                                        191,
                                                                        255,
                                                                        1)),
                                                          ),
                                                          Text( '${ widget
                                                              .dataIncludeCategory
                                                              ?.packages[i]
                                                              .price ?? 0} AED',
                                                            style: TextStyle(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color:
                                                                    Colors.white),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.sp),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  widget.dataIncludeCategory
                                                          ?.packages[i].name ??
                                                      '',
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      overflow:
                                                          TextOverflow.ellipsis),
                                                ),
                                                // TextButton.icon(
                                                //     onPressed: () {},
                                                //     icon: Icon(
                                                //       Icons.star_rate,
                                                //       color: Colors.amber,
                                                //     ),
                                                //     label: Text(
                                                //       '5.0',
                                                //       style: TextStyle(
                                                //           color: Colors.black),
                                                //     ))
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 8.0.sp),
                                            child: Text(
                                              widget.dataIncludeCategory
                                                      ?.packages[i].description ??
                                                  '',
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}

/*
Container(
                                          height: 200.h,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (_, index) {
                                              // StablesRemoteDataSourceImpl stablesRemoteDataSourceImpl =  StablesRemoteDataSourceImpl();
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push<void>(
                                                    context,
                                                    MaterialPageRoute<void>(
                                                      builder: (BuildContext
                                                              context) =>
                                                          Home(

                                                            stableId: dataBestStables
                                                                ?.stables[
                                                            index]
                                                                .id ??
                                                                0,
                                                          ),
                                                    ),
                                                  );
                                                  // stablesRemoteDataSourceImpl.getIndexStables();
                                                  // AppCubitMainPage.get(context)
                                                  //     .getAllStables();
                                                  // AppCubitMainPage.get(context)
                                                  //     .getAllCategories();
                                                },
                                                child: Container(
                                                  width: 230,

                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 15),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Color(
                                                                0x80BE8FFF),
                                                            blurRadius: 5,
                                                            offset:
                                                                Offset(3, 5))
                                                      ]),
                                                  child:   Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.push<
                                                                void>(
                                                              context,
                                                              MaterialPageRoute<
                                                                  void>(
                                                                builder: (BuildContext
                                                                context) =>
                                                                    Home(

                                                                      stableId: dataBestStables
                                                                          ?.stables[
                                                                      index]
                                                                          .id ??
                                                                          0,
                                                                    ),
                                                              ),
                                                            );

                                                            // AppCubitMainPage.get(context).geAllStables();
                                                            // AppCubitMainPage.get(context).getAllCategories();
                                                            // AppCubitMainPage.get(context).getStableTrainers();
                                                            // AppCubitMainPage.get(context).getNearbyStables();
                                                            // // AppCubitMainPage.get(context).getStableInformation(stableId: 1);
                                                            // AppCubitMainPage
                                                            //         .get(
                                                            //             context)
                                                            //     .getBestStables();
                                                          },
                                                          child: Container(
                                                            width: 230,
                                                            height: 100,
                                                            decoration:
                                                            BoxDecoration(
                                                              color: Colors
                                                                  .black,
                                                              //dataBestStables!.stables!
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      "assets/images/img_15.png"),
                                                                  fit: BoxFit
                                                                      .fill),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  10),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                           EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                              8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Container(
                                                                width: 120.w,
                                                                child: Text(
                                                                  dataBestStables
                                                                      ?.stables![index]
                                                                      .name ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                      15,overflow: TextOverflow.ellipsis),
                                                                ),
                                                              ),
                                                              TextButton.icon(
                                                                  onPressed: () {},
                                                                  icon: Icon(
                                                                    Icons
                                                                        .star_rate,
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                                  label: dataBestStables?.stables![index].averageEvaluation == 'null'
                                                                      ? Text(
                                                                    '0',
                                                                    style: TextStyle(color: Colors.black),
                                                                  )
                                                                      : Text(
                                                                    dataBestStables?.stables![index].averageEvaluation ?? '',
                                                                    style: TextStyle(color: Colors.black),
                                                                  ))
                                                            ],
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Padding(
                                                              padding:  EdgeInsets.only(bottom: 5),
                                                              child: Container(
                                                                width: 150.w,
                                                                child: Padding(
                                                                  padding:
                                                                   EdgeInsets
                                                                      .only(
                                                                      left:
                                                                      8.0),
                                                                  child: Text(
                                                                    dataBestStables
                                                                        ?.stables![
                                                                    index]
                                                                        .description ??
                                                                        '',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize: 12,
                                                                    ),
                                                                    overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                    softWrap: true,
                                                                    maxLines: 1,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            InkWell(
                                                              onTap: (() {

                                                                // AppCubitMainPage.get(context).getStableInformation(stableId: dataBestStables
                                                                //     ?.stables[
                                                                // index]
                                                                //     .id ??
                                                                //     0,);

                                                                if(DIManager.findDep<SharedPrefs>().getToken() !=null)
                                                                {
                                                                  Navigator.push<
                                                                      void>(
                                                                    context,
                                                                    MaterialPageRoute<
                                                                        void>(
                                                                      builder: (BuildContext
                                                                      context) =>
                                                                          BookingScreen(
                                                                            stableId: dataBestStables
                                                                                ?.stables[
                                                                            index]
                                                                                .id ??
                                                                                0,


                                                                          ),
                                                                    ),
                                                                  );
                                                                }else {

                                                                  Navigator.push<
                                                                      void>(
                                                                    context,
                                                                    MaterialPageRoute<
                                                                        void>(
                                                                      builder: (BuildContext
                                                                      context) =>
                                                                          LoginW(),
                                                                    ),
                                                                  );
                                                                }

                                                              }),
                                                              child: Container(
                                                                padding:
                                                                 EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                    10),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey),
                                                                    borderRadius: BorderRadius.only(
                                                                        bottomRight:
                                                                        Radius.circular(
                                                                            10),
                                                                        topLeft: Radius
                                                                            .circular(
                                                                            10))),
                                                                child: Text("Book",
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize: 14,
                                                                    )),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount: dataBestStables
                                                ?.stables?.length,
                                          ),
                                        ),

 */

//Container(
//         padding:  EdgeInsets.all(10),
//         width: double.infinity,
//         decoration:  BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage('assets/images/img.png'), fit: BoxFit.fill)),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding:  EdgeInsets.symmetric(vertical: 10),
//                 width: double.infinity,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                      Text("Hello, John Doe",
//                         style: TextStyle(
//                             fontSize: 17, fontWeight: FontWeight.w700)),
//                     Container(
//                       child: Row(
//                         children: [
//                           IconButton(
//                               onPressed: () {},
//                               icon:  Icon(
//                                 Icons.notification_add_outlined,
//                                 color: primaryColor,
//                               )),
//                           IconButton(
//                               onPressed: () {},
//                               icon:  Icon(
//                                 Icons.filter_alt,
//                                 color: primaryColor,
//                               ))
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//                Text("Your location",
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Color(0x66000000),
//                   )),
//
//               Container(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     TextButton.icon(
//                         onPressed: () {},
//                         icon:  Icon(
//                           Icons.location_on,
//                           color: Colors.black,
//                         ),
//                         label:  Text(
//                           "Abu Dhabi",
//                           style: TextStyle(fontSize: 12, color: Colors.black),
//                         )),
//                     TextButton.icon(
//                         onPressed: () {},
//                         icon:  Icon(
//                           CupertinoIcons.arrow_up_right_diamond,
//                           color: Colors.black,
//                         ),
//                         label:  Text(
//                           "CHANGE",
//                           style: TextStyle(fontSize: 12, color: Colors.black),
//                         ))
//                   ],
//                 ),
//               ),
//                SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 height: 36,
//                 padding:  EdgeInsets.symmetric(horizontal: 10),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                       // contentPadding: EdgeInsets.all(5),
//                       fillColor: secondaryColor,
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide:  BorderSide(color: secondaryColor),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide:  BorderSide(color: secondaryColor)),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide:  BorderSide(color: secondaryColor)),
//                       prefixIcon:  Icon(
//                         Icons.search_rounded,
//                         color: Colors.black,
//                       ),
//                       suffixIcon:  Icon(
//                         Icons.settings_voice_sharp,
//                         color: Colors.black,
//                       ),
//                       hintText: "Search Flat race, Pony and Stable",
//                       hintStyle:
//                            TextStyle(fontSize: 14, color: Colors.black)),
//                 ),
//               ),
//                SizedBox(
//                 height: 26,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Top services",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                         color: primaryColor,
//                       )),
//                   Text("View all",
//                       style: TextStyle(
//                         fontSize: 14,
//                       )),
//                 ],
//               ),
//
//               Container(
//                 height: 100,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (_, i) {
//                     return Container(
//                       height: 79,
//                       width: 64,
//                       padding:  EdgeInsets.all(5),
//                       margin:  EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 15),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(15),
//                           boxShadow: [
//                             BoxShadow(
//                                 color: primaryColor,
//                                 blurRadius: 5,
//                                 offset: Offset(0, 5))
//                           ]),
//                       child: Column(
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               setState(() {
//                                 print("LLLLLLLLLLLLLL");
//
//                                 Navigator.push<void>(
//                                   context,
//                                   MaterialPageRoute<void>(
//                                     builder: (BuildContext context) =>
//                                         MainScreen(pagep: 10),
//                                   ),
//                                 );
//                                 selectService = true;
//                               });
//                             },
//                             child: Image.asset(
//                               category[i]['image'],
//                               width: 40,
//                               height: 40,
//                             ),
//                           ),
//                           Text(widget.dataIncludeCategory?.services[i].name ?? '',
//                               style:  TextStyle(fontSize: 10,overflow: TextOverflow.ellipsis))
//                         ],
//                       ),
//                     );
//                   },
//                   itemCount: widget.dataIncludeCategory?.services.length,
//                 ),
//               ),
//               // trenner
//               // selectService
//               //     ? Container(
//               //         height: 130,
//               //         child: ListView.builder(
//               //           scrollDirection: Axis.horizontal,
//               //           itemBuilder: (_, i) {
//               //             return Container(
//               //               child: Column(
//               //                 children: [
//               //                   Container(
//               //                       height: 60,
//               //                       width: 60,
//               //                       padding:  EdgeInsets.all(3),
//               //                       margin:  EdgeInsets.symmetric(
//               //                           horizontal: 6, vertical: 15),
//               //                       decoration: BoxDecoration(
//               //                           color: Colors.white,
//               //                           shape: BoxShape.circle,
//               //                           border: Border.all(color: Colors.grey)),
//               //                       child:  CircleAvatar(
//               //                         backgroundImage: AssetImage(
//               //                             'assets/images/img_16.png'),
//               //                       )),
//               //                   Text(
//               //                     category[i]['text'],
//               //                     style:  TextStyle(fontSize: 13),
//               //                   )
//               //                 ],
//               //               ),
//               //             );
//               //           },
//               //           itemCount: category.length,
//               //         ),
//               //       )
//               //     : Container(),
//               SizedBox(
//                 height: 70,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Popular Stables nearby",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                         color: primaryColor,
//                       )),
//                   Text("View all",
//                       style: TextStyle(
//                         fontSize: 14,
//                       )),
//                 ],
//               ),
//               Container(
//                 height: 200,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (_, i) {
//                     return Container(
//                       width: 230,
//                       margin:  EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 15),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                              BoxShadow(
//                                 color: Color(0x80BE8FFF),
//                                 blurRadius: 5,
//                                 offset: Offset(3, 5))
//                           ]),
//                       child: Stack(
//                         children: [
//                           Container(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   width: 230,
//                                   height: 100,
//                                   decoration: BoxDecoration(
//                                     color: Colors.black,
//                                     image:  DecorationImage(
//                                         image: AssetImage(
//                                             "assets/images/img_15.png"),
//                                         fit: BoxFit.fill),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding:  EdgeInsets.symmetric(horizontal: 8),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                        Text(
//                                         widget.dataIncludeCategory?.stables[i].name??'',
//                                         style: TextStyle(fontSize: 15),
//                                       ),
//                                       TextButton.icon(
//                                           onPressed: () {},
//                                           icon:  Icon(
//                                             Icons.star_rate,
//                                             color: Colors.amber,
//                                           ),
//                                           label:  Text(
//                                             '5.0',
//                                             style: TextStyle(color: Colors.black),
//                                           ))
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(left: 8.0),
//                                   child: Text(
//                                     widget.dataIncludeCategory?.stables[i].description??'',
//                                     style: TextStyle(
//                                       fontSize: 12,overflow: TextOverflow.ellipsis
//                                     ),
//                                     overflow: TextOverflow.ellipsis,
//                                     softWrap: true,
//                                     maxLines: 1,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Positioned(
//                             bottom: 0,
//                             right: 0,
//                             child: InkWell(
//                               onTap: () {
//                                 Navigator.push<void>(
//                                   context,
//                                   MaterialPageRoute<void>(
//                                     builder: (BuildContext context) =>
//                                         BookingScreen(),
//                                   ),
//                                 );
//                               },
//                               child: Container(
//                                 padding:  EdgeInsets.symmetric(
//                                     vertical: 5, horizontal: 10),
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border: Border.all(color: Colors.grey),
//                                     borderRadius:  BorderRadius.only(
//                                         bottomRight: Radius.circular(10),
//                                         topLeft: Radius.circular(10))),
//                                 child:  Text("Book",
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                     )),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   itemCount: widget.dataIncludeCategory?.stables.length,
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Special package & offers",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                         color: primaryColor,
//                       )),
//                   Text("View all",
//                       style: TextStyle(
//                         fontSize: 14,
//                       )),
//                 ],
//               ),
//                SizedBox(
//                 height: 10,
//               ),
//             Container(
//               height: MediaQuery.of(context).size.height/3.5,
//               child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: widget.dataIncludeCategory?.packages.length,
//                   itemBuilder:(_,i){
//                     return   Container(
//
//                       margin:  EdgeInsets.all(10),
//                       padding: EdgeInsets.only(bottom: 10),
//                       width: MediaQuery.of(context).size.width/1.1,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                              BoxShadow(
//                                 color: Color(0x80BE8FFF),
//                                 blurRadius: 8,
//                                 offset: Offset(3, 5))
//                           ]),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Stack(
//                             children: [
//                               Container(
//                                 width: double.infinity,
//                                 height: 150,
//                                 decoration: BoxDecoration(
//                                   color: Colors.black,
//                                   image:  DecorationImage(
//                                       image: AssetImage("assets/images/img_15.png"),
//                                       fit: BoxFit.fill),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               Container(
//                                 width: double.infinity,
//                                 height: 150,
//                                 decoration: BoxDecoration(
//                                   color: Colors.black.withOpacity(0.2),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               Padding(
//                                 padding:  EdgeInsets.all(8.0),
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       width: 185,
//                                       child: Text(
//                                         "LOOK AWESOME & SAVE MORE DISCOUNT",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w700,
//                                             color: Colors.white),
//                                       ),
//                                     ),
//                                     Spacer(),
//                                     Container(
//                                       width: 100,
//                                       child: Column(
//                                         children: [
//                                           Text(
//                                             "Book Now",
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.w700,
//                                                 color:
//                                                 Color.fromRGBO(239, 191, 255, 1)),
//                                           ),
//                                           Text(
//                                             "250 AED",
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w700,
//                                                 color: Colors.white),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 8),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                  Text(
//                             widget.dataIncludeCategory?.packages[i].name ?? '',
//                                   style: TextStyle(fontSize: 15,overflow: TextOverflow.ellipsis),
//                                 ),
//                                 TextButton.icon(
//                                     onPressed: () {},
//                                     icon:  Icon(
//                                       Icons.star_rate,
//                                       color: Colors.amber,
//                                     ),
//                                     label:  Text(
//                                       '5.0',
//                                       style: TextStyle(color: Colors.black),
//                                     ))
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(left: 8.0),
//                             child: Text(
//                               widget.dataIncludeCategory?.packages[i].description?? '',
//                               style: TextStyle(
//                                 fontSize: 12,overflow: TextOverflow.ellipsis
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                               softWrap: true,
//                               maxLines: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   } ),
//             ),
//             ],
//           ),
//         ),
//       )
