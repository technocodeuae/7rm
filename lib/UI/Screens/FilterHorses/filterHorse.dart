import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:sevin_rm/UI/Screens/HorseDetail/detail_horse.dart';
import 'package:sevin_rm/UI/Screens/conset/Const.dart';
import 'package:sevin_rm/helper/error_dialog_helper.dart';

import 'cubit/cubit.dart';
import 'cubit/filter_horses_states.dart';

class filterScreen extends StatefulWidget {
  filterScreen({Key? key, required this.auctionId}) : super(key: key);
  int auctionId;
  @override
  State<filterScreen> createState() => _filterScreenState();
}

class _filterScreenState extends State<filterScreen> {
  bool p1 = false;
  bool p2 = false;
  bool p3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/img.png"), fit: BoxFit.fill),
          // borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color(0xFF5A0072),
                  ),
                ),
                centerTitle: true,
                toolbarHeight: 80,
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  'Horses',
                  style: TextStyle(
                    color: Color(0xFF5A0072),
                    fontSize: 22.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Divider(
                thickness: 1.0,
                color: Colors.black,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     ChoiceChip(
              //       shape: const RoundedRectangleBorder(
              //         borderRadius: BorderRadius.only(
              //           bottomRight: Radius.elliptical(10, 10),
              //           topLeft: Radius.elliptical(10, 10),
              //           topRight: Radius.elliptical(10, 10),
              //           bottomLeft: Radius.elliptical(10, 10),
              //         ),
              //       ),
              //       avatar: const CircleAvatar(
              //         backgroundColor: Colors.transparent,
              //         child: Icon(
              //           Icons.filter_alt,
              //           color: Colors.black,
              //         ),
              //       ),
              //       label: const Text(
              //         'Filter',
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 20,
              //           fontFamily: 'Inter',
              //           fontWeight: FontWeight.w400,
              //           height: 0,
              //         ),
              //       ),
              //       selected: p1,
              //       onSelected: (v) {
              //         setState(() {
              //           p1 = v;
              //         });
              //       },
              //       selectedColor: secondaryColor,
              //       shadowColor: secondaryColor.withOpacity(0.4),
              //     ),
              //     ChoiceChip(
              //       shape: const RoundedRectangleBorder(
              //         borderRadius: BorderRadius.only(
              //           bottomRight: Radius.elliptical(10, 10),
              //           topLeft: Radius.elliptical(10, 10),
              //           topRight: Radius.elliptical(10, 10),
              //           bottomLeft: Radius.elliptical(10, 10),
              //         ),
              //       ),
              //       label: const Text(
              //         'Sort',
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 20,
              //           fontFamily: 'Inter',
              //           fontWeight: FontWeight.w400,
              //           height: 0,
              //         ),
              //       ),
              //       selected: p2,
              //       onSelected: (v) {
              //         setState(() {
              //           p2 = v;
              //         });
              //       },
              //       selectedColor: secondaryColor,
              //       shadowColor: secondaryColor.withOpacity(0.4),
              //     ),
              //     ChoiceChip(
              //       shape: const RoundedRectangleBorder(
              //         borderRadius: BorderRadius.only(
              //           bottomRight: Radius.elliptical(10, 10),
              //           topLeft: Radius.elliptical(10, 10),
              //           topRight: Radius.elliptical(10, 10),
              //           bottomLeft: Radius.elliptical(10, 10),
              //         ),
              //       ),
              //       label: const Row(
              //         children: [
              //           Text(
              //             'Save',
              //             style: TextStyle(
              //               color: Colors.black,
              //               fontSize: 20,
              //               fontFamily: 'Inter',
              //               fontWeight: FontWeight.w400,
              //               height: 0,
              //             ),
              //           )
              //         ],
              //       ),
              //       selected: p3,
              //       onSelected: (v) {
              //         setState(() {
              //           p3 = v;
              //         });
              //       },
              //       selectedColor: secondaryColor,
              //       shadowColor: secondaryColor.withOpacity(0.4),
              //     ),
              //   ],
              // ),
              BlocProvider(
                create: (context) => FilterHorsesCubit(),
                child: BlocConsumer<FilterHorsesCubit, FilterHorseStates>(
                    listener: (context, state) {
                  if (state is ErrorStateFilter) {
                    DialogHelper.errorDialog(context, "Error", state.error);
                  }
                }, builder: (context, state) {
                  if (state is InitialFilter) {
                    BlocProvider.of<FilterHorsesCubit>(context)
                        .getAllHorses(widget.auctionId);
                    return Container(
                        height: MediaQuery.of(context).size.height / 1.2,
                        child: Center(
                            child: CircularProgressIndicator(color: Color1)));
                  } else if (state is SuccessFilter) {
                    if (state.horses.horses.isEmpty) {
                      return Container(
                          height: MediaQuery.of(context).size.height / 1.2,
                          child: Center(
                              child: Text("Not Found Data!!",
                                  style:
                                      TextStyle(color: Color1, fontSize: 25))));
                    }

                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.horses.horses.length,
                      itemBuilder: (context, index) {
                        List<String>? parts =
                            state.horses.horses[index].restTime == null
                                ? "00:00:00".split(':')
                                : state.horses.horses[index].restTime
                                    ?.split(':');
                        int hours = int.parse(parts![0]);
                        int minutes = int.parse(parts[1]);
                        int seconds = int.parse(parts[2]);

                        return GestureDetector(
                          child: Container(
                            margin: EdgeInsets.all(8.sp),
                            child: Stack(
                              children: [
                                Container(
                                  height: 130.sp,
                                  width: double.infinity,
                                  color: Colors.purpleAccent.withOpacity(0.1),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 127.sp,
                                        width: 127.sp,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.sp)),
                                          // borderRadius: BorderRadius.circular(10),
                                        ),
                                        //
                                        child: Image.network(
                                          state.horses.horses[index].images ??
                                              'assets/images/main/7rmlogo.png',
                                          fit: BoxFit.fill,
                                          errorBuilder: (BuildContext context,
                                              Object error,
                                              StackTrace? stackTrace) {
                                            return Image.asset(
                                                'assets/images/main/7rmlogo.png',
                                                fit: BoxFit.fill);
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 200.sp,
                                              height: 20.sp,
                                              child: Text(
                                                state.horses.horses[index]
                                                        .dam ??
                                                    "",
                                                style: const TextStyle(
                                                  color: Color(0xFF5A0072),
                                                  fontSize: 18,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  const TextSpan(
                                                    text: 'Sire:',
                                                    style: TextStyle(
                                                      color: Color(0xFF5A0072),
                                                      fontSize: 14,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: state.horses
                                                        .horses[index].sire,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  const TextSpan(
                                                    text: 'Gender:',
                                                    style: TextStyle(
                                                      color: Color(0xFF5A0072),
                                                      fontSize: 14,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: state.horses
                                                        .horses[index].gender,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  const TextSpan(
                                                    text: 'Birth Date:',
                                                    style: TextStyle(
                                                      color: Color(0xFF5A0072),
                                                      fontSize: 14,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: state
                                                        .horses
                                                        .horses[index]
                                                        .birthDate,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  const TextSpan(
                                                    text: 'Price: ',
                                                    style: TextStyle(
                                                      color: Color(0xFF5A0072),
                                                      fontSize: 14,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        '${state.horses.horses[index].price} AED',
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 90.sp,
                                                ),
                                                Text(
                                                  "Left time: ",
                                                  style: TextStyle(
                                                    color: Color(0xFF5A0072),
                                                    fontSize: 14.sp,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                                TimerCountdown(
                                                  format: CountDownTimerFormat
                                                      .hoursMinutesSeconds,
                                                  enableDescriptions: false,
                                                  spacerWidth: 1,
                                                  timeTextStyle:
                                                      const TextStyle(
                                                          color:
                                                              Color(0xFFAC0000),
                                                          fontSize: 12,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          height: 0),
                                                  colonsTextStyle:
                                                      const TextStyle(
                                                          color:
                                                              Color(0xFFAC0000),
                                                          fontSize: 12,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          height: 0),
                                                  endTime: DateTime.now().add(
                                                      Duration(
                                                          hours: hours,
                                                          minutes: minutes,
                                                          seconds: seconds)),
                                                  onEnd: () {
                                                    // setState(() {
                                                    //   isFinishTime = true;
                                                    // });
                                                    // isFinishTime = true;
                                                  },
                                                  /* build: (context, double time) {
                                                            return Text(
                                                              'Time left $time',
                                                              style: const TextStyle(
                                                                color: Color(0xFFAC0000),
                                                                fontSize: 18,
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.bold,
                                                                height: 0,
                                                              ),
                                                            );
                                                          },*/
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /* Positioned(
                                    left: 280,
                                    top: 40,
                                    child: Container(
                                      width: 83,
                                      height: 71,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/img_20.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      left: 280,
                                      top: 113,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50)),
                                        width: 83,
                                        height: 16,
                                        child:  const Text(
                                          '1d 18h 50m' ,
                                          style: TextStyle(
                                            color: Color(0xFFAC0000),
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ))*/
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsHorses(
                                        auction_id: widget.auctionId,
                                        horse_id:
                                            state.horses.horses[index].id!,
                                      )),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return Container(
                        height: MediaQuery.of(context).size.height / 1.2,
                        child: Center(
                            child: CircularProgressIndicator(color: Color1)));
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
