import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sevin_rm/Core/di/di_manager.dart';
import 'package:sevin_rm/Core/shared_prefs/shared_prefs.dart';
import 'package:sevin_rm/UI/Screens/auctionCalendar/cubit/cubit.dart';
import 'package:sevin_rm/UI/Screens/conset/Const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevin_rm/UI/Screens/login/login.dart';
import 'package:sevin_rm/UI/Screens/payment/payment_page.dart';
import 'package:sevin_rm/helper/error_dialog_helper.dart';
import 'package:sevin_rm/helper/fixer_helper.dart';
import '../FilterHorses/filterHorse.dart';
import 'cubit/auctions_calendar_states.dart';

class AuctionsCalendar extends StatefulWidget {
  const AuctionsCalendar({Key? key}) : super(key: key);

  @override
  State<AuctionsCalendar> createState() => _AuctionsCalendarState();
}

class _AuctionsCalendarState extends State<AuctionsCalendar> {
  AuctionsCalendarCubit auctionsCalendarCubit = AuctionsCalendarCubit();
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
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Color1,
                  size: 30,
                )),
            title: Center(
              child: Container(
                child: Text(
                  "Auctions Calendar",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color1),
                ),
              ),
            ),
            actions: [
              Container(
                width: 50,
              )
            ],
          ),
          body: Column(
            children: [
              const Divider(
                color: Color.fromRGBO(50, 52, 70, 1),
              ),
              BlocProvider(
                create: (context) => AuctionsCalendarCubit(),
                child: BlocConsumer<AuctionsCalendarCubit,AuctionsCalendarStates>(
                  listener: (context, state) {
                   if(state is ErrorStateCalendar){
                      DialogHelper.errorDialog(context, "Error", state.error);
                    }
                  },
                  builder: (context,state) {
                    if(state is InitialCalendar){
                      BlocProvider.of<AuctionsCalendarCubit>(context).getAuctionsCalendar();
                      return Padding(
                        padding:  EdgeInsets.only(top: 350.sp),
                        child: CircularProgressIndicator(color: Color1),
                      );
                    }
                    else if (state is SuccessCalendar){
                      return SizedBox(
                      // width: 350.sp,
                      height: 650.sp,
                      child: ListView.builder(
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: (){


                              if (DIManager.findDep<SharedPrefs>().getToken() != null){
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (
                                        BuildContext context) =>
                                        filterScreen(
                                            auctionId: state.
                                            calendars
                                                .upcomingAuctions[index]
                                                .auctionId!),
                                  ),
                                );

                              }else {

                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return LoginW();
                                    }));
                              }



                            },
                            child: Padding(
                              padding:  EdgeInsets.all(12.sp),
                              child: Container(
                                // width: 20,
                                width: 200.sp,
                                height: 90.sp,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50.sp)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children: [
                                    Text(
                                     state.calendars.upcomingAuctions[index].title??"",
                                      style:  TextStyle(
                                          fontSize: 16.sp, fontWeight: FontWeight.w700),
                                    ),
                                    Row(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(width: 1.sp,),
                                        const Icon(
                                          Icons.location_on,
                                          size: 20,
                                        ),
                                        Center(
                                          child: Text(
                                            FixerHelper.
                                            convertingDateTimeIntoOriginalFormat(state.calendars.
                                            upcomingAuctions[index].date!),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push<void>(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder: (
                                                      BuildContext context) =>
                                                      filterScreen(
                                                          auctionId: state.
                                                          calendars
                                                              .upcomingAuctions[index]
                                                              .auctionId!),
                                                ),
                                              );},
                                            icon: const Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: Colors.black,
                                            )),


                                      ],
                                    ),
                                    // const SizedBox(
                                    //   height: 5,
                                    // ),
                                    // Padding(
                                    //   padding:  EdgeInsets.only(left: 40.sp),
                                    //   child: Row(
                                    //     children: [
                                    //       const Icon(
                                    //         Icons.location_on,
                                    //         size: 20,
                                    //       ),
                                    //       Container(
                                    //         width: 210.sp,
                                    //         alignment: Alignment.center,
                                    //         child: Center(
                                    //           child: Text(
                                    //             FixerHelper.
                                    //             convertingDateTimeIntoOriginalFormat(copyStateCalendar.calendars.
                                    //             upcomingAuctions[index].date!),
                                    //             textAlign: TextAlign.center,
                                    //             style: const TextStyle(
                                    //                 fontSize: 20,
                                    //                 fontWeight: FontWeight.w400),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // )
                                  ]),
                                ),
                              ),
                            ),
                          );
                        }),
                        itemCount: state.calendars.upcomingAuctions.length,
                      ),
                    );
                    }
                    else{
                      return Padding(
                        padding:  EdgeInsets.only(top: 350.sp),
                        child: Center(child: CircularProgressIndicator(color: Color1)),
                      );
                    }
                  }
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
