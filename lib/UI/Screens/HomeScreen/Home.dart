import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/bloc_consumer.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sevin_rm/UI/Screens/HomeScreen/direction.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/stables/stables_information.dart';
import '../../InformationTrainer/profile.dart';
import '../booking/cubit/cubit.dart';
import '../booking/cubit/states.dart';
import '../component/Widght.dart';
import '../conset/Const.dart';
import 'Screens/Screen1.dart';
import 'Screens/Screen2.dart';
import 'Screens/Screen3.dart';

////
class Home extends StatefulWidget {
  int stableId;

  Home({Key? key, required this.stableId}) : super(key: key);

  @override
  State<Home> createState() => _W8State();
}

//////////////
class _W8State extends State<Home> {
  int _selectedButton = 0;
  List<bool> _isSelected = [true, false, false];
  StableInformationModel? stableInformationModel;
  void _makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) =>
          BookingCubitPage()..getStableInformation(stableId: widget.stableId),
      child: BlocConsumer<BookingCubitPage, BookingCubitPageStates>(
        listener: (BuildContext context, state) {
          if (state is GetStableInformationSuccessStates) {
            print(state.stableInformationModel.message);
            stableInformationModel = state.stableInformationModel;
            print(stableInformationModel);
          }

          // if(state is BookingAvailableTimesSuccess){
          //   print(state.bookingAvailableTimes.message);
          //   bookingAvailableTimes =state.bookingAvailableTimes;
          //   print(bookingAvailableTimes?.specialistsAvailableTimes.length);
          // }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(children: [
                if (stableInformationModel?.stableTrainer == null ||
                    stableInformationModel?.stableDetails == null ||
                    stableInformationModel?.stableDays == null ||
                    stableInformationModel?.stableImages == null) ...[
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/img.png'),
                            fit: BoxFit.fill)),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 7),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color1,
                        ),
                      ),
                    ),
                  )
                ] else ...[
                   Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.40,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, -6),
                        ),
                      ],
                    ),
                    // color: Colors.yellow,
                    child: Stack(children: [
                      Container(
                        child: Image.network(
                          stableInformationModel
                                  ?.stableDetails?.profileImage??
                              '',
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Image.asset(
                                'assets/images/main/7rmlogo.png',
                              ),
                            );
                          },
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ),
                      Scaffold(
                        backgroundColor: Colors.transparent,
                        appBar: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          leading: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              )),
                          actions: [
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/images/main/noun_bookmark_660526.png',
                                // fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: MediaQuery.of(context).size.height,
                              ),
                            ),
                          ],
                        ),
                        body: Column(children: [
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              height: 120.sp,
                              width: MediaQuery.of(context).size.width,
                              // color: Colors.yellow,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        height: 20.sp),
                                    text(
                                        title: stableInformationModel
                                                ?.stableDetails?.name ??
                                            '',
                                        color: Color3,
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w700),

                                    text(
                                        title: stableInformationModel
                                            ?.stableDetails?.description ??
                                            '',
                                        color: Color3,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700),
                                    // Container(
                                    //   width: MediaQuery.of(context).size.width,
                                    //   height: 33,
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.center,
                                    //     children: [
                                    //       Container(
                                    //         // width: MediaQuery.of(context).size.width,
                                    //         height: 21.3.h,
                                    //         child: Row(
                                    //           crossAxisAlignment:
                                    //               CrossAxisAlignment.center,
                                    //           mainAxisAlignment:
                                    //               MainAxisAlignment.center,
                                    //           children: [
                                    //             SmoothStarRating(
                                    //               borderColor: Colors.white,
                                    //               color: Color.fromRGBO(
                                    //                   228, 179, 67, 1),
                                    //               rating: rating,
                                    //               // isReadOnly: false,
                                    //               size: 20,
                                    //               filledIconData: Icons.star,
                                    //               halfFilledIconData:
                                    //                   Icons.star_border,
                                    //               defaultIconData:
                                    //                   Icons.star_border,
                                    //               starCount: 1,
                                    //               allowHalfRating: true,
                                    //               spacing: 2.0,
                                    //               onRatingChanged: (v) {
                                    //                 setState(() {
                                    //                   rating = v;
                                    //                 });
                                    //               },
                                    //             ),
                                    //             SizedBox(
                                    //               width: 3.w,
                                    //             ),
                                    //             Column(
                                    //               children: [
                                    //                 SizedBox(
                                    //                   height: 4.h,
                                    //                 ),
                                    //                 // stableInformationModel
                                    //                 //             ?.stableServices[
                                    //                 //                 0]
                                    //                 //             .
                                    //                 //             .length !=
                                    //                 //         0
                                    //                 //     ? text(
                                    //                 //         title: stableInformationModel
                                    //                 //                 ?.stableServices[
                                    //                 //                     0]
                                    //                 //                 .evaluations[
                                    //                 //                     0]
                                    //                 //                 .averageEvaluation ??
                                    //                 //             '',
                                    //                 //         color: Colors.white,
                                    //                 //         fontSize: 12,
                                    //                 //         fontWeight:
                                    //                 //             FontWeight.w400)
                                    //                 //     : text(
                                    //                 //         title: '0',
                                    //                 //         color: Colors.white,
                                    //                 //         fontSize: 12,
                                    //                 //         fontWeight:
                                    //                 //             FontWeight
                                    //                 //                 .w400),
                                    //               ],
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //       Spacer(),
                                    //       // GestureDetector(
                                    //       //   onTap: () {
                                    //       //     print("mohammed");
                                    //       //   },
                                    //       //   child: Container(
                                    //       //     width: 50,
                                    //       //     height: 26,
                                    //       //     alignment: Alignment.center,
                                    //       //     decoration: BoxDecoration(
                                    //       //       // color: Color.fromRGBO(190, 140, 206, 1),
                                    //       //       border: Border.all(
                                    //       //         color: Colors.white,
                                    //       //         width: 2.0,
                                    //       //       ),
                                    //       //       borderRadius:
                                    //       //           BorderRadius.circular(5),
                                    //       //     ),
                                    //       //     child: Text(
                                    //       //       "OPEN",
                                    //       //       textAlign: TextAlign.center,
                                    //       //       style: TextStyle(
                                    //       //           color: Colors.white,
                                    //       //           fontSize: 12,
                                    //       //           fontWeight:
                                    //       //               FontWeight.w700),
                                    //       //     ),
                                    //       //   ),
                                    //       // ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ]),
                            ),
                          ),
                        ]),
                      )
                    ]),
                  ),
                  //////////////////////////
                  Container(
                    height: MediaQuery.of(context).size.height * 0.80,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            // height: MediaQuery.of(context).size.height * 0.262,
                            color: Color.fromRGBO(90, 60, 98, 0.15),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    Container(
                                        height: 60.sp,
                                        // color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            HomeGesdector(
                                                nameImage: "ic_website",
                                                title: "Website",
                                                onTap: () {}),

                                            SizedBox(
                                              width: 20,
                                            ),
                                            HomeGesdector(
                                                nameImage: "ic_end_call",
                                                title: "Call",
                                                onTap: () {
                                                  _makePhoneCall(
                                                      '+97111111111');
                                                }),

                                            SizedBox(
                                              width: 20,
                                            ),
                                            HomeGesdector(
                                                nameImage: "noun_Map_2443283",
                                                title: "Direction",
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                               DirectionPage(
                                                                 latitude: double.parse(stableInformationModel?.stableDetails?.latitude ?? "25.113303" ) ,
                                                                 longitude: double.parse(stableInformationModel?.stableDetails?.longitude ?? "55.2548173" ) ,
                                                               )));
                                                }),

                                            SizedBox(
                                              width: 20,
                                            ),
                                            HomeGesdector(
                                                nameImage: "ic_share",
                                                title: "Share",
                                                onTap: () {
                                                  Share.share(
                                                      'Hello Welcome to 7RM',
                                                      subject:
                                                          'Welcome Message');
                                                }),

                                            // SizedBox(
                                            //   width: 20,
                                            // )
                                          ],
                                        )),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    stableInformationModel
                                                ?.stableTrainer.length ==
                                            0
                                        ? Container()
                                        : text(
                                            title: "Stable specialists",
                                            color: Color1,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                    stableInformationModel
                                                ?.stableTrainer.length ==
                                            0
                                        ? Container()
                                        : SizedBox(
                                            height: 10,
                                          ),
                                    stableInformationModel
                                                ?.stableTrainer.length ==
                                            0
                                        ? Container()
                                        : Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 88,
                                            child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: stableInformationModel
                                                      ?.stableTrainer.length ??
                                                  5,
                                              separatorBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      const SizedBox(
                                                width: 22,
                                              ),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return GestureDetector(
                                                  onTap: () {

                                                    Navigator.push(context,
                                                        MaterialPageRoute(builder: (context) {
                                                          return InformationProfile(

                                                            trainerId: stableInformationModel
                                                                ?.stableTrainer[index].id ?? 0,
                                                          );
                                                        }));
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Center(
                                                        child: Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              CircleAvatar(
                                                                radius: 28,
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                              Center(
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      50.0, // قم بتحديد عرض الصورة هنا
                                                                  height:
                                                                      50.0, // قم بتحديد ارتفاع الصورة هنا
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),

                                                                  child: Image
                                                                      .network(
                                                                    stableInformationModel
                                                                        ?.stableTrainer[index].userImage ??'',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    errorBuilder:
                                                                        (context,
                                                                            error,
                                                                            stackTrace) {
                                                                      return Center(
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/main/7rmlogo.png',
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                  //
                                                                ), //
                                                              ),
                                                            ]),
                                                      ),
                                                      text(
                                                          title:
                                                              '${stableInformationModel?.stableTrainer[index].firstName ?? ''} ${stableInformationModel?.stableTrainer[index].lastName ?? ''}',
                                                          color: Color.fromRGBO(
                                                              90, 60, 98, 1),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),

                                                      ////////////////////////////
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                    // SizedBox(
                                    //   height: 40,
                                    // ),
                                  ]),
                            ),
                          ),
                          /////////////////////
                          Container(
                            height: 800.sp,
                            // color: Colors.pink,
                            child: DefaultTabController(
                                length: 3,
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.312,
                                    // color: Colors.pink,
                                    child: Column(children: [
                                      Container(
                                        color: Color.fromRGBO(90, 60, 98, 0.15),
                                        child: TabBar(
                                          labelColor:
                                              Color.fromRGBO(90, 0, 114, 1),
                                          indicatorColor:
                                              Color.fromRGBO(90, 0, 114, 1),
                                          unselectedLabelColor:
                                              Color.fromRGBO(5, 0, 0, 0.5),
                                          tabs: [
                                            Tab(text: 'About'),
                                            Tab(text: 'Services'),
                                            Tab(text: 'Gallery'),
                                            // Tab(text: 'Review'),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                          children: [
                                            // Center(child: Text('محتوى تصنيف 3')),
                                            // Center(child: Text('محتوى تصنيف 3')),
                                            // Center(child: Text('محتوى تصنيف 3')),
                                            state
                                                    is GetStableInformationSuccessStates
                                                ? Screen1(
                                                    stableInfoModel:
                                                        stableInformationModel,
                                                    stableId: widget.stableId,
                                                  )
                                                : Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                    color: Color10,
                                                  )),
                                            state
                                                    is GetStableInformationSuccessStates
                                                ? Screen2(
                                                    stableInfoModel:
                                                        stableInformationModel,
                                            stableId: widget.stableId,
                                            )
                                                : Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                    color: Color10,
                                                  )),
                                            state
                                                    is GetStableInformationSuccessStates
                                                ? Screen3(
                                                    stableInfoModel:
                                                        stableInformationModel)
                                                : Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                    color: Color10,
                                                  )),
                                            // state
                                            // is GetStableInformationSuccessStates
                                            //     ? Screen4(
                                            //     stableInfoModel:
                                            //     stableInformationModel)
                                            //     : Center(
                                            //     child:
                                            //     CircularProgressIndicator(
                                            //       color: Color10,
                                            //     )),
                                          ],
                                        ),
                                      ),
                                    ]))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /////////////////
                  SizedBox(
                    height: 60.sp,
                    child: Container(color: Colors.transparent),
                  )
                ],
              ]),
            ),
          );
        },
      ),
    ));
  }
}
