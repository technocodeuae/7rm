import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sevin_rm/helper/snack_bar_helper.dart';

class StartBidController {
  TextEditingController auction = TextEditingController();
  bool validation(Map<String,int> auctionValue , BuildContext context){
    if(auction.text.isNotEmpty&&double.parse(auction.text)>=auctionValue["value"]!.toDouble()){
      return true;
    }else if (auction.text.isEmpty){
      SnackBarHelper.mySnackBar("The Auction Field is Empty", context);
    }else if (double.parse(auction.text)<auctionValue["value"]!.toDouble()){
      SnackBarHelper.mySnackBar("You must raise your bid value", context);
    }
    return false;
  }
}