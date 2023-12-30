import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sevin_rm/data/models/filter/filters_model.dart';

import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../util/app_them.dart';
import '../HomeScreen/Home.dart';
import '../booking/selectingBooking.dart';
import '../conset/Const.dart';
import '../login/login.dart';

class FilterResultScreen extends StatefulWidget {
  const FilterResultScreen({Key? key, required this.filtersModel})
      : super(key: key);
  final FiltersModel? filtersModel;
  @override
  State<FilterResultScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<FilterResultScreen> {
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
  void initState() {}

  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Filter',
          style: TextStyle(
              color: Color1, fontSize: 22, fontWeight: FontWeight.w700),
        ),
        // leading: Ico,
        iconTheme: IconThemeData(
          color: Colors.purple
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Stack(
          children: [
            Transform.scale(
              //
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
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Results found (${widget.filtersModel!.data.length})",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: primaryColor,
                          )),
                      SizedBox(
                        height: 15,
                      ),

                      Container(
                        height:
                        MediaQuery.of(context).size.height * 0.9,
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
                                          stableId: widget.filtersModel!
                                              .data[i].id ??0,
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
                                                        BorderRadius.circular(
                                                            15.sp),
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: AssetImage(
                                                              'assets/images/main/stables${i}.jpg',
                                                            ))),

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
                                                                widget.filtersModel!
                                                                    .data[i].name
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color:
                                                                    Colors.black87,
                                                                    fontSize: 18.sp,
                                                                    overflow: TextOverflow.ellipsis),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 100
                                                                  .sp,
                                                              child:
                                                              Text(
                                                                widget.filtersModel!
                                                                    .data[i].description
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color:
                                                                    Colors.black45,
                                                                    fontSize: 13.sp,
                                                                    overflow: TextOverflow.ellipsis),
                                                              ),
                                                            ),
                                                            // Row(
                                                            //   children: [
                                                            //     Icon(
                                                            //       Icons.star,
                                                            //       color: Colors
                                                            //           .yellow,
                                                            //     ),
                                                            //     Text(
                                                            //       "3.2",
                                                            //       style: TextStyle(
                                                            //           color: Colors
                                                            //               .black54,
                                                            //           fontSize:
                                                            //               15),
                                                            //     ),
                                                            //     SizedBox(
                                                            //         width: 88),
                                                            //   ],
                                                            // ),
                                                            // Row(
                                                            //   crossAxisAlignment:
                                                            //       CrossAxisAlignment
                                                            //           .start,
                                                            //   children: [
                                                            //     Text(
                                                            //       "8:30 am-9:00 pm",
                                                            //       style: TextStyle(
                                                            //           color:
                                                            //               Color1,
                                                            //           fontSize:
                                                            //               14),
                                                            //     ),
                                                            //     SizedBox(
                                                            //         width: 12),
                                                            //   ],
                                                            // ),
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
                                                                        "1.2 ",
                                                                        style: TextStyle(
                                                                            color: Colors.black45,
                                                                            fontSize: 13,overflow: TextOverflow.ellipsis),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "km",
                                                                      style: TextStyle(
                                                                        color: Colors.black45,
                                                                        fontSize: 13,),
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
                                                                          stableId: widget.filtersModel!
                                                                              .data[i].id ??0,

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
                          itemCount:  widget.filtersModel!
                              .data.length ,
                          // widget.dataIncludeCategory?.stables.length,
                        ),
                      ),
                      // Container(
                      //   height: MediaQuery.of(context).size.height * 0.9,
                      //   child: ListView.builder(
                      //     scrollDirection: Axis.vertical,
                      //     itemBuilder: (_, i) {
                      //       return Stack(
                      //         children: [
                      //           FittedBox(
                      //             child: Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Row(
                      //                   children: [
                      //                     Container(
                      //                       height: MediaQuery.of(context)
                      //                               .size
                      //                               .height /
                      //                           8,
                      //                       width: MediaQuery.of(context)
                      //                               .size
                      //                               .width /
                      //                           3,
                      //                       decoration: BoxDecoration(
                      //                         borderRadius:
                      //                             BorderRadius.circular(15),
                      //                       ),
                      //                       child: Image.asset(
                      //                         "assets/images/img_15.png",
                      //                         fit: BoxFit.fill,
                      //                       ),
                      //                     ),
                      //                     SizedBox(
                      //                         width: MediaQuery.of(context)
                      //                                 .size
                      //                                 .width /
                      //                             35),
                      //                     Row(
                      //                       children: [
                      //                         Column(
                      //                           crossAxisAlignment:
                      //                               CrossAxisAlignment.start,
                      //                           mainAxisAlignment:
                      //                               MainAxisAlignment.center,
                      //                           children: [
                      //                             Row(
                      //                               mainAxisAlignment:
                      //                                   MainAxisAlignment
                      //                                       .spaceBetween,
                      //                               children: [
                      //                                 Text(
                      //                                   widget.filtersModel!
                      //                                       .data[i].name
                      //                                       .toString(),
                      //                                   style: TextStyle(
                      //                                       color:
                      //                                           Colors.black87,
                      //                                       fontSize: 17),
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                             Text(
                      //                               widget.filtersModel!.data[i]
                      //                                   .gender
                      //                                   .toString(),
                      //                               style: TextStyle(
                      //                                   color: Colors.black45,
                      //                                   fontSize: 13),
                      //                             ),
                      //                             Row(
                      //                               children: [
                      //                                 Icon(
                      //                                   Icons.star,
                      //                                   color: Colors.yellow,
                      //                                 ),
                      //                                 Text(
                      //                                   "3.2",
                      //                                   style: TextStyle(
                      //                                       color:
                      //                                           Colors.black54,
                      //                                       fontSize: 15),
                      //                                 ),
                      //                                 SizedBox(width: 88),
                      //                               ],
                      //                             ),
                      //                             Row(
                      //                               crossAxisAlignment:
                      //                                   CrossAxisAlignment
                      //                                       .start,
                      //                               children: [
                      //                                 Text(
                      //                                   "8:30 am-9:00 pm",
                      //                                   style: TextStyle(
                      //                                       color: Color1,
                      //                                       fontSize: 14),
                      //                                 ),
                      //                                 SizedBox(width: 12),
                      //                               ],
                      //                             ),
                      //                           ],
                      //                         ),
                      //                         Column(
                      //                           mainAxisAlignment:
                      //                               MainAxisAlignment.start,
                      //                           children: [
                      //                             Row(
                      //                               children: [
                      //                                 Icon(
                      //                                   Icons.location_on,
                      //                                   color: Colors.black45,
                      //                                   size: 12,
                      //                                 ),
                      //                                 Text(
                      //                                   "1.2 km",
                      //                                   style: TextStyle(
                      //                                       color:
                      //                                           Colors.black45,
                      //                                       fontSize: 13),
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                             SizedBox(
                      //                                 height:
                      //                                     MediaQuery.of(context)
                      //                                             .size
                      //                                             .height /
                      //                                         30),
                      //                             OvalButton(
                      //                               text: 'Book',
                      //                               onPressed: () {},
                      //                             ),
                      //                           ],
                      //                         ),
                      //                       ],
                      //                     )
                      //                   ],
                      //                 ),
                      //                 SizedBox(
                      //                   height:
                      //                       MediaQuery.of(context).size.height /
                      //                           30,
                      //                 ),
                      //                 Divider(
                      //                   color: Color6,
                      //                   thickness: 0.8,
                      //                   height: 2,
                      //                   indent: 5,
                      //                   endIndent: 5,
                      //                 ),
                      //                 SizedBox(
                      //                   height:
                      //                       MediaQuery.of(context).size.height /
                      //                           30,
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       );
                      //     },
                      //     itemCount: widget.filtersModel!.data.length,
                      //
                      //     // widget.dataIncludeCategory?.stables.length,
                      //   ),
                      // )
                    ]),
              ),
            )
          ],
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
