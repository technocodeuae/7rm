import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_bloc/src/bloc_consumer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sevin_rm/UI/Screens/main_screen/main_screen.dart';

import '../../../data/models/booking/booking_user_stable.dart';
import '../../../helper/snack_bar_helper.dart';
import '../../../main.dart';
import '../../util/app_them.dart';
import '../booking/cubit/cubit.dart';
import '../booking/cubit/states.dart';
import '../conset/Const.dart';

class BookingPackagesPage extends StatefulWidget {
  BookingPackagesPage({
    super.key,
    required this.stableId,
    required this.packageId,
  });

  int? stableId;
  int? packageId;

  @override
  State<BookingPackagesPage> createState() => _BookingPackagesPageState();
}

BookingUserInStableModel? bookingUserInStableModel;
List<bool> checkedItems = List.generate(
    bookingUserInStableModel?.userBookings.length ?? 3, (index) => false);
int? selectedRadio;
int? selectedBooking;

class _BookingPackagesPageState extends State<BookingPackagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color1,
      ),
      body: BlocProvider(
        create: (context) => BookingCubitPage()
          ..bookingUserInStable(stableId: widget.stableId ?? 0),
        child: BlocConsumer<BookingCubitPage, BookingCubitPageStates>(
          listener: (BuildContext context, state) {
            if (state is BookingUserInStableSuccess) {
              print("state.bookingUserInStableModel.userBookings[0].bookingId");
              // print(state.bookingUserInStableModel.userBookings[0].stableName);
              bookingUserInStableModel = state.bookingUserInStableModel;
            }

            if (state is BookingPackageSuccess) {
              countinueApp();
            }

            if (state is BookingPackageError) {
              SnackBarHelper.mySnackBar(state.error.toString(), context);
            }
          },
          builder: (BuildContext context, state) {
            if (state is BookingUserInStableLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Color1,
                ),
              );
            }
            return bookingUserInStableModel?.userBookings.length == 0
                ? Center(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sorry you Don't have any booking in Stable",
                            style: TextStyle(
                                color: Color1,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {

                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                                  return MainScreen();

                                }), (route) => false);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.80,
                                height: 50.sp,
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
                                    "Go to Booking",
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
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50.sp,
                        ),
                        Text('Chose one booking from your last bookings',
                            style: TextStyle(color: Color1, fontSize: 18.sp)),
                        SizedBox(
                          height: 12.sp,
                        ),
                        Container(
                            height: 500.sp,
                            decoration: BoxDecoration(
                              color: Color1.withOpacity(.8),
                              borderRadius: BorderRadius.circular(30.sp),
                            ),
                            child: ListView.builder(
                              itemCount: bookingUserInStableModel
                                      ?.userBookings.length ??
                                  0,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.all(15.sp),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius:
                                          BorderRadius.circular(30.sp),
                                    ),
                                    child: RadioListTile(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 12.sp,
                                          ),
                                          Text(
                                            bookingUserInStableModel
                                                    ?.userBookings[index]
                                                    .stableName ??
                                                '',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            bookingUserInStableModel
                                                    ?.userBookings[index]
                                                    .stableServiceName ??
                                                '',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            "${bookingUserInStableModel?.userBookings[index].specialistFirstName ?? ''} ${bookingUserInStableModel?.userBookings[index].specialistSecondName ?? ''}",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            bookingUserInStableModel
                                                    ?.userBookings[index]
                                                    .bookingDate
                                                    .toString() ??
                                                '',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      // selectedTileColor: Colors.black,
                                      value: index,
                                      groupValue: selectedRadio,
                                      onChanged: (int? value) {
                                        setState(() {
                                          selectedRadio = value;
                                          selectedBooking =
                                              bookingUserInStableModel
                                                  ?.userBookings[index]
                                                  .bookingId;
                                          print(selectedBooking);
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                            )),
                        SizedBox(
                          height: 50.sp,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              print(widget.stableId);
                              print(widget.stableId);
                              print(widget.packageId);
                              print(widget.stableId);
                              BookingCubitPage.get(context).bookingPackages(
                                  stableId: widget.stableId ?? 0,
                                  packageId: widget.packageId ?? 0,
                                  bookingId: selectedBooking ?? 0);
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
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  countinueApp() {
    var d = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.all(20),
      content: Container(
        height: 330.sp,
        width: 260.sp,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40.sp,
              backgroundColor: primaryColor.withOpacity(0.5),
              child: Icon(
                Icons.done_rounded,
                size: 50,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Text(
              "Your package booking \n is successfully",
              style: TextStyle(
                  fontSize: 20.sp,
                  color: primaryColor,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.sp,
            ),
            Text(
              "You can view your package info \n in the \"Appointment\" Section",
              style: TextStyle(fontSize: 15.sp, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.sp,
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
                child: const Text('Done',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (_) => d);
  }
}
