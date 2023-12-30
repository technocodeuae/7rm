import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sevin_rm/UI/Screens/conset/Const.dart';
import 'package:sevin_rm/UI/util/app_them.dart';
import 'package:sevin_rm/helper/error_dialog_helper.dart';

//
import '../../../data/models/auctions/all_my_auctions.dart';
import 'cubit/cubit.dart';
import 'cubit/my_auctions_states.dart';

class MyAuctionsPage extends StatefulWidget {
  const MyAuctionsPage({Key? key}) : super(key: key);

  @override
  State<MyAuctionsPage> createState() => _MyAuctionsPageState();
}

class _MyAuctionsPageState extends State<MyAuctionsPage> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 500.0);
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
  }

//////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          'assets/images/img.png',
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50.sp,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 25.sp,
                        color: primaryColor,
                      )),
                  SizedBox(
                    width: 80.sp,
                  ),
                  Text("My Auctions",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 20.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      )),
                ],
              ),
              BlocProvider(
                create: (context) => MyAuctionsCubit(),
                child: BlocConsumer<MyAuctionsCubit, MyAuctionsState>(
                  listener: (context, state) {
                    if (state is ErrorStateMyAuctions) {
                      DialogHelper.errorDialog(context, "Error", state.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is InitialStatesMyAuctions) {
                      BlocProvider.of<MyAuctionsCubit>(context)
                          .getAllMyAuctions();
                      return Center(
                          child: CircularProgressIndicator(color: Color1));
                    } else if (state is SuccessStatesMyAuctions) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            controller: _scrollController,
                            reverse: state.myAuctions.auctions!.length < 7
                                ? false
                                : true,
                            physics: BouncingScrollPhysics(),
                            itemCount: state.myAuctions.auctions!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  _showBottomSheet(
                                      context, state.myAuctions, index);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 100.h,
                                        height: 100.h,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          //dataBestStables!.stables!

                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                        ),
                                        child: Image.network(
                                          state.myAuctions.auctions![index]
                                                  .highestBid!.horse!.imageId ??
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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  state
                                                          .myAuctions
                                                          .auctions![index]
                                                          .highestBid!
                                                          .horse!
                                                          .name ??
                                                      "",
                                                  style: TextStyle(
                                                      fontSize: 20.sp),
                                                ),
                                                SizedBox(
                                                  height: 2.sp,
                                                ),
                                                // Container(
                                                //   width: 180.sp,
                                                //   child: Text(
                                                //     state.myAuctions.auctions![index].highestBid!.horse!.description??"",
                                                //     style: TextStyle(
                                                //       fontSize: 12.sp,
                                                //     ),
                                                //     overflow: TextOverflow.ellipsis,
                                                //     softWrap: true,
                                                //     maxLines: 1,
                                                //   ),
                                                // ),
                                                SizedBox(
                                                  height: 2.sp,
                                                ),
                                                Text(
                                                  "Owner: ${state.myAuctions.auctions![index].highestBid!.horse!.owner ?? ""}",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  maxLines: 1,
                                                ),
                                                SizedBox(
                                                  height: 2.sp,
                                                ),
                                                Text(
                                                  "Mobile Owner: ${state.myAuctions.auctions![index].highestBid!.horse!.ownerMobile ?? ""}",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  maxLines: 1,
                                                ),

                                                SizedBox(
                                                  height: 2.sp,
                                                ),
                                                Text(
                                                  "Bid price: ${state.myAuctions.auctions![index].highestBid!.value ?? ""} AED",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  maxLines: 1,
                                                ),
                                                SizedBox(
                                                  height: 2.sp,
                                                ),
                                                Container(
                                                  width: 180.sp,
                                                  child: Text(
                                                    "Address: ${state.myAuctions.auctions![index].highestBid!.horse!.adress ?? ""}",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Color1,
                      ));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  void _showBottomSheet(
      BuildContext context, MyAuctions myAuctions, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          // color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    // width: 100.h,
                    height: 150.h,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      //dataBestStables!.stables!

                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: Image.network(
                      myAuctions.auctions![index].highestBid!.horse!.imageId ??
                          'assets/images/main/7rmlogo.png',
                      fit: BoxFit.fill,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return Image.asset('assets/images/main/7rmlogo.png',
                            fit: BoxFit.fill);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.sp, left: 20.sp),
                    child: Text(
                      myAuctions.auctions![index].highestBid!.horse!.name ?? "",
                      style: TextStyle(fontSize: 40.sp, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15.sp,
                    ),
                    Row(
                      children: [
                        Text(
                          "Owner: ${myAuctions.auctions![index].highestBid!.horse?.owner ?? ""}",
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 1,
                        ),
                        SizedBox(
                          width: 15.sp,
                        ),
                        Text(
                          " ${myAuctions.auctions![index].highestBid!.horse?.ownerMobile ?? ""}",
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.sp,
                    ),
                    Container(
                      width: 400.sp,
                      child: Text(
                        "${myAuctions.auctions![index].highestBid!.horse!.description ?? ""}",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
                    ),
                    //gender": "Stallion",
                    //"color": "Brown",
                    //"location": "The Royal Stables",
                    //owner": "The Royal Stables",
                    //                     "owner_mobile": "095858259",
                    //                     "price": "5000.00",
                    //                     "adress": "Dubai, Sheikh Zayed Road,\r\nTrade Center DIFC Trade Center 1",
                    //                     "start_time": "2023-11-22 21:00:00",
                    //                     "end_time": "2023-11-22 23:00:00",
                    //                     "birth_date": "2023-11-17 05:31:46",

                    SizedBox(
                      height: 15.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Gender: ${myAuctions.auctions![index].highestBid!.horse?.gender ?? ""}",
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 1,
                        ),
                        Text(
                          "Color: ${myAuctions.auctions![index].highestBid!.horse?.color ?? ""}",
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    // SizedBox(height: 5.sp,),
                    Text(
                      "Birth Date: ${myAuctions.auctions![index].highestBid!.horse?.birthDate ?? ""}",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Text(
                      "Price Bid: ${myAuctions.auctions![index].highestBid!.value ?? ""} AED",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    // SizedBox(height: 5.sp,),
                    Text(
                      "Bidding Time: ${myAuctions.auctions![index].highestBid!.biddingTime ?? ""}",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(
                      height: 15.sp,
                    ),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Start time: ${myAuctions.auctions![index].highestBid!.horse?.startTime ?? ""}",
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          "End time:   ${myAuctions.auctions![index].highestBid!.horse?.endTime ?? ""}",
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
