import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:google_maps_flutter_platform_interface/src/types/ui.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:sevin_rm/UI/Screens/HomeScreen/Home.dart';
import 'package:sevin_rm/UI/Screens/conset/Const.dart';
import 'package:sevin_rm/UI/Screens/main_screen/main_screen.dart';

import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../../data/models/stables/best_stables_model.dart';
import '../../../data/models/stables/stable_trainers_model.dart';
import '../../../data/models/stables/stables_model.dart';
import '../../InformationTrainer/profile.dart';
import '../../util/app_them.dart';
import '../filter/filters.dart';
import '../login/login.dart';
import '../search/search_screen.dart';
import '../stables/all_stables.dart';

////
class ServieseScreen extends StatefulWidget {
  ServieseScreen(
      {Key? key,
      required this.stableTrainersModel,
      required this.dataBestStables,
      required this.dataStables})
      : super(key: key);
  BestStablesModel? dataBestStables;
  StablesModel? dataStables;
  StableTrainersModel? stableTrainersModel;
  @override
  State<ServieseScreen> createState() => _ServieseScreenState();
}

class _ServieseScreenState extends State<ServieseScreen> {
  int _page = 0;
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
  String firstName = DIManager.findDep<SharedPrefs>().getUserNamePerson() ?? "";
  String lastName = DIManager.findDep<SharedPrefs>().getUserNamePerson2() ?? "";
  double? lat = DIManager.findDep<SharedPrefs>().getMyLocationLat();
  double? lang = DIManager.findDep<SharedPrefs>().getMyLocationLang();
  @override
  Widget build(BuildContext context) {
    print(widget.stableTrainersModel?.data?.trainers.length);
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/img.png'),
                  fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Hello, $firstName $lastName",
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
                const Text("Your location",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0x66000000),
                    )),
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
                            style: TextStyle(fontSize: 12, color: Colors.black),
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
                                              lat =
                                                  value.geometry?.location.lat;
                                              lang =
                                                  value.geometry?.location.lng;
                                              setState(() {
                                                DIManager.findDep<SharedPrefs>()
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
                            style: TextStyle(fontSize: 12, color: Colors.black),
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
                            borderSide: const BorderSide(color: secondaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  const BorderSide(color: secondaryColor)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  const BorderSide(color: secondaryColor)),
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
                if (widget.stableTrainersModel == null ||
                    widget.stableTrainersModel == null) ...[
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 4),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color1,
                      ),
                    ),
                  ),
                ] else ...[
                  widget.stableTrainersModel?.data?.trainers.length == 0
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Trainer specialists',
                              style: TextStyle(
                                color: Color(0xFF5A0072),
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            // Text("View all",
                            //     style: TextStyle(
                            //       fontSize: 14,
                            //     )),
                          ],
                        ),
                  widget.stableTrainersModel?.data?.trainers.length == 0
                      ? Container()
                      : Container(
                          height: 150.sp,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, i) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return InformationProfile(

                                          trainerId: widget
                                              .stableTrainersModel!
                                              .data?.trainers[i].id ?? 0,
                                        );
                                      }));
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 60.sp,
                                          width: 60,
                                          padding: const EdgeInsets.all(3),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 15),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: CircleAvatar(
                                            backgroundColor: Color1,
                                            backgroundImage: NetworkImage(widget
                                                    .stableTrainersModel!
                                                    .data?.trainers[i].userImage??
                                                '',),
                                          )),
                                      Text(
                                        '${widget.stableTrainersModel?.data?.trainers[i].firstName ?? ''}',
                                        style: const TextStyle(fontSize: 13),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: widget.stableTrainersModel?.data
                                    ?.trainers.length ??
                                5,
                          ),
                        ),
                  widget.dataBestStables?.data.length == 0
                      ? Container()
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
                                                widget.dataStables),
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
                  widget.dataBestStables?.data.length == 0
                      ? Container()
                      : Container(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, i) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return Home(
                                        stableId: widget.dataBestStables
                                                ?.data[i].id ??
                                            0);
                                  }));
                                },
                                child: Container(
                                  width: 240.sp,
                                  // height: 400.sp,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10.sp, vertical: 15.sp),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color(0x80BE8FFF),
                                            blurRadius: 5,
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
                                              height: 90.sp,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Image.network(
                                                ////
                                                widget
                                                        .dataBestStables
                                                        ?.data[i]
                                                        .profileImage ??
                                                    'assets/images/main/7rmlogo.png',
                                                fit: BoxFit.fill,
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object error,
                                                    StackTrace? stackTrace) {
                                                  return Image.asset(
                                                      'assets/images/main/7rmlogo.png',
                                                      fit: BoxFit.fill);
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.sp),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    width: 120.sp,
                                                    child: Text(
                                                      widget
                                                              .dataBestStables
                                                              ?.data[i]
                                                              .name ??
                                                          '',
                                                      style: TextStyle(
                                                          fontSize: 15.sp,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                  ),
                                                  TextButton.icon(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        Icons.star_rate,
                                                        color: Colors.amber,
                                                      ),
                                                      label: const Text(
                                                        '5.0',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 140.sp,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.sp),
                                                child: Text(
                                                  widget
                                                          .dataBestStables
                                                          ?.data[i]
                                                          .description ??
                                                      '',
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                  ),
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
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.sp,
                                              horizontal: 10.sp),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(10.sp),
                                                  topLeft:
                                                      Radius.circular(10.sp))),
                                          child: Text("Book",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: widget.dataBestStables?.data.length,
                          ),
                        ),
                ],
              ],
            ),
          ),
        ),
        // drawer: Drawer(),
        // bottomNavigationBar: CurvedNavigationBar(
        // index: 2,
        // height: 75.0,
        // items: <Widget>[
        // const Icon(
        // Icons.home_outlined,
        // size: 30,
        // color: Colors.grey,
        // ),
        // const Icon(
        // Icons.location_on_outlined,
        // size: 30,
        // color: Colors.grey,
        // ),
        // Image.asset(
        // 'assets/images/img_9.png',
        // color: Colors.black,
        // height: 35,
        // width: 35,
        // ),
        // Image.asset(
        // 'assets/images/img_6.png',
        // height: 25,
        // width: 25,
        // ),
        // Image.asset(
        // 'assets/images/img_7.png',
        // height: 25,
        // width: 25,
        // ),
        // ],
        // color: navBarColor,
        // buttonBackgroundColor: secondaryColor,
        // backgroundColor: Colors.white,
        // animationCurve: Curves.easeInOut,
        // animationDuration: const Duration(milliseconds: 600),
        // onTap: (index) {
        // setState(() {
        // _page = index;
        // print(index);
        // });
        // },
        // letIndexChange: (index) => false,
        // ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(190, 140, 206, 1),
          onPressed: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => MainScreen(pagep: 1),
              ),
            );
          },
          child: Icon(
            Icons.map_outlined,
          ),
        ),
      ),
    );
  }
}
