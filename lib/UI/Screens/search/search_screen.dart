import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:google_maps_flutter_platform_interface/src/types/ui.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:sevin_rm/UI/InformationTrainer/profile.dart';
import 'package:sevin_rm/UI/Screens/search/cubit/cubit.dart';
import 'package:sevin_rm/UI/Screens/search/cubit/states.dart';
import 'package:sevin_rm/data/models/trainers/trainers_model.dart';
import 'package:sevin_rm/helper/Calculate_distance.dart';

import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../../helper/error_dialog_helper.dart';
import '../../../helper/snack_bar_helper.dart';
import '../../util/app_them.dart';
import '../HomeScreen/Home.dart';
import '../booking/selectingBooking.dart';
import '../conset/Const.dart';
import '../filter/filters.dart';
import '../login/login.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
//////
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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

  void initState() {
    super.initState();
    // SearchCubit().trainers();
  }

  AppHelper appHelper = AppHelper();
  TextEditingController search = TextEditingController();
  TrainersModel? trainers;
  String firstName = DIManager.findDep<SharedPrefs>().getUserNamePerson() ?? "";
  String lastName = DIManager.findDep<SharedPrefs>().getUserNamePerson2() ?? "";
  double? lat = DIManager.findDep<SharedPrefs>().getMyLocationLat();
  double? lang = DIManager.findDep<SharedPrefs>().getMyLocationLang();

  double distance = 0.0;

  void getDis(
      {required List list,
      required double latitude,
      required double longitude}) async {
    for (int i = 0; i < list.length; i++) {
      distance = await appHelper.calculateDistance(
          latitude: latitude, longitude: longitude);
      print("latitude :${latitude}");
      print("latitude :${latitude}");
      print(distance);
    }
    print(distance);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocProvider(
          create: (context) => SearchCubit()..trainers(),
          child: BlocConsumer<SearchCubit, SearchStates>(
            listener: (context, state) {
              if (state is ErrorStateSearch) {
                DialogHelper.errorDialog(context, "Error", state.error);
              }
              if (state is SuccessSearch) {
                SnackBarHelper.mySnackBar("search Success", context);
                (state.search.message);
                // print('تم النقر على الزر!');

                for (int i = 0; i < state.search.data.length; i++) {
                  getDis(
                      latitude: double.parse(state.search.data[i].latitude!),
                      list: state.search.data,
                      longitude:
                          double.parse(state.search.data[i].longitude!));
                }
                print(distance);
              }
              if (state is ErrorStateTrainer) {
                DialogHelper.errorDialog(context, "Error", state.error);
              }
              if (state is SuccessTrainer) {
                SnackBarHelper.mySnackBar("trainers Success", context);
                trainers = state.trainers;

              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  Transform.scale(
                    scale: 1.05,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/images/img.png',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Hello, $firstName $lastName",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700)),
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
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  )),
                              TextButton.icon(
                                  onPressed: () async {
                                    showBottomSheet(
                                        context: context,
                                        builder: (context) => Container(
                                              height: 500,
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
                                                      lat = value.geometry
                                                          ?.location.lat;
                                                      lang = value.geometry
                                                          ?.location.lng;
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
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 42,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0.0001),
                          child: TextFormField(
                            onFieldSubmitted: (v) {
                              context.read<SearchCubit>().search(
                                    search.text,
                                  );
                            },
                            controller: search,
                            decoration: InputDecoration(
                                // contentPadding: EdgeInsets.all(5),
                                fillColor: secondaryColor,
                                filled: true,
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
                                // state is Loading
                                // ? Center(
                                // child: CircularProgressIndicator(
                                // color: Color1,
                                // ))
                                //     : ButtonStaic(
                                // onTap: () {
                                // // يتم تنفيذ هذا الكود عند النقر على الزر
                                // if (loginController.validateLogin(context)) {
                                // context.read<LoginCubit>().login(
                                // loginController.phone.text,
                                // loginController.password.text);
                                // }
                                // },

                                prefixIcon: state is LoadingSearch?
                                    ? Icon(Icons.search)
                                    : InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.search_rounded,
                                          color: Colors.black,
                                        ),
                                      ),
                                suffixIcon: const Icon(
                                  Icons.settings_voice_sharp,
                                  color: Colors.black,
                                ),
                                hintText: state is LoadingSearch
                                    ? "Loading ...."
                                    : "Search Flat race, Pony and Stable",
                                hintStyle: const TextStyle(
                                    fontSize: 14, color: Colors.black45)),
                          ),
                        ),
                         SizedBox(
                          height: 26.sp,
                        ),

                       const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Poplular artist",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: primaryColor,
                                )),
                            // Text("View all",
                            //     style: TextStyle(
                            //       fontSize: 14,
                            //     )),
                          ],
                        ),
                        Container(
                          height: 130.sp,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, i) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return InformationProfile(
                                      trainer: trainers?.data!.trainers[i],
                                      trainerId: trainers?.data!.trainers[i].id ?? 0,
                                    );
                                  }));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 70.sp,
                                      width: 70.sp,
                                      padding: const EdgeInsets.all(3),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Image.network(
                                        trainers?.data!.trainers[i].userImage ??
                                            'assets/images/main/7rmlogo.png',
                                        fit: BoxFit.fill,
                                        errorBuilder: (BuildContext context,
                                            Object error,
                                            StackTrace? stackTrace) {
                                          return Image.asset(
                                              'assets/images/main/7rmlogo.png',
                                            );
                                        },
                                      ),

                                      // child:
                                    ),
                                    Text(
                                      trainers?.data!.trainers[i].firstName ??'' ,
                                      style:  TextStyle(fontSize: 13.sp),
                                    )
                                  ],
                                ),
                              );
                            },
                            itemCount: trainers?.data!.trainers.length,
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
                        //                       padding: const EdgeInsets.all(3),
                        //                       margin: const EdgeInsets.symmetric(
                        //                           horizontal: 6, vertical: 15),
                        //                       decoration: BoxDecoration(
                        //                           color: Colors.white,
                        //                           shape: BoxShape.circle,
                        //                           border: Border.all(color: Colors.grey)),
                        //                       child: const CircleAvatar(
                        //                         backgroundImage: AssetImage(
                        //                             'assets/images/img_16.png'),
                        //                       )),
                        //                   Text(
                        //                     category[i]['text'],
                        //                     style: const TextStyle(fontSize: 13),
                        //                   )
                        //                 ],
                        //               ),
                        //             );
                        //           },
                        //           itemCount: category.length,
                        //         ),
                        //       )
                        //
                        //     : Container(),
                        state is SuccessSearch
                            ? Text(
                                "Results found (${state.search.data.length})",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: primaryColor,
                                ))
                            : Center(),

                        state is SuccessSearch
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.5,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (_, i) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push<void>(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                Home(
                                              stableId:
                                                  state.search.data[i].id ??
                                                      0,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.sp)),
                                                color: Colors.purple
                                                    .withOpacity(0.1)),
                                            child: Stack(
                                              children: [
                                                FittedBox(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            height: 140.sp,
                                                            width: 120.sp,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.sp),
                                                            ),

                                                            child:
                                                                Image.network(
                                                              state
                                                                      .search
                                                                      .data[
                                                                          i]
                                                                      .profileImage
                                                                      .toString() ??
                                                                  'assets/images/main/7rmlogo.png',
                                                              fit: BoxFit.fill,
                                                              errorBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      Object
                                                                          error,
                                                                      StackTrace?
                                                                          stackTrace) {
                                                                return Image.asset(
                                                                    'assets/images/main/7rmlogo.png',
                                                                    fit: BoxFit
                                                                        .fill);
                                                              },
                                                            ),

                                                            // child: Image.asset(
                                                            //   "assets/images/img_15.png",
                                                            //   fit: BoxFit.fill,
                                                            // ),
                                                          ),
                                                          SizedBox(
                                                              width: 10.sp),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 8
                                                                            .sp),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      width: 150
                                                                          .sp,
                                                                      child:
                                                                          Text(
                                                                        state
                                                                            .search
                                                                            .data[i]
                                                                            .name
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black87,
                                                                            fontSize: 18.sp,
                                                                            overflow: TextOverflow.ellipsis),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: 130.sp
                                                                          .sp,
                                                                      child:
                                                                          Text(
                                                                        state
                                                                            .search
                                                                            .data[i]
                                                                            .description
                                                                            .toString(),maxLines: 3,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black45,
                                                                            fontSize: 13.sp,
                                                                            overflow: TextOverflow.ellipsis),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                              Colors.yellow,
                                                                        ),
                                                                         Text(
                                                                          ////
                                                                             state
                                                                                 .search
                                                                                 .data[i]
                                                                                 .evaluations.isEmpty?"0":  state
                                                                              .search
                                                                              .data[i]
                                                                              .evaluations[0].averageEvaluation
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              color: Color1,
                                                                              fontSize: 14),
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                88),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          '${state.search.data[i].openAt.toString() ??''} - ${state.search.data[i].closeAt.toString()??''}',
                                                                          style: TextStyle(
                                                                              color: Colors.black54,
                                                                              fontSize: 15),
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                12),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                8.sp),
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .location_on,
                                                                          color:
                                                                              Colors.black45,
                                                                          size:
                                                                              12.sp,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Container(
                                                                              width: 30.sp,
                                                                              child: Text(
                                                                                "${distance.round()}",
                                                                                style: TextStyle(color: Colors.black45, fontSize: 13, overflow: TextOverflow.ellipsis),
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              "km",
                                                                              style: TextStyle(
                                                                                color: Colors.black45,
                                                                                fontSize: 13,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      height: 75
                                                                          .sp),
                                                                  OvalButton(
                                                                    text:
                                                                        'Book',
                                                                    onPressed:
                                                                        () {
                                                                      if (DIManager.findDep<SharedPrefs>()
                                                                              .getToken() !=
                                                                          null) {
                                                                        Navigator.push<
                                                                            void>(
                                                                          context,
                                                                          MaterialPageRoute<
                                                                              void>(
                                                                            builder: (BuildContext context) =>
                                                                                BookingScreen(
                                                                              stableId: state.search.data[i].id ?? 0,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        Navigator.push<
                                                                            void>(
                                                                          context,
                                                                          MaterialPageRoute<
                                                                              void>(
                                                                            builder: (BuildContext context) =>
                                                                                LoginW(),
                                                                          ),
                                                                        );
                                                                      }
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      // SizedBox(
                                                      //   height: MediaQuery.of(context)
                                                      //           .size
                                                      //           .height /
                                                      //       30,
                                                      // ),
                                                      // Divider(
                                                      //   color: Color6,
                                                      //   thickness: 0.8,
                                                      //   height: 2,
                                                      //   indent: 5,
                                                      //   endIndent: 5,
                                                      // ),
                                                      // SizedBox(
                                                      //   height: MediaQuery.of(context)
                                                      //           .size
                                                      //           .height /
                                                      //       30,
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.sp,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: state.search.data.length,
                                  // widget.dataIncludeCategory?.stables.length,
                                ),
                              )
                            : state is LoadingSearch
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: Color1,
                                    ),
                                  )
                                : Center()
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class OvalButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  OvalButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 4,
        primary: Colors.white,
        onPrimary: Colors.black,
        shadowColor: Colors.purple,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0.8),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

//Stack(
//           children: [
//             Image.asset(
//               'assets/images/img.png',
//               width: MediaQuery.of(context).size.width,
//               fit: BoxFit.cover,
//             ),
//             SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     width: double.infinity,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text("Hello, John Doe",
//                             style: TextStyle(
//                                 fontSize: 17, fontWeight: FontWeight.w700)),
//                         Container(
//                           child: Row(
//                             children: [
//                               IconButton(
//                                   onPressed: () {},
//                                   icon: const Icon(
//                                     Icons.notification_add_outlined,
//                                     color: primaryColor,
//                                   )),
//                               IconButton(
//                                   onPressed: () {},
//                                   icon: const Icon(
//                                     Icons.filter_alt,
//                                     color: primaryColor,
//                                   ))
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   const Text("Your location",
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Color(0x66000000),
//                       )),
//
//                   Container(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TextButton.icon(
//                             onPressed: () {},
//                             icon: const Icon(
//                               Icons.location_on,
//                               color: Colors.black,
//                             ),
//                             label: const Text(
//                               "Abu Dhabi",
//                               style:
//                                   TextStyle(fontSize: 12, color: Colors.black),
//                             )),
//                         TextButton.icon(
//                             onPressed: () {},
//                             icon: const Icon(
//                               CupertinoIcons.arrow_up_right_diamond,
//                               color: Colors.black,
//                             ),
//                             label: const Text(
//                               "CHANGE",
//                               style:
//                                   TextStyle(fontSize: 12, color: Colors.black),
//                             ))
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     height: 36,
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                           // contentPadding: EdgeInsets.all(5),
//                           fillColor: secondaryColor,
//                           filled: true,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: const BorderSide(color: secondaryColor),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide:
//                                   const BorderSide(color: secondaryColor)),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide:
//                                   const BorderSide(color: secondaryColor)),
//                           prefixIcon: const Icon(
//                             Icons.search_rounded,
//                             color: Colors.black,
//                           ),
//                           suffixIcon: const Icon(
//                             Icons.settings_voice_sharp,
//                             color: Colors.black,
//                           ),
//                           hintText: "Search Flat race, Pony and Stable",
//                           hintStyle: const TextStyle(
//                               fontSize: 14, color: Colors.black)),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 26,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("View all",
//                           style: TextStyle(
//                             fontSize: 14,
//                           )),
//                     ],
//                   ),
//                   Container(
//                     height: MediaQuery.of(context).size.height * 0.180,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemBuilder: (_, i) {
//                         return Container(
//                           child: Column(
//                             children: [
//                               Container(
//                                   height: 70,
//                                   width: 70,
//                                   padding: const EdgeInsets.all(3),
//                                   margin: const EdgeInsets.symmetric(
//                                       horizontal: 6, vertical: 15),
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       shape: BoxShape.circle,
//                                       border: Border.all(color: Colors.grey)),
//                                   child: const CircleAvatar(
//                                     backgroundImage:
//                                         AssetImage('assets/images/img_16.png'),
//                                   )),
//                               Text(
//                                 category[i]['text'],
//                                 style: const TextStyle(fontSize: 13),
//                               )
//                             ],
//                           ),
//                         );
//                       },
//                       itemCount: category.length,
//                     ),
//                   ),
//                   // trenner
//                   // selectService
//                   //     ? Container(
//                   //         height: 130,
//                   //         child: ListView.builder(
//                   //           scrollDirection: Axis.horizontal,
//                   //           itemBuilder: (_, i) {
//                   //             return Container(
//                   //               child: Column(
//                   //                 children: [
//                   //                   Container(
//                   //                       height: 60,
//                   //                       width: 60,
//                   //                       padding: const EdgeInsets.all(3),
//                   //                       margin: const EdgeInsets.symmetric(
//                   //                           horizontal: 6, vertical: 15),
//                   //                       decoration: BoxDecoration(
//                   //                           color: Colors.white,
//                   //                           shape: BoxShape.circle,
//                   //                           border: Border.all(color: Colors.grey)),
//                   //                       child: const CircleAvatar(
//                   //                         backgroundImage: AssetImage(
//                   //                             'assets/images/img_16.png'),
//                   //                       )),
//                   //                   Text(
//                   //                     category[i]['text'],
//                   //                     style: const TextStyle(fontSize: 13),
//                   //                   )
//                   //                 ],
//                   //               ),
//                   //             );
//                   //           },
//                   //           itemCount: category.length,
//                   //         ),
//                   //       )
//                   //     : Container(),
//                   Text("Results found (120)",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                         color: primaryColor,
//                       )),
//
//                   Container(
//                     height: MediaQuery.of(context).size.height / 1.5,
//                     child: ListView.builder(
//                       scrollDirection: Axis.vertical,
//                       itemBuilder: (_, i) {
//                         return Stack(
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Container(
//                                       height:
//                                           MediaQuery.of(context).size.height /
//                                               8,
//                                       width:
//                                           MediaQuery.of(context).size.width / 3,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(15),
//                                       ),
//                                       child: Image.asset(
//                                         "assets/images/img_15.png",
//                                         fit: BoxFit.fill,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                         width:
//                                             MediaQuery.of(context).size.width /
//                                                 35),
//                                     Row(
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   "Godohin Stables",
//                                                   style: TextStyle(
//                                                       color: Colors.black87,
//                                                       fontSize: 17),
//                                                 ),
//                                               ],
//                                             ),
//                                             Text(
//                                               "228 McCulur",
//                                               style: TextStyle(
//                                                   color: Colors.black45,
//                                                   fontSize: 13),
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Icon(
//                                                   Icons.star,
//                                                   color: Colors.yellow,
//                                                 ),
//                                                 Text(
//                                                   "3.5",
//                                                   style: TextStyle(
//                                                       color: Colors.black54,
//                                                       fontSize: 15),
//                                                 ),
//                                                 SizedBox(width: 88),
//                                               ],
//                                             ),
//                                             Row(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   "8:30 am-9:00 pm",
//                                                   style: TextStyle(
//                                                       color: Color1,
//                                                       fontSize: 14),
//                                                 ),
//                                                 SizedBox(width: 12),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                         Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Icon(
//                                                   Icons.location_on,
//                                                   color: Colors.black45,
//                                                   size: 12,
//                                                 ),
//                                                 Text(
//                                                   "1.2 km",
//                                                   style: TextStyle(
//                                                       color: Colors.black45,
//                                                       fontSize: 13),
//                                                 ),
//                                               ],
//                                             ),
//                                             SizedBox(
//                                                 height: MediaQuery.of(context)
//                                                         .size
//                                                         .height /
//                                                     30),
//                                             OvalButton(
//                                               text: 'Book',
//                                               onPressed: () {},
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height:
//                                       MediaQuery.of(context).size.height / 30,
//                                 ),
//                                 Divider(
//                                   color: Color6,
//                                   thickness: 0.8,
//                                   height: 2,
//                                   indent: 5,
//                                   endIndent: 5,
//                                 ),
//                                 SizedBox(
//                                   height:
//                                       MediaQuery.of(context).size.height / 30,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         );
//                       },
//                       itemCount: 10,
//                       // widget.dataIncludeCategory?.stables.length,
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
