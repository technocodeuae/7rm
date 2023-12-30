import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Core/di/di_manager.dart';
import '../../../../Core/shared_prefs/shared_prefs.dart';
import '../../../../data/models/stables/stables_information.dart';
import '../../booking/selectingBooking.dart';
import '../../component/Widght.dart';
import '../../login/login.dart';

class Screen1 extends StatefulWidget {
  const Screen1({Key? key, this.stableInfoModel, this.stableId})
      : super(key: key);
  final StableInformationModel? stableInfoModel;
  final int? stableId;
  @override
  State<Screen1> createState() => _Screen1State();
}

//
//////////
class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    int? length = widget.stableInfoModel?.stableDays.length;
    String? apiOpenText =
        widget.stableInfoModel?.stableDetails?.openAt ?? "00:00:00";
    List<String>? parts = apiOpenText?.split(':');
    String extractedOpenText = "${parts?[0]}:${parts?[1]}";
    String? apiCloseText =
        widget.stableInfoModel!.stableDetails?.closeAt ?? "00:00:00";
    List<String>? partsC = apiCloseText?.split(':');
    String extractedCloseText = "${partsC?[0]}:${partsC?[1]}";
    // print(extractedCloseText);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/main/image 12.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(
                        title: "About",
                        color: Color.fromRGBO(90, 0, 114, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    text(
                        title: widget.stableInfoModel?.stableDetails
                                ?.description ??
                            '',
                        color: Color.fromRGBO(0, 0, 0, 0.54),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    SizedBox(
                      height: 6,
                    ),
                    widget.stableInfoModel!.stableDays.length != 0
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  text(
                                      title: "Opening Hours",
                                      color: Color.fromRGBO(90, 0, 114, 1),
                                      textAlign: TextAlign.start,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Container(
                                // height: MediaQuery.of(context).size.height / 7,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (_, i) {
                                    return Transform.translate(
                                      offset: Offset(0, -25),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 4,
                                            backgroundColor: Color.fromRGBO(
                                                190, 140, 206, 1),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Container(
                                            width: 180.w,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  // width: MediaQuery.of(context).size.width *
                                                  //     0.38,
                                                  // height:
                                                  //     MediaQuery.of(context).size.height *
                                                  //         0.03,
                                                  child: text(
                                                      title: widget
                                                              .stableInfoModel!
                                                              .stableDays[i] ??
                                                          "",
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 0.54),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                extractedOpenText != "00:00"
                                                    ? text(
                                                        title: extractedOpenText +
                                                                " - " +
                                                                extractedCloseText ??
                                                            "",
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400)
                                                    : Container(),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount:
                                      widget.stableInfoModel!.stableDays.length,

                                  // widget.dataIncludeCategory?.stables.length,
                                ),
                              ),
                            ],
                          )
                        : Container(),

                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.008,
                    // ),
                    // Row(
                    //   children: [
                    //     CircleAvatar(
                    //       radius: 4,
                    //       backgroundColor: Color.fromRGBO(190, 140, 206, 1),
                    //     ),
                    //     SizedBox(
                    //       width: 4,
                    //     ),
                    //     Container(
                    //       width: MediaQuery.of(context).size.width * 0.38,
                    //       height: MediaQuery.of(context).size.height * 0.03,
                    //       child: text(
                    //           title: "Saturday - Sunday",
                    //           color: Color.fromRGBO(0, 0, 0, 0.54),
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w400),
                    //     ),
                    //     SizedBox(
                    //       width: 50,
                    //     ),
                    //     text(
                    //         title: "9:00 AM - 1:00PM",
                    //         color: Colors.black,
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.w400),
                    //   ],
                    // ),
                    // // Row(
                    //   children: [Text("data")],
                    // ),
                    Container(
                      height: 100,
                      // color: Colors.grey,
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                text(
                                    title: "Address",
                                    color: Color.fromRGBO(90, 0, 114, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                                SizedBox(
                                  height: 10,
                                ),
                                text(
                                    title: "57G5+46R - Dubai",
                                    color: Color.fromRGBO(0, 0, 0, 0.54),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.send,
                                      color: Color.fromRGBO(90, 0, 114, 1),
                                    ),
                                    text(
                                        title: "  Get directions ~ 4.2 km",
                                        color: Color.fromRGBO(90, 0, 114, 1),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * .080),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          text(
                              title: "Photos",
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                          Spacer(),
                          // text(
                          //     title: "View all",
                          //     color: Color.fromRGBO(90, 0, 114, 1),
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.w400),
                        ],
                      ),
                    ),
                    Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              widget.stableInfoModel!.stableImages.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(
                            width: 5,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(),
                              child: Image.network(
                                widget.stableInfoModel?.stableImages[index].toString()
                                         ??
                                    'assets/images/main/7rmlogo.png',
                                fit: BoxFit.fill,
                                errorBuilder: (BuildContext context,
                                    Object error, StackTrace? stackTrace) {
                                  return Image.asset(
                                      'assets/images/main/7rmlogo.png',
                                      fit: BoxFit.fill);
                                },
                              ),
                              //
                            );
                          },
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              if (DIManager.findDep<SharedPrefs>().getToken() !=
                                  null) {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        BookingScreen(
                                            stableId: widget.stableId ?? 0),
                                  ),
                                );
                              } else {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => LoginW(),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.80,
                              height: 50.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(90, 0, 114, 1),
                                    Color.fromRGBO(90, 0, 114, 1)
                                    // const Color(0xFFFF80AB), // زهري فاتح
                                    // const Color(0xFFFF4081), // زهري غامق
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(90, 0, 114, 1)
                                        .withOpacity(0.5),
                                    spreadRadius: 2.0,
                                    blurRadius: 10.0,
                                    offset: Offset(-1, 6),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "Book now",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
