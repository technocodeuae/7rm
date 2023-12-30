import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:sevin_rm/UI/Screens/booking/cubit/cubit.dart';
import 'package:sevin_rm/UI/Screens/booking/cubit/states.dart';
import 'package:sevin_rm/helper/PusherHelper.dart';
import 'package:sevin_rm/helper/fixer_helper.dart';
import 'package:share_plus/share_plus.dart';

import '../../../helper/error_dialog_helper.dart';
import '../../../helper/snack_bar_helper.dart';
import '../../util/app_them.dart';
import '../conset/Const.dart';
import '../payment/payment_page.dart';
import 'cubit/cubit.dart';
import 'cubit/horse_detail_states.dart';

class DetailsHorses extends StatefulWidget {
  final int auction_id;
  final int horse_id;
  const DetailsHorses(
      {Key? key, required this.auction_id, required this.horse_id})
      : super(key: key);

  @override
  State<DetailsHorses> createState() => _DetailsHorsesState();
}

class _DetailsHorsesState extends State<DetailsHorses> {
  int _page = 0;
  DateTime dateTime = DateTime.now();
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
  PusherHelper pusherHelper = PusherHelper();
  int selected_page = 0;
  late Map<String, int> auctionValue;
  int currentIndex = 0;
  bool isFinishTime = false;
  final List<String> images = [
    'assets/images/img_24.png',
    'assets/images/img_24.png',
    'assets/images/img_24.png',
  ];
  StreamSubscription<Map<String, dynamic>>? streamSubscription;

  @override
  void initState() {
    auctionValue = {
      "value": 0,
      "auction_id": widget.auction_id,
      "horse_id": widget.horse_id
    };
    streamSubscription ??= pusherHelper.onValueChanged.listen((event) {
      if (auctionValue["value"]!.toDouble() < event["value"]!.toDouble() &&
          event["auction_id"] == widget.auction_id &&
          event["horse_id"] == widget.horse_id) {
        auctionValue = event;
        print(
            '0000000000000000000000000000000000000000000000000000000000000000000S');
        print('auctionValue ${auctionValue["value"]}');
        setState(() {});
      }
    });
    super.initState();
  }
  //
  // @override
  // void dispose() {
  //   // pusherHelper.ourStream.close();
  //   super.dispose();
  // }

