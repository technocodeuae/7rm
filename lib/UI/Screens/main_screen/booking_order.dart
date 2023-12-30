import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sevin_rm/data/sources/endpoints/endpoints.dart';

import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../../data/models/booking/all_booking.dart';
import '../../util/app_them.dart';
import '../component/Widght.dart';
import '../conset/Const.dart';
import '../login/login.dart';

class BookingOrderPage extends StatefulWidget {
  bool fromProfile;
  AllBookingModel? allBookingModel;
  BookingOrderPage(
      {super.key, required this.fromProfile, required this.allBookingModel});

  @override
  State<BookingOrderPage> createState() => _BookingOrderPageState();
}

class _BookingOrderPageState extends State<BookingOrderPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 9000.0);
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.allBookingModel?.message);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Booking',
          style: TextStyle(
              color: Color1, fontSize: 22, fontWeight: FontWeight.w700),
        ),
        leading: widget.fromProfile
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 30.sp,
                  color: primaryColor,
                ))
            : Container(),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/img.png',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
          ),
          if (DIManager.findDep<SharedPrefs>().getToken() != null) ...[
            if (widget.allBookingModel == null) ...[
              Center(
                child: CircularProgressIndicator(
                  color: Color1,
                ),
              ),
            ] else ...[
              if (widget.allBookingModel!.userBookings.length != 0) ...[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      controller: _scrollController,
                      reverse: widget.allBookingModel!.userBookings.length < 7
                          ? false
                          : true,
                      physics: BouncingScrollPhysics(),
                      itemCount: widget.allBookingModel?.userBookings.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          // height: 130,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0x80BE8FFF),
                                    blurRadius: 5,
                                    offset: Offset(3, 5))
                              ]),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100.h,
                                height: 100.h,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  //dataBestStables!.stables!
