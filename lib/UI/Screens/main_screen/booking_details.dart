import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/bloc_consumer.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sevin_rm/UI/Screens/conset/Const.dart';

import '../../../data/models/booking/booking_availabel_times.dart';
import '../../../helper/snack_bar_helper.dart';
import '../../../main.dart';
import '../../util/app_them.dart';
import '../booking/cubit/cubit.dart';
import '../booking/cubit/states.dart';

class BookingDetials extends StatefulWidget {
  String? dateTime;
  int? servicesId;
  int? stableId;
  int? specialistId;
  String? hoursTime;
  String? pricePackage;

  BookingAvailableTimes? bookingAvailableTimes;
  BookingDetials(
      {Key? key,
      required this.bookingAvailableTimes,
      required this.dateTime,
      required this.pricePackage,
      required this.stableId,
      required this.servicesId,
      required this.hoursTime,
      required this.specialistId})
      : super(key: key);

  @override
  State<BookingDetials> createState() => _BookingDetialsState();
}

class _BookingDetialsState extends State<BookingDetials> {
  List payment = ["Credit Card", "Cash"];
  List paymentMethod = ["Credit Card", "Cash"];
  String currentPayment = "";

  DateTime parseDateTime(String dateString, String timeString) {
    String combinedString = '$dateString $timeString';
    DateTime parsedDateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').parse(combinedString);
    return parsedDateTime;
  }