  bool isHorseInFavorite = false;
  @override
  Widget build(BuildContext context) {
    /*streamSubscription ??= pusherHelper.onValueChanged.listen((event) {
    if(auctionValue<event) {
      auctionValue = event;
      setState(() {});
    }
    });*/
    print("auction_id:${widget.auction_id} ==> widget.horseID: ${widget.horse_id}");
    print("auctionValue  ${auctionValue["value"]}");
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/img.png"), fit: BoxFit.fill),
            // borderRadius: BorderRadius.circular(10),
          ),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => HorseDetailCubit(),
              ),
              BlocProvider(
                create: (context) => PusherHelper(),
              ),
            ],
            child: BlocConsumer<HorseDetailCubit, DetailHorseStates>(
                listener: (context, state) {
              if (state is ErrorState) {
                DialogHelper.errorDialog(context, "Error", state.error);
              }

              // if (state is IsHorseInFavoriteSuccess) {
              //   isHorseInFavorite =state.isHoesInFavoriteModel.status;
              // }
            }, builder: (context, state) {
              if (state is Initial) {
                BlocProvider.of<HorseDetailCubit>(context)
                    .getHorseDetail(widget.horse_id);
                print('-23-02390-39-90239920-392-032932-092323');
                print(widget.auction_id);
                return Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height,
                    child: CircularProgressIndicator(color: Color1));
              } else if (state is Success) {
                if (state.horse.highestBid != null) {
                  auctionValue = {
                    "value": (auctionValue["value"])!>int.parse(state.horse.highestBid!)?auctionValue["value"]!:int.parse(state.horse.highestBid!),
                    "auction_id": widget.auction_id,
                    "horse_id": widget.horse_id
                  };
                }
                List<String> parts = state.horse.restTime == null
                    ? "00:00:00".split(':')
                    : state.horse.restTime!.split(':');
                int hours = int.parse(parts[0]);
                int minutes = int.parse(parts[1]);
                int seconds = int.parse(parts[2]);
                int? horseId = state.horse.id ?? 0;
                print(
                    '________________________________________________________________________');
                print("price horse ${state.horse.price}");
                print("price horse ${hours}");
                print("price horse ${minutes}");
                print("price horse ${seconds}");
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
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
                      toolbarHeight: 50,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      title: const Text(
                        'Auctions Calendar',
                        style: TextStyle(
                          color: Color(0xFF5A0072),
                          fontSize: 22,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 219.sp,
                      width: double.infinity,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          reverse: true,
                          height: 215.sp,
                          autoPlay: true,
                          aspectRatio: 3,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            /*setState(() {
                                            currentIndex = index;
                                          });*/
                          },
                        ),
                        items: state.horse.images == null
                            ? images
                                .map((image) => Image.asset(
                                      'assets/images/img_24.png',
                                      height: 221,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    ))
                                .toList()
                            : state.horse.images!
                                .map((image) => Image.network(
                                      image,
                                      height: 221,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
                                          child: Image.asset(
                                            'assets/images/main/7rmlogo.png',
                                          ),
                                        );
                                      },
                                      ////
                                    ))
                                .toList(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: images.map((image) {
                        // Get the index of the current image
                        int index = images.indexOf(image);
                        // Return a dot widget for each image
                        return Container(
                          width: 5,
                          height: 5,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: const BoxDecoration(
                            // Set the color of the dot depending on the current index
                            /*color: currentIndex == index
                                              ? Colors.blue
                                              : Colors.grey,
                                          */ // Make the dot circular
                            shape: BoxShape.circle,
                          ),
                        );
                      }).toList(),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocProvider(
                            create: (context) => BookingCubitPage()
                              ..isHorseInFavorite(horseId: horseId),
                            child: BlocConsumer<BookingCubitPage,
                                BookingCubitPageStates>(
                              listener: (context, state) {
                                if (state is IsHorseInFavoriteSuccess) {
                                  isHorseInFavorite =
                                      state.isHoesInFavoriteModel.status ??
                                          false;
                                }
                              },
                              builder: (context, state) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: IconButton(
                                    icon: ImageIcon(
                                      AssetImage(
                                        'assets/images/img_26.png',
                                      ),
                                      color: isHorseInFavorite
                                          ? Colors.yellow
                                          : Colors.black,
                                    ),
                                    onPressed: () {
                                      if (isHorseInFavorite) {
                                        BookingCubitPage.get(context)
                                            .removeFavorite(horseId);
                                      } else {
                                        BookingCubitPage.get(context)
                                            .addFavorite(horseId);
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: IconButton(
                              icon: const ImageIcon(
                                AssetImage('assets/images/img_28.png'),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: IconButton(
                              icon: const ImageIcon(
                                AssetImage('assets/images/img_29.png'),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: IconButton(
                              icon: const ImageIcon(
                                AssetImage('assets/images/img_30.png'),
                              ),
                              onPressed: () {
                                Share.share('Hello Welcome to 7RM',
                                    subject: 'Welcome Message');
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: IconButton(
                              icon: const ImageIcon(
                                AssetImage('assets/images/img_31.png'),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Horse Name:',
                                  style: TextStyle(
                                    color: Color(0xFF5A0072),
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: state.horse.name ?? "",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Gender:',
                                      style: TextStyle(
                                        color: Color(0xFF5A0072),
                                        fontSize: 18,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: state.horse.gender ?? "",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              ///'Sale Date
                              // Column(
                              //   children: [
                              //     const Text(
                              //       'Sale Date:',
                              //       style: TextStyle(
                              //         color: Color(0xFF5A0072),
                              //         fontSize: 18,
                              //         fontFamily: 'Inter',
                              //         fontWeight: FontWeight.w400,
                              //         height: 0,
                              //       ),
                              //     ),
                              //     Text(
                              //       state.horse.saleDate ?? "",
                              //       style: const TextStyle(
                              //         color: Color(0xFFAC0000),
                              //         fontSize: 18,
                              //         fontFamily: 'Inter',
                              //         fontWeight: FontWeight.w400,
                              //         height: 0,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Birth Date:',
                                  style: TextStyle(
                                    color: Color(0xFF5A0072),
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: state.horse.birthDate ?? "",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Category:',
                                      style: TextStyle(
                                        color: Color(0xFF5A0072),
                                        fontSize: 18,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: state.horse.categoryName ?? "",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              ///Sale Time
                              // Column(
                              //   children: [
                              //     const Text(
                              //       'Sale Time:',
                              //       style: TextStyle(
                              //         color: Color(0xFF5A0072),
                              //         fontSize: 18,
                              //         fontFamily: 'Inter',
                              //         fontWeight: FontWeight.w400,
                              //         height: 0,
                              //       ),
                              //     ),
                              //     Text(
                              //       state.horse.saleTime ?? "",
                              //       style: const TextStyle(
                              //         color: Color(0xFFAC0000),
                              //         fontSize: 18,
                              //         fontFamily: 'Inter',
                              //         fontWeight: FontWeight.w400,
                              //         height: 0,
                              //       ),
                              //     )
                              //   ],
                              // )
                            ],
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Color:',
                                  style: TextStyle(
                                    color: Color(0xFF5A0072),
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: state.horse.color,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Location: ',
                                  style: TextStyle(
                                    color: Color(0xFF5A0072),
                                    fontSize: 18.sp,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: state.horse.location,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Owner: ',
                                  style: TextStyle(
                                    color: Color(0xFF5A0072),
                                    fontSize: 18.sp,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: state.horse.owner,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Address: ',
                                  style: TextStyle(
                                    color: Color(0xFF5A0072),
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: state.horse.address ??
                                      state.horse.locationName,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/img_27.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(
                                state.horse.ownerMobile.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Auction Start : ',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 15,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    Text(
                                      state.horse.startTime ?? "00:00:00",
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 15,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    )
                                  ],
                                ),
                                VerticalDivider(
                                  thickness: 3,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Auction End : ',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    Text(
                                      state.horse.endTime ?? "00:00:00",
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  height: 40.sp,
                                  width: 40.sp,
                                  decoration: BoxDecoration(
                                    color: auctionValue["value"] != null
                                        ? auctionValue["value"]! >=
                                                double.parse(
                                                    state.horse.price ?? "0.0")
                                            ? Colors.green
                                            : Colors.red
                                        : Colors.red,
                                    border: Border.all(
                                        color: Colors.black, width: 1.sp),
                                    borderRadius: BorderRadius.circular(50.sp),
                                    shape: BoxShape.rectangle,
                                  )),
                              SizedBox(
                                width: 10.sp,
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: 40.sp,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(15),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Time Left",
                                          style: TextStyle(
                                              color: Color(0xFFAC0000),
                                              fontSize: 16.sp,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.bold,
                                              height: 0)),
                                      TimerCountdown(
                                        format: CountDownTimerFormat
                                            .hoursMinutesSeconds,
                                        enableDescriptions: false,
                                        timeTextStyle: const TextStyle(
                                            color: Color(0xFFAC0000),
                                            fontSize: 18,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.bold,
                                            height: 0),
                                        colonsTextStyle: const TextStyle(
                                            color: Color(0xFFAC0000),
                                            fontSize: 18,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.bold,
                                            height: 0),
                                        endTime: DateTime.now().add(Duration(
                                            hours: hours,
                                            minutes: minutes,
                                            seconds: seconds)),
                                        onEnd: () {
                                          // setState(() {
                                          //   isFinishTime = true;
                                          // });
                                          isFinishTime = true;
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
                                  )),
                                ),
                              ),
                            ],
                          ),
                          //////
                          SizedBox(
                            height: 20.sp,
                          ),
                          Center(
                            child: Container(
                              height: 65.sp,
                              width: 350.sp,
                              decoration: BoxDecoration(
                                color: secondaryColor,
                                border:
                                Border.all(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(25),
                                shape: BoxShape.rectangle,
                              ),
                              child: ListTile(
                                leading: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Current Bid',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    Text(
                                      '${auctionValue["value"] ?? 0.0}AED',
                                      style: const TextStyle(
                                        color: Color(0xFF5A0072),
                                        fontSize: 18,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    )
                                  ],
                                ),
                                trailing: Container(
                                    width: 120.sp,
                                    height: 45.sp,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: state.horse.isPayed!
                                        ? InkWell(
                                      onTap: () {
                                        if (isFinishTime) {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  FixerHelper.StartBid(
                                                      widget.auction_id,
                                                      state.horse.id!,
                                                      auctionValue));
                                        } else {
                                          SnackBarHelper.mySnackBar(
                                              "You can start bidding after the remaining start time has expired, Thank you!",
                                              context);
                                        }
                                      },
                                      child:  Center(
                                        child: Text(
                                          'Bid',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    )
                                        : InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {

                                          return    PaymentPage(
                                              auction_id: widget
                                                  .auction_id,
                                              horse_id: widget
                                                  .horse_id);
                                        }));

                                      },
                                      child:  Center(
                                        child: Text(
                                          'Pay Insurance',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 15.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height,
                    child: CircularProgressIndicator(
                      color: Color1,
                    ));
              }
            }),
          ),
        ),
      ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   index: 2,
      //   height: 75.0,
      //   items: <Widget>[
      //     IconButton(
      //       icon: const Icon(
      //         Icons.home_outlined,
      //         size: 30,
      //         color: Colors.grey,
      //       ),
      //       onPressed: () {
      //         setState(() {
      //           selected_page = 0;
      //         });
      //       },
      //     ),
      //     IconButton(
      //       icon: const Icon(
      //         Icons.location_on_outlined,
      //         size: 30,
      //         color: Colors.grey,
      //       ),
      //       onPressed: () {
      //         setState(() {
      //           selected_page = 1;
      //         });
      //       },
      //     ),
      //     Image.asset(
      //       'assets/images/img_9.png',
      //       color: Colors.black,
      //       height: 35,
      //       width: 35,
      //     ),
      //     Image.asset(
      //       'assets/images/img_6.png',
      //       height: 25,
      //       width: 25,
      //     ),
      //     Image.asset(
      //       'assets/images/img_7.png',
      //       height: 25,
      //       width: 25,
      //     ),
      //   ],
      //   color: navBarColor,
      //   buttonBackgroundColor: secondaryColor,
      //   backgroundColor: Colors.white,
      //   animationCurve: Curves.easeInOut,
      //   animationDuration: const Duration(milliseconds: 600),
      //   onTap: (index) {
      //     setState(() {
      //       _page = index;
      //       print(index);
      //     });
      //   },
      //   letIndexChange: (index) => false,
      // ),
    );
  }
}