//////
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                child: Image.network(
                                  '${AppEndpoints.baseUrl}${widget.allBookingModel?.userBookings[index].profileImage ?? 'assets/images/main/7rmlogo.png'}',
                                  fit: BoxFit.fill,
                                  errorBuilder: (BuildContext context,
                                      Object error, StackTrace? stackTrace) {
                                    return Image.asset(
                                        'assets/images/main/7rmlogo.png',
                                        fit: BoxFit.fill);
                                  },
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget
                                                  .allBookingModel
                                                  ?.userBookings[index]
                                                  .stableServiceName ??
                                              '',
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                        Text(
                                          '${widget.allBookingModel?.userBookings[index].stableName}',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          widget
                                                  .allBookingModel
                                                  ?.userBookings[index]
                                                  .bookingDate ??
                                              '',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          'Payment Method : ${widget.allBookingModel?.userBookings[index].paymentMethod}',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          'Trainer : ${widget.allBookingModel?.userBookings[index].specialistFirstName ?? 'Not Choose'} ${widget.allBookingModel?.userBookings[index].specialistSecoundName ?? ''}',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          'Price : ${widget.allBookingModel?.userBookings[index].stableServicePrice ?? ''} AED',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          maxLines: 1,
                                        ),
                                        if (widget
                                            .allBookingModel!
                                            .userBookings[index]
                                            .packages
                                            .isNotEmpty) ...[
                                          Container(
                                            width: 220.sp,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Spacer(),
                                                Center(
                                                  child: InkWell(
                                                    onTap: () {
                                                      countinueApp(
                                                          name: widget
                                                                  .allBookingModel!
                                                                  .userBookings[
                                                                      index]
                                                                  .packages[0]
                                                                  .packageName ??
                                                              '',
                                                          dec: widget
                                                                  .allBookingModel!
                                                                  .userBookings[
                                                                      index]
                                                                  .packages[0]
                                                                  .packageDescription ??
                                                              '');
                                                      // showDialog(
                                                      //   context: context,
                                                      //   builder: (BuildContext context) {
                                                      //     return AlertDialog(
                                                      //       title: Text('Your Package in Booking'),
                                                      //       content: Container(
                                                      //         height: 80.sp,
                                                      //         child: Column(
                                                      //           crossAxisAlignment: CrossAxisAlignment.start,
                                                      //           children: [
                                                      //
                                                      //             SizedBox(
                                                      //               height: 12.sp,
                                                      //             ),
                                                      //             Text(widget.allBookingModel!.userBookings[index].packages[0].packageName ?? ''),
                                                      //             Text(widget.allBookingModel!.userBookings[index].packages[0].packageDescription ?? ''),
                                                      //             // Container(
                                                      //             //   height: 50.sp,
                                                      //             //   child: DropdownButton<String>(
                                                      //             //     value: selectedValue,
                                                      //             //     onChanged: (String? value) {
                                                      //             //       // يتم استدعاء هذه الدالة عند اختيار قيمة من القائمة
                                                      //             //       setState(() {
                                                      //             //         selectedValue = value!;
                                                      //             //       });
                                                      //             //     },
                                                      //             //     items: items.map((String item) {
                                                      //             //       return DropdownMenuItem<String>(
                                                      //             //         value: item,
                                                      //             //         child: Text(item),
                                                      //             //       );
                                                      //             //     }).toList(),),
                                                      //             // )
                                                      //           ],
                                                      //         ),
                                                      //       ),
                                                      //
                                                      //       actions: [
                                                      //         TextButton(
                                                      //           onPressed: () {
                                                      //             // قم بإغلاق النافذة عند الضغط على زر معين (مثل "موافق")
                                                      //             Navigator.of(context).pop();
                                                      //           },
                                                      //           child: Text('موافق'),
                                                      //         ),
                                                      //       ],
                                                      //     );
                                                      //   },
                                                      // );
                                                    },
                                                    child: Container(
                                                      width: 90.sp,
                                                      height: 20.sp,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.0),
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color.fromRGBO(
                                                                90, 0, 114, 1),
                                                            Color.fromRGBO(
                                                                90, 0, 114, 1)
                                                            // const Color(0xFFFF80AB), // زهري فاتح
                                                            // const Color(0xFFFF4081), // زهري غامق
                                                          ],
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Color
                                                                    .fromRGBO(
                                                                        90,
                                                                        0,
                                                                        114,
                                                                        1)
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 2.0,
                                                            blurRadius: 10.0,
                                                            offset:
                                                                Offset(-1, 6),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Show package",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.sp,
                                          ),
                                        ] else
                                          ...[]
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ] else ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "No Result",
                        style: TextStyle(fontSize: 25.sp),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    // Container(
                    //   width: 100.w,
                    //   child:
                    //
                    //   ButtonStaic(
                    //       onTap: () {
                    //         Navigator.push<void>(
                    //           context,
                    //           MaterialPageRoute<void>(
                    //             builder: (BuildContext context) =>  LoginW(),
                    //           ),
                    //         );
                    //       },
                    //       title: "Go to Login",
                    //       fontSize: 14.sp,
                    //       colorText: Colors.white,
                    //       fontWeight: FontWeight.w400,
                    //       heightContainer: 48,
                    //       widthContainer: 80.w ),
                    // )
                  ],
                ),
              ]
            ],
          ] else ...[
            Column(
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
            ),
          ]
        ],
      ),
    );
  }

  countinueApp({
    required String name,
    required String dec,
  }) {
    var d = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.all(20),
      content: Container(
        height: 300.sp,
        width: 260.sp,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: primaryColor.withOpacity(0.5),
              child: Icon(
                Icons.done_rounded,
                size: 50,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: TextStyle(
                  fontSize: 20,
                  color: primaryColor,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              dec,
              style: TextStyle(fontSize: 15, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 280.sp,
                height: 44.sp,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0), color: Color1),
                // onPressed: () {},
                child: Text('Done',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
                // style: ElevatedButton.styleFrom(
                //     backgroundColor: secondaryColor,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(25)),
                //     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10)),
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            // InkWell(
            //   onTap: (){
            //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
            //       return BookingOrderPage(fromProfile: false, allBookingModel: null,);
            //     }), (route) => false);
            //   },
            //   child: Text(
            //     "Go to appointment",
            //     style: TextStyle(fontSize: 15, color: Colors.black54),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (_) => d);
  }
}
