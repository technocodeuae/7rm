import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../UI/Screens/conset/Const.dart';
import 'DialogMapPicker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'ShowLocation.dart';
import 'StartBid/start_bid.dart';

class FixerHelper{

  static String convertingDateTimeIntoOriginalFormat(String date){
    DateTime originaldatetime = DateTime.parse(date);
    String formattedDate = DateFormat('dd MMMM yyyy').format(originaldatetime);
    return formattedDate;
  }
  static Widget MakeMapDialog(String nameLocation , LatLng latLng){
    return DialogMapPicker(latlang: latLng , nameLocation : nameLocation);
  }
  static Widget StartBid(int auctionId , int horseId,
      Map<String,int> auctionValue){
    return StartBidPage(auctionId: auctionId,horseId: horseId,
    auctionValue: auctionValue,);
  }

  static Widget selectLocation(){
    return const SelectYourLocation();
  }

}