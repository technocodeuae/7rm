import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:sevin_rm/UI/Screens/component/Widght.dart';
import 'package:sevin_rm/helper/error_dialog_helper.dart';

import '../../UI/Screens/conset/Const.dart';
import '../PusherHelper.dart';
import '../snack_bar_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/start_bid_states.dart';
import 'start_bid_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartBidPage extends StatefulWidget {
  StartBidPage({Key? key, required this.auctionId ,
    required this.horseId , required this.auctionValue}) : super(key: key);
  int auctionId;
  int horseId;
  Map<String,int> auctionValue;
  @override
  State<StartBidPage> createState() => _StartBidPageState();
}

class _StartBidPageState extends State<StartBidPage> {
  StartBidController startBidController = StartBidController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocProvider(
        create: (context) => StartBidCubit(),
        child: BlocConsumer<StartBidCubit,StartBidStates>(
          listener: (context, state) {
            if (state is ErrorStateStartBid) {
              DialogHelper.errorDialog(context, "Error", state.error);
            }else if (state is SuccessStartBid){
              if(state.isBid) {
                Navigator.pop(context);
                SnackBarHelper.mySnackBar("The bidding process was successful", context);
              }else{
                print("Isn't Bid");
                SnackBarHelper.mySnackBar("Auction time has ended", context);
              }
            }
          },
            builder: (context,state) {
            return Container(
              height: MediaQuery.of(context).size.height/2,
              child: AlertDialog(
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25)
                      ),
                      alignment: Alignment.centerRight,
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close , color: Color1,size: 35.sp,)),
                    ),
                    Text("Start Bid" , style: TextStyle(color: Color1 , fontSize: 25.sp)),
                    TextFieldWidght(
                      hintText: "AED ${widget.auctionValue['value'].toString()}",
                        widthC:
                        MediaQuery.of(context).size.width *
                            0.5,
                        heightC:
                        MediaQuery.of(context).size.height *
                            0.08,
                        radius: 15.0,
                        colorBorder: Color1,
                        controller: startBidController.auction,
                        keyboardType: TextInputType.number,
                        colorhint: Color5,
                        widthBorder: 1),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child:
                      state is LoadingStartBid ? Center(child: CircularProgressIndicator(color: Color1))
                          :ButtonStaic(
                          onTap: () async {
                            if(startBidController.validation(widget.auctionValue, context)){
                              BlocProvider.of<StartBidCubit>(context).
                            sendPusher(widget.auctionId, widget.horseId,double.parse(startBidController.auction.text));
                            }
                          },
                          title: "Confirm",
                          colors: [Color1, Color1],
                          radius: 25.0,
                          widthContainer:
                          MediaQuery.of(context).size.width * 0.80,
                          heightContainer: 50.0,
                          boxShadow: [
                            BoxShadow(
                              color: Color1.withOpacity(0.5),
                              spreadRadius: 2.0,
                              blurRadius: 10.0,
                              offset: const Offset(-1, 6),
                            ),
                          ],
                          beginGrident: Alignment.topLeft,
                          endGrident: Alignment.bottomRight,
                          colorText: Color3,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
