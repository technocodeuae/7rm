import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/bloc_consumer.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../../helper/error_dialog_helper.dart';
import '../../DrwerPage.dart';
import '../../util/app_them.dart';
import '../HorseDetail/detail_horse.dart';
import '../auctionCalendar/auctions_calendar.dart';
import '../component/Widght.dart';
import '../conset/Const.dart';
import '../login/login.dart';
import 'cubit/auctions_states.dart';
import 'cubit/cubit.dart';

class Auctions extends StatefulWidget {
  const Auctions({Key? key}) : super(key: key);

  @override
  State<Auctions> createState() => _ActionsState();
}

class _ActionsState extends State<Auctions> {
  bool p1 = false;
  bool p2 = false;
  bool p3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          'assets/images/main/image 12.png',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
                onPressed: () {
                  //
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const DrwerPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.menu,
                  color: Color.fromRGBO(90, 0, 114, 1),
                )),
            title: Container(
              alignment: Alignment.center,
              child: const Text(
                "Auctions",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(90, 0, 114, 1),
                ),
              ),
            ),
            actions: [
              Container(
                width: 50,
              ),
            ],
          ),
          body: BlocProvider(
            create: (context) => AllAuctionCubit(),
            child: BlocConsumer<AllAuctionCubit, AuctionsStates>(
                listener: (context, state) {
              if (state is ErrorStateAuctions) {
                DialogHelper.errorDialog(context, "Error", state.error);
              } else if (state is ErrorStateAuctionsToday) {
                DialogHelper.errorDialog(context, "Error", state.error);
              }
            }, builder: (context, state) {
              if (state is InitialAuctions) {
                BlocProvider.of<AllAuctionCubit>(context).getAllAuctions(p3);
                return Center(child: CircularProgressIndicator(color: Color1));
              } else if (state is SuccessAuctions) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      const Divider(
                        color: Color.fromRGBO(50, 52, 70, 1),
                      ),
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ChoiceChip(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.elliptical(20, 20),
                                  topLeft: Radius.elliptical(20, 20),
                                  topRight: Radius.elliptical(20, 20),
                                  bottomLeft: Radius.elliptical(20, 20),
                                ),
                              ),
                              // avatar: const CircleAvatar(
                              //   backgroundColor: Colors.transparent,
                              //   child: Icon(
                              //     Icons.filter_alt,
                              //     color: Colors.black,
                              //   ),
                              // ),
                              label: SizedBox(
                                width: 103.sp,
                                height: 32.sp,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Today’s',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              selected: p1,
                              onSelected: (v) {
                                setState(() {
                                  p1 = v;
                                  p2 = false;
                                  p3 = false;
                                  if (p1) {
                                    BlocProvider.of<AllAuctionCubit>(context)
                                        .getAllAuctionsToday();
                                  } else {
                                    BlocProvider.of<AllAuctionCubit>(context)
                                        .getAllAuctions(p3);
                                  }
                                });
                              },
                              selectedColor: secondaryColor,
                              shadowColor: secondaryColor.withOpacity(0.4),
                            ),
                            ChoiceChip(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.elliptical(20, 20),
                                  topLeft: Radius.elliptical(20, 20),
                                  topRight: Radius.elliptical(20, 20),
                                  bottomLeft: Radius.elliptical(20, 20),
                                ),
                              ),
                              label: SizedBox(
                                width: 120.57.sp,
                                height: 32.sp,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Upcoming (${state.auctions.uniqueHorsesSortedByPrice?.length ?? ""})',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              selected: p2,
                              onSelected: (v) {
                                p2 = v;
                                p1 = false;
                                p3 = false;
                                if (p2) {
                                  BlocProvider.of<AllAuctionCubit>(context)
                                      .getAllAuctions(false);
                                }
                              },
                              selectedColor: secondaryColor,
                              shadowColor: secondaryColor.withOpacity(0.4),
                            ),
                            ChoiceChip(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.elliptical(20, 20),
                                  topLeft: Radius.elliptical(20, 20),
                                  topRight: Radius.elliptical(20, 20),
                                  bottomLeft: Radius.elliptical(20, 20),
                                ),
                              ),
                              label: Row(
                                children: [
                                  SizedBox(
                                    width: 40.sp,
                                    height: 32.sp,
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Price',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              selected: p3,
                              onSelected: (v) {
                                p3 = v;
                                p1 = false;
                                p2 = false;
                                BlocProvider.of<AllAuctionCubit>(context)
                                    .getAllAuctions(p3);
                              },
                              selectedColor: secondaryColor,
                              shadowColor: secondaryColor.withOpacity(0.4),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: 600.sp,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.auctions
                                      .uniqueHorsesSortedByPrice?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                List<String>? parts = state
                                            .auctions
                                            .uniqueHorsesSortedByPrice?[index]
                                            .remainingTime ==
                                        null
                                    ? "00:00:00".split(':')
                                    : state
                                        .auctions
                                        .uniqueHorsesSortedByPrice?[index]
                                        .remainingTime
                                        ?.split(':');
                                int hours = int.parse(parts![0]);
                                int minutes = int.parse(parts[1]);
                                int seconds = int.parse(parts[2]);

                                return GestureDetector(
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 10.sp),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 130.sp,
                                          width: double.infinity,
                                          color: Colors.purpleAccent
                                              .withOpacity(0.1),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 128.sp,
                                                width: 127.sp,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              8.sp)),
                                                ),
                                                child: Image.network(
                                                  state
                                                          .auctions
                                                          .uniqueHorsesSortedByPrice![
                                                              index]
                                                          .images[0].image ??
                                                      'assets/images/main/7rmlogo.png',
                                                  fit: BoxFit.fill,
                                                  errorBuilder: (BuildContext
                                                          context,
                                                      Object error,
                                                      StackTrace? stackTrace) {
                                                    // If an error occurs while loading the image, show the fallback image
                                                    return Image.asset(
                                                        'assets/images/main/7rmlogo.png',
                                                       );
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8..sp),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 200.sp,
                                                      height: 20.sp,
                                                      child: Text(
                                                        state
                                                                .auctions
                                                                .uniqueHorsesSortedByPrice![
                                                                    index]
                                                                .dam ??
                                                            "",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF5A0072),
                                                          fontSize: 18.sp,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          height: 0,
                                                        ),
                                                      ),
                                                    ),
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: 'Sire:',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF5A0072),
                                                              fontSize: 14.sp,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: state
                                                                .auctions
                                                                .uniqueHorsesSortedByPrice![
                                                                    index]
                                                                .sire,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14.sp,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: 'Gender:',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF5A0072),
                                                              fontSize: 14.sp,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: state
                                                                .auctions
                                                                .uniqueHorsesSortedByPrice![
                                                                    index]
                                                                .gender,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14.sp,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: 'Birth Date:',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF5A0072),
                                                              fontSize: 14.sp,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: state
                                                                .auctions
                                                                .uniqueHorsesSortedByPrice[
                                                                    index]
                                                                .birthDate.toString() ??'',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12.sp,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: 'Price: ',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF5A0072),
                                                              fontSize: 14.sp,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                '${state.auctions.uniqueHorsesSortedByPrice![index].price} AED',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14.sp,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      // mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 90.sp,
                                                        ),
                                                        Text(
                                                          "Left time: ",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF5A0072),
                                                            fontSize: 14.sp,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        TimerCountdown(
                                                          format: CountDownTimerFormat
                                                              .hoursMinutesSeconds,
                                                          enableDescriptions:
                                                              false,
                                                          spacerWidth: 1,
                                                          timeTextStyle:
                                                              const TextStyle(
                                                                  color: Color(
                                                                      0xFFAC0000),
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  height: 0),
                                                          colonsTextStyle:
                                                              const TextStyle(
                                                                  color: Color(
                                                                      0xFFAC0000),
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  height: 0),
                                                          endTime: DateTime
                                                                  .now()
                                                              .add(Duration(
                                                                  hours: hours,
                                                                  minutes:
                                                                      minutes,
                                                                  seconds:
                                                                      seconds)),
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
                                        /*Positioned(
                                          left: 280,
                                          top: 40,
                                          child: Container(
                                            width: 83,
                                            height: 71,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/img_20.png'),
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              width: 83,
                                              height: 16,
                                              child: const Text(
                                                '1d 18h 50m',
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



                                    if (DIManager.findDep<SharedPrefs>().getToken() != null){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsHorses(
                                              auction_id: state
                                                  .auctions
                                                  .uniqueHorsesSortedByPrice![
                                              index]
                                                  .auctionId ??
                                                  0,
                                              horse_id: state
                                                  .auctions
                                                  .uniqueHorsesSortedByPrice![
                                              index]
                                                  .id ??
                                                  0,
                                            )),
                                      );
                                    }else {

                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                            return LoginW();
                                          }));
                                    }



                                  },
                                );
                              },
                            ),
                          ),
                          Column(
                            children: [
                              ButtonStaic(
                                  onTap: () {
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            const AuctionsCalendar(),
                                      ),
                                    );
                                  },
                                  title: "Upcoming Auctions",
                                  fontSize: 14.sp,
                                  colorText: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  heightContainer: 48.sp,
                                  widthContainer: 300.sp),
                              SizedBox(
                                height: 20.sp,
                              ),
                            ],
                          )
                        ],
                      ),
                    ]),
                  ),
                );
              } else if (state is SuccessAuctionsToday) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      const Divider(
                        color: Color.fromRGBO(50, 52, 70, 1),
                      ),
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ChoiceChip(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.elliptical(20, 20),
                                  topLeft: Radius.elliptical(20, 20),
                                  topRight: Radius.elliptical(20, 20),
                                  bottomLeft: Radius.elliptical(20, 20),
                                ),
                              ),
                              // avatar: const CircleAvatar(
                              //   backgroundColor: Colors.transparent,
                              //   child: Icon(
                              //     Icons.filter_alt,
                              //     color: Colors.black,
                              //   ),
                              // ),
                              label: SizedBox(
                                width: 103.sp,
                                height: 32.sp,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Today’s (${state.today.getHorsesForTodaysAuctions?.length ?? ""})',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              selected: p1,
                              onSelected: (v) {
                                setState(() {
                                  p1 = v;
                                  p2 = false;
                                  p3 = false;
                                  if (p1) {
                                    BlocProvider.of<AllAuctionCubit>(context)
                                        .getAllAuctionsToday();
                                  } /*else if (!p1 && !p3){
                                    BlocProvider.of<AllAuctionCubit>(context).getAllAuctions(p3);
                                  }*/
                                });
                              },
                              selectedColor: secondaryColor,
                              shadowColor: secondaryColor.withOpacity(0.4),
                            ),
                            ChoiceChip(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.elliptical(20, 20),
                                  topLeft: Radius.elliptical(20, 20),
                                  topRight: Radius.elliptical(20, 20),
                                  bottomLeft: Radius.elliptical(20, 20),
                                ),
                              ),
                              label: SizedBox(
                                width: 120.57.sp,
                                height: 32.sp,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Upcoming',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              selected: p2,
                              onSelected: (v) {
                                p2 = v;
                                p1 = false;
                                p3 = false;

                                BlocProvider.of<AllAuctionCubit>(context)
                                    .getAllAuctions(false);
                              },
                              selectedColor: secondaryColor,
                              shadowColor: secondaryColor.withOpacity(0.4),
                            ),
                            ChoiceChip(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.elliptical(20, 20),
                                  topLeft: Radius.elliptical(20, 20),
                                  topRight: Radius.elliptical(20, 20),
                                  bottomLeft: Radius.elliptical(20, 20),
                                ),
                              ),
                              label: Row(
                                children: [
                                  SizedBox(
                                    width: 40.sp,
                                    height: 32.sp,
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Price',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              selected: p3,
                              onSelected: (v) {
                                p3 = v;
                                p1 = false;
                                p2 = false;
                                BlocProvider.of<AllAuctionCubit>(context)
                                    .getAllAuctions(p3);
                              },
                              selectedColor: secondaryColor,
                              shadowColor: secondaryColor.withOpacity(0.4),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: 600.sp,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.today.getHorsesForTodaysAuctions
                                      ?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                List<String>? parts = state
                                            .today
                                            .getHorsesForTodaysAuctions?[index]
                                            .remainingTime ==
                                        null
                                    ? "00:00:00".split(':')
                                    : state
                                        .today
                                        .getHorsesForTodaysAuctions?[index]
                                        .remainingTime
                                        ?.split(':');
                                int hours = int.parse(parts![0]);
                                int minutes = int.parse(parts[1]);
                                int seconds = int.parse(parts[2]);
                                return InkWell(
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 130.sp,
                                          width: double.infinity,
                                          color: Colors.purpleAccent
                                              .withOpacity(0.1),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 127.sp,
                                                width: 127.sp,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              8.sp)),

                                                  // image: DecorationImage(
                                                  //     image:
                                                  //     (state
                                                  //         .today
                                                  //         .getHorsesForTodaysAuctions![index]
                                                  //         .images!=null)?
                                                  //     NetworkImage(state
                                                  //         .today
                                                  //         .getHorsesForTodaysAuctions![
                                                  //     index]
                                                  //         .images![0],
                                                  //     )
                                                  //         : const AssetImage("assets/main/img_19.png") as ImageProvider<Object>,
                                                  //     fit: BoxFit.fill),

                                                  // borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Image.network(
                                                  state
                                                          .today
                                                          .getHorsesForTodaysAuctions![
                                                              index]
                                                          .images[0].image
                                                          .toString() ??
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 200.sp,
                                                      height: 20.sp,
                                                      child: Text(
                                                        state
                                                                .today
                                                                .getHorsesForTodaysAuctions![
                                                                    index]
                                                                .dam ??
                                                            "",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF5A0072),
                                                          fontSize: 18,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          height: 0,
                                                        ),
                                                      ),
                                                    ),
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: 'Sire:',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF5A0072),
                                                              fontSize: 14.sp,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: state
                                                                    .today
                                                                    .getHorsesForTodaysAuctions![
                                                                        index]
                                                                    .sire ??
                                                                "",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14.sp,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: 'Gender:',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF5A0072),
                                                              fontSize: 14.sp,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: state
                                                                    .today
                                                                    .getHorsesForTodaysAuctions![
                                                                        index]
                                                                    .gender ??
                                                                "",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14.sp,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: 'Birth Date:',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF5A0072),
                                                              fontSize: 14.sp,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: state
                                                                    .today
                                                                    .getHorsesForTodaysAuctions![
                                                                        index]
                                                                    .birthDate.toString() ??
                                                                "",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12.sp,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: 'Price: ',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF5A0072),
                                                              fontSize: 14.sp,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                '${state.today.getHorsesForTodaysAuctions![index].price ?? ""} AED',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14.sp,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      // mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 90.sp,
                                                        ),
                                                        Text(
                                                          "Left time: ",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF5A0072),
                                                            fontSize: 14.sp,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        TimerCountdown(
                                                          format: CountDownTimerFormat
                                                              .hoursMinutesSeconds,
                                                          enableDescriptions:
                                                              false,
                                                          spacerWidth: 1,
                                                          timeTextStyle:
                                                              const TextStyle(
                                                                  color: Color(
                                                                      0xFFAC0000),
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  height: 0),
                                                          colonsTextStyle:
                                                              const TextStyle(
                                                                  color: Color(
                                                                      0xFFAC0000),
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  height: 0),
                                                          endTime: DateTime
                                                                  .now()
                                                              .add(Duration(
                                                                  hours: hours,
                                                                  minutes:
                                                                      minutes,
                                                                  seconds:
                                                                      seconds)),
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
                                        /*   Positioned(
                                          left: 280,
                                          top: 40,
                                          child: Container(
                                            width: 83,
                                            height: 71,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/img_20.png'),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),*/
                                        /*Positioned(
                                            left: 280,
                                            top: 113,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      50)),
                                              width: 83,
                                              height: 16,
                                              child: const Text(
                                                '1d 18h 50m',
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



                                    if (DIManager.findDep<SharedPrefs>().getToken() != null){
                                      Navigator.push<void>(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsHorses(
                                              auction_id: state
                                                  .today
                                                  .getHorsesForTodaysAuctions?[
                                              index]
                                                  .auctionId ??
                                                  0,
                                              horse_id: state
                                                  .today
                                                  .getHorsesForTodaysAuctions?[
                                              index]
                                                  .id ??
                                                  0,
                                            )),
                                      );
                                    }else {

                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                            return LoginW();
                                          }));
                                    }



                                  },
                                );
                              },
                            ),
                          ),
                          Column(
                            ////
                            children: [
                              ButtonStaic(
                                  onTap: () {
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            const AuctionsCalendar(),
                                      ),
                                    );
                                  },
                                  title: "Upcoming Auctions",
                                  fontSize: 14.sp,
                                  colorText: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  heightContainer: 48.sp,
                                  widthContainer: 300.sp),
                              SizedBox(
                                height: 20.sp,
                              ),
                            ],
                          )
                        ],
                      ),
                    ]),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator(color: Color1));
              }
            }),
          ),
        )
      ]),
    );
  }
}