  String formatDateTime(DateTime dateTime) {
    String formattedDateTime =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime);
    return formattedDateTime;
  }

  String formatDateTime2(DateTime dateTime) {
    String formattedDateTime =
        DateFormat('EEEE, dd MMMM yyyy @ h:mm a').format(dateTime);
    return formattedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    // print(payment2.contains('Credit Card'));
    print('dateTime: ${widget.dateTime}');
    print('servicesId: ${widget.servicesId}');
    print('stableId: ${widget.stableId}');
    print('specialistId: ${widget.specialistId}');
    print('hoursTime: ${widget.hoursTime}');
    DateTime dateTime =
        parseDateTime(widget.dateTime ?? '', widget.hoursTime ?? '');
    String formattedDateTime = formatDateTime(dateTime);
    print('Formatted DateTime: $formattedDateTime');

    String formattedDateTime2 = formatDateTime2(dateTime);
    print('Formatted DateTime: $formattedDateTime2');
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.fill,
        )),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.h,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
              Center(
                child: Text(
                  'Booking Details',
                  style: TextStyle(
                      fontSize: 20, color: primaryColor.withOpacity(0.6)),
                ),
              ),
              SizedBox(
                height: 20.sp,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Row(
                  children: [
                    Container(
                      height: 120.sp,
                      width: 100.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                      child: Image.network(
                        widget.bookingAvailableTimes?.stable[0].profileImage ??
                            'assets/images/main/7rmlogo.png',
                        fit: BoxFit.fill,
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return Image.asset('assets/images/main/7rmlogo.png',
                              fit: BoxFit.fill);
                        },
                        //
                      ),
                    ),
                    SizedBox(
                      width: 12.sp, //
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: Text(
                                  widget.bookingAvailableTimes?.stable[0]
                                          .name ??
                                      '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_rate,
                                    color: Colors.amber,
                                    size: 15,
                                  ),
                                  Text(
                                    widget.bookingAvailableTimes?.stable[0]
                                            .evaluations[0].averageEvaluation
                                            .toString() ??
                                        '',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        overflow: TextOverflow.ellipsis),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.50,
                            // color: Colors.red,
                            child: Text(
                              widget.bookingAvailableTimes?.stable[0]
                                      .description ??
                                  '',
                              // maxLines: 1,
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                          ),
                          // TextButton.icon(
                          //     onPressed: () {},
                          //     icon: Icon(
                          //       Icons.location_on,
                          //       color: Colors.black,
                          //       size: 15,
                          //     ),
                          //     label: Text(
                          //       '1.2 Km',
                          //       style: TextStyle(
                          //           fontSize: 15, color: Colors.black),
                          //     )),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text(
                            'Open at : ${widget.bookingAvailableTimes?.stable[0].openAt}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            'Close at : ${widget.bookingAvailableTimes?.stable[0].closeAt}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Text(
                'Total : ${widget.pricePackage} AED',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87),
              ),
              SizedBox(
                height: 15.sp,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  // onPressed: () {},
                  height: 44.sp,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.sp),
                      color: Color.fromRGBO(190, 140, 206, 0.5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.date_range, color: Colors.black87),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        formattedDateTime2,
                        style:
                            TextStyle(fontSize: 15.sp, color: Colors.black87),
                      ),
                    ],
                  ),
                  // style: ElevatedButton.styleFrom(

                  //     // backgroundColor: secondaryColor,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(25)),
                  //     padding:
                  //         EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Payment Method',
                  style: TextStyle(fontSize: 19, color: Colors.black54),
                ),
                // Text(
                //   '+ Add a new card',
                //   style: TextStyle(color: Colors.black),
                // ),
              ]),
              Container(
                height: 250.sp,
                child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(15.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.sp),
                            border: Border.all(
                                color: currentPayment == paymentMethod[0]
                                    ? primaryColor.withOpacity(0.5)
                                    : Colors.black,
                                width: 1),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/visa.png',
                                height: 40,
                                width: 40,
                              ),
                              SizedBox(width: 20),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Credit/Debit Card',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      'Ending in 1560',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   width: 80,
                              // ),
                              Spacer(),
                              Radio(
                                  value: paymentMethod[0],
                                  activeColor: secondaryColor,
                                  groupValue: currentPayment,
                                  onChanged: (value) {
                                    setState(() {
                                      currentPayment = value;
                                    });
                                  })
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: currentPayment == paymentMethod[1]
                                    ? primaryColor.withOpacity(0.5)
                                    : Colors.black,
                                width: 1),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/cash.png',
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Cash in stable',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      'Ending in 9473',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              Radio(
                                  value: paymentMethod[1],
                                  activeColor: secondaryColor,
                                  groupValue: currentPayment,
                                  onChanged: (value) {
                                    setState(() {
                                      currentPayment = value;
                                      print(currentPayment);
                                    });
                                  })
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
              SizedBox(
                height: 25.h,
              ),
              BlocProvider(
                create: (context) => BookingCubitPage(),
                child: BlocConsumer<BookingCubitPage, BookingCubitPageStates>(
                  listener: (BuildContext context, state) {
                    if (state is AddOrderSuccess) {
                      countinueApp();
                    }
                    if (state is AddOrderError) {
                      // countinueApp();
                      SnackBarHelper.mySnackBar("Error", context);
                    }
                  },
                  builder: (BuildContext context, state) {
                    if (state is AddOrderLoading) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Color1,
                      ));
                    }

                    return Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          if (currentPayment != '') {
                            BookingCubitPage.get(context).addOrder(
                              stableId: widget.stableId ?? 1,
                              bookingDate: formattedDateTime,
                              paymentMethod: currentPayment,
                              specialistId: widget.specialistId ?? 1,
                              stableServiceId: widget.servicesId ?? 1,
                            );
                            // if(state is  AddOrderSuccess)
                            // {
                            //   countinueApp();
                            // }else{
                            //   SnackBarHelper.mySnackBar('error', context);
                            // }
                          } else {
                            SnackBarHelper.mySnackBar(
                                "You must choose a payment method", context);
                          }

                          // countinueApp();
                        },
                        child: Container(
                          height: 44.h,
                          width: 311.w,
                          // onPressed: () {
                          //   countinueApp();
                          // },
                          decoration: BoxDecoration(
                              color: Color1,
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                            child: Text('Continue with $currentPayment',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                          ),
                          // style: ElevatedButton.styleFrom(
                          //     // backgroundColor: secondaryColor,
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(25)),
                          //     padding:
                          //         EdgeInsets.symmetric(horizontal: 40, vertical: 10)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  countinueApp() {
    var d = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.all(20),
      content: Container(
        height: 330,
        width: 260,
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
              "Your appointment booking \n is successfully",
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
              "You can view the appointment booking info \n in the \"Appointment\" Section",
              style: TextStyle(fontSize: 15, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return MyApp();
                }), (route) => false);
                // Navigator.of(context).pop();
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
