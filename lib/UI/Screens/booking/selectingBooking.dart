import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sevin_rm/UI/Screens/main_screen/bloc/cubit.dart';

import '../../../data/models/booking/booking_availabel_times.dart';
import '../../../data/models/stables/stables_information.dart';
import '../../../helper/snack_bar_helper.dart';
import '../main_screen/booking_details.dart';
import '../../util/app_them.dart';

import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_bloc/src/bloc_consumer.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class BookingScreen extends StatefulWidget {
  int stableId;

  BookingScreen({
    Key? key,
    required this.stableId,
  }) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  List category = [
    {
      "image": "assets/images/img_10.png",
      "text": "Ability &",
    },
    {"image": "assets/images/img_11.png", "text": "Flat race"},
    {"image": "assets/images/img_12.png", "text": "Show horse"},
    {"image": "assets/images/img_13.png", "text": "Pony"},
    {"image": "assets/images/img_13.png", "text": "Pony"},
    {"image": "assets/images/img_13.png", "text": "Pony"},
    {"image": "assets/images/img_13.png", "text": "Pony"},
    {
      "image": "assets/images/img_14.png",
      "text": "Race",
    },
  ];
  bool p1 = true;

  @override
  void initState() {
    print(widget.stableId);
    // AppCubitMainPage().getStableInformation(stableId: widget.stableId);
    super.initState();
  }

  TextEditingController dateInput = TextEditingController();

  String dateTime = '';
  bool isSelect = false;
  List<bool> isSelectedList = List.generate(100, (index) => false);
  List<bool> isSelectedSpecialistsList = List.generate(100, (index) => false);
  List<bool> isSelectedAvailableList = List.generate(100, (index) => false);
  StableInformationModel? stableInformationModel;
  int? selectServices;
  BookingAvailableTimes? bookingAvailableTimes;
  bool isSelected = false;
  int? specialistID;
  String hoursTime = '';

  @override
  Widget build(BuildContext context) {
    print(widget.stableId);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/img.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          BlocProvider(
            create: (context) => BookingCubitPage()
              ..getStableInformation(stableId: widget.stableId),
            child: BlocConsumer<BookingCubitPage, BookingCubitPageStates>(
              listener: (BuildContext context, state) {
                if (state is GetStableInformationSuccessStates) {
                  print(state.stableInformationModel.message);
                  stableInformationModel = state.stableInformationModel;
                  print(stableInformationModel);
                }

                if (state is BookingAvailableTimesSuccess) {
                  print(state.bookingAvailableTimes.message);
                  bookingAvailableTimes = state.bookingAvailableTimes;
                  print(
                      bookingAvailableTimes?.specialistsAvailableTimes.length);
                }
              },
              builder: (BuildContext context, state) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBar(
                        leading: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Color(0xFF5A0072),
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        toolbarHeight: 30,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 40),
                        child: Text(
                          'Book Appointment',
                          style: TextStyle(
                            color: Color(0xFF23002C),
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 164,
                          height: 164,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/img_18.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          'Select your date',
                          style: TextStyle(
                            color: Color(0xFF23002C),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(boxShadow: <BoxShadow>[]),
                        margin: EdgeInsets.all(15),
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shadowColor: Colors.blueGrey,
                                minimumSize: const Size(311, 44),
                                elevation: 1,
                                primary: secondaryColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ))),
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                dateTime = formattedDate;
                                print(
                                    dateTime); //formatted date output using intl package =>  2021-03-16
                                setState(() {
                                  dateInput.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {}
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  dateTime == ''
                                      ? 'Select Date Time'
                                      : dateTime,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                  icon: Icon(
                                    Icons.date_range,
                                    color: primaryColor,
                                    size: 35,
                                  ),
                                  onPressed: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2100));

                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      //formatted date output using intl package =>  2021-03-16
                                      setState(() {
                                        dateInput.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                      dateTime = formattedDate;
                                      print(dateTime);
                                    } else {}
                                  },
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            stableInformationModel
                                        ?.stableServices.length ==
                                    0
                                ? Container()
                                : Text("Top services",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: primaryColor,
                                    )),
                          ],
                        ),
                      ),

                      stableInformationModel
                                  ?.stableServices.length ==
                              0
                          ? Container()
                          : Container(
                              height: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, i) {
                                  return Container(
                                    height: 79,
                                    width: 64,
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    decoration: BoxDecoration(
                                        color: !isSelectedList[i]
                                            ? Colors.white
                                            : primaryColor.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  primaryColor.withOpacity(0.5),
                                              blurRadius: 5,
                                              offset: Offset(0, 5))
                                        ]),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              print("LLLLLLLLLLLLLL");

                                              isSelectedList = List.generate(
                                                  stableInformationModel
                                                          ?.stableServices
                                                          .length ??
                                                      0,
                                                  (index) => false);
                                              // ثم قم بتحديث القيمة للعنصر الذي تم الضغط عليه إلى true
                                              isSelectedList[i] = true;
                                              isSelected = false;
                                              selectServices =
                                                  stableInformationModel
                                                          ?.stableServices[i].id??
                                                      0;
                                              print(selectServices);
                                              BookingCubitPage.get(context)
                                                  .bookingAvailableTimes(
                                                      dateTime ?? '', 1,
                                                      serviceId: selectServices!,
                                                      stableId:
                                                          widget.stableId);
                                              // BookingCubitPage.get(context).bookingAvailableTimes('2023-11-17',1,serviceId: 1,stableId: 4);
                                            });
                                          },
                                          child: Image.network(
                                            stableInformationModel
                                                    ?.stableServices[i]
                                                    .imagePath ??
                                                '',
                                            width: 40.sp,
                                            height: 40.sp,
                                            errorBuilder: (BuildContext context,
                                                Object error,
                                                StackTrace? stackTrace) {
                                              // If an error occurs while loading the image, show the fallback image
                                              return Image.asset(
                                                'assets/images/main/7rmlogo.png',
                                                width: 40.sp,
                                                height: 40.sp,
                                              );
                                            },
                                          ),
                                        ),
                                        Text(
                                            stableInformationModel
                                                    ?.stableServices[i]
                                                    .name ??
                                                '',
                                            style: const TextStyle(
                                                fontSize: 10,
                                                overflow:
                                                    TextOverflow.ellipsis))
                                      ],
                                    ),
                                  );
                                },
                                itemCount: stableInformationModel
                                    ?.stableServices.length,
                              ),
                            ),
                      state is BookingAvailableTimesLoading
                          ? Container()
                          : state is BookingAvailableTimesSuccess &&
                                  bookingAvailableTimes!
                                      .specialistsAvailableTimes.isNotEmpty
                              ? Container(
                                  margin: EdgeInsets.only(left: 10, top: 20),
                                  child: const Text(
                                    'Select specialist',
                                    style: TextStyle(
                                      color: Color(0xFF5A0072),
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                )
                              : Container(),
                      state is BookingAvailableTimesLoading
                          ? Center(
                              child: CircularProgressIndicator(
                              color: primaryColor,
                            ))
                          : state is BookingAvailableTimesSuccess &&
                                  bookingAvailableTimes!
                                      .specialistsAvailableTimes.isNotEmpty
                              ? Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.180,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (_, i) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  !isSelectedSpecialistsList[i]
                                                      ? null
                                                      : isSelected
                                                          ? primaryColor
                                                              .withOpacity(0.5)
                                                          : null,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.sp))),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                isSelectedSpecialistsList =
                                                    List.generate(
                                                        bookingAvailableTimes
                                                                ?.specialistsAvailableTimes
                                                                .length ??
                                                            100,
                                                        (index) => false);
                                                // ثم قم بتحديث القيمة للعنصر الذي تم الضغط عليه إلى true
                                                isSelectedSpecialistsList[i] =
                                                    true;
                                                isSelected = true;
                                                specialistID = i;
                                                print(state
                                                    .bookingAvailableTimes
                                                    .specialistsAvailableTimes[
                                                        specialistID!]
                                                    .firstName);
                                                isSelectedAvailableList
                                                    .addAll([false]);
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                    height: 70,
                                                    width: 70,
                                                    padding:
                                                        const EdgeInsets.all(3),
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 6,
                                                        vertical: 15),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.grey)),
                                                    child: const CircleAvatar(
                                                      backgroundImage: AssetImage(
                                                          'assets/images/img_16.png'),
                                                    )),
                                                Text(
                                                  state
                                                          .bookingAvailableTimes
                                                          .specialistsAvailableTimes[
                                                              i]
                                                          .firstName ??
                                                      '',
                                                  style: const TextStyle(
                                                      fontSize: 13),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: bookingAvailableTimes
                                        ?.specialistsAvailableTimes.length,
                                  ),
                                )
                              : state is BookingAvailableTimesSuccess
                                  ? Container(
                                      height: 200,
                                      child: GridView.builder(
                                        primary: false,
                                        shrinkWrap: false,
                                        itemCount: bookingAvailableTimes
                                            ?.allAvailableTimes.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 100,
                                                childAspectRatio: 3,
                                                crossAxisSpacing: 1,
                                                mainAxisSpacing: 2),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: EdgeInsets.all(2.sp),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius
                                                              .circular(30.sp)),
                                                  color:
                                                      !isSelectedAvailableList[
                                                              index]
                                                          ? Colors.grey
                                                              .withOpacity(
                                                                  0.451)
                                                          : primaryColor
                                                              .withOpacity(
                                                                  0.5)),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    isSelectedAvailableList =
                                                        List.generate(
                                                            bookingAvailableTimes
                                                                    ?.allAvailableTimes
                                                                    .length ??
                                                                100,
                                                            (index) => false);
                                                    isSelectedAvailableList[
                                                        index] = true;

                                                    hoursTime =
                                                        bookingAvailableTimes
                                                                    ?.allAvailableTimes[
                                                                index] ??
                                                            '';
                                                  });
                                                },
                                                child: Container(
                                                  child: Center(
                                                    child: Text(
                                                      bookingAvailableTimes
                                                                  ?.allAvailableTimes[
                                                              index] ??
                                                          '',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                          //
                                          //   ChoiceChip(
                                          //   shape: RoundedRectangleBorder(
                                          //       borderRadius:
                                          //       BorderRadius.all(Radius.circular(50))),
                                          //   label: Text(
                                          //     bookingAvailableTimes?.specialistsAvailableTimes[specialistID].availableTimes[index] ??'',
                                          //     style: TextStyle(
                                          //       color: Colors.black,
                                          //       fontSize: 13,
                                          //       fontFamily: 'Inter',
                                          //       fontWeight: FontWeight.w400,
                                          //       height: 0,
                                          //     ),
                                          //   ),
                                          //   selected: p1,
                                          //   onSelected: (v) {
                                          //     setState(() {
                                          //       p1 = v;
                                          //     });
                                          //   },
                                          //   selectedColor: Color(0xFF5A0072),
                                          // );
                                        },
                                      ),
                                    )
                                  : Container(),
                      SizedBox(
                        height: 35.sp,
                      ),
                      isSelected
                          ? Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                'Available slot',
                                style: TextStyle(
                                  color: Color(0xDD5A0072),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            )
                          : Container(),
                      // SizedBox(
                      //   height: 10.h,
                      // ),
                      isSelected
                          ? Container(
                              height: 200,
                              child: GridView.builder(
                                primary: false,
                                shrinkWrap: false,
                                itemCount: bookingAvailableTimes
                                    ?.specialistsAvailableTimes[specialistID!]
                                    .availableTimes
                                    .length,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 100,
                                        childAspectRatio: 3,
                                        crossAxisSpacing: 1,
                                        mainAxisSpacing: 2),
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.all(2.sp),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30.sp)),
                                          color: !isSelectedAvailableList[index]
                                              ? Colors.grey.withOpacity(0.451)
                                              : primaryColor.withOpacity(0.5)),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            isSelectedAvailableList = List.generate(
                                                bookingAvailableTimes
                                                        ?.specialistsAvailableTimes[
                                                            specialistID!]
                                                        .availableTimes
                                                        .length ??
                                                    100,
                                                (index) => false);
                                            isSelectedAvailableList[index] =
                                                true;

                                            hoursTime = bookingAvailableTimes
                                                    ?.specialistsAvailableTimes[
                                                        specialistID!]
                                                    .availableTimes[index] ??
                                                '';
                                          });
                                        },
                                        child: Container(
                                          child: Center(
                                            child: Text(
                                              bookingAvailableTimes
                                                      ?.specialistsAvailableTimes[
                                                          specialistID!]
                                                      .availableTimes[index] ??
                                                  '',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                  //
                                  //   ChoiceChip(
                                  //   shape: RoundedRectangleBorder(
                                  //       borderRadius:
                                  //       BorderRadius.all(Radius.circular(50))),
                                  //   label: Text(
                                  //     bookingAvailableTimes?.specialistsAvailableTimes[specialistID].availableTimes[index] ??'',
                                  //     style: TextStyle(
                                  //       color: Colors.black,
                                  //       fontSize: 13,
                                  //       fontFamily: 'Inter',
                                  //       fontWeight: FontWeight.w400,
                                  //       height: 0,
                                  //     ),
                                  //   ),
                                  //   selected: p1,
                                  //   onSelected: (v) {
                                  //     setState(() {
                                  //       p1 = v;
                                  //     });
                                  //   },
                                  //   selectedColor: Color(0xFF5A0072),
                                  // );
                                },
                              ),
                            )
                          : Container(),
                      Center(
                        child: Container(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(311, 44),
                                  elevation: 1,
                                  primary: secondaryColor,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ))),
                              onPressed: () {
                                if (dateTime != '') {
                                  if (selectServices != null) {
                                    if (bookingAvailableTimes!
                                        .specialistsAvailableTimes.isNotEmpty) {
                                      if (specialistID != null) {
                                        if (hoursTime != '') {
                                          Navigator.push<void>(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  BookingDetials(
                                                bookingAvailableTimes:
                                                    bookingAvailableTimes,
                                                stableId: widget.stableId,
                                                dateTime: dateTime,
                                                hoursTime:
                                                    hoursTime,
                                                servicesId: selectServices,
                                                specialistId: 0,
                                                pricePackage:
                                                    bookingAvailableTimes
                                                            ?.service[0].price
                                                            .toString() ??
                                                        '',
                                              ),
                                            ),
                                          );
                                        } else {
                                          SnackBarHelper.mySnackBar(
                                              "You must choose a time",
                                              context);
                                        }
                                      } else {
                                        SnackBarHelper.mySnackBar(
                                            "You must choose a Trainer",
                                            context);
                                      }
                                    } else {
                                      if (hoursTime != '') {
                                        Navigator.push<void>(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                BookingDetials(
                                              bookingAvailableTimes:
                                                  bookingAvailableTimes,
                                              stableId: widget.stableId,
                                              dateTime: dateTime,
                                              hoursTime:
                                                  hoursTime ?? '08:00:00',
                                              servicesId: selectServices,
                                              specialistId: specialistID,
                                              pricePackage:
                                                  bookingAvailableTimes
                                                          ?.service[0].price
                                                          .toString() ??
                                                      '',
                                            ),
                                          ),
                                        );
                                      } else {
                                        SnackBarHelper.mySnackBar(
                                            "You must choose a time", context);
                                      }
                                    }
                                  } else {
                                    SnackBarHelper.mySnackBar(
                                        "You must choose a service", context);
                                  }
                                } else {
                                  SnackBarHelper.mySnackBar(
                                      "You must choose a date", context);
                                }
                              },
                              child: const Text(
                                'Book',
                                style: TextStyle(
                                  color: Color(0xFF212327),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
