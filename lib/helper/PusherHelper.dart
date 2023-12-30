

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:sevin_rm/UI/Screens/HorseDetail/cubit/cubit.dart';
import 'package:sevin_rm/data/sources/endpoints/endpoints.dart';

import '../Core/di/di_manager.dart';
import '../Core/shared_prefs/shared_prefs.dart';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../UI/Screens/HorseDetail/cubit/horse_detail_states.dart';

class PusherHelper extends Cubit<InitialPusher>{
  PusherHelper() : super(InitialPusher(0));
  void changeValue(){
    emit(InitialPusher(5));
  }
  static String appId = /*"1712143"*/
  "1694476";

  static String key = /*'94030f77cb7b05d01ce6'*/

   'c8776a00baa2385708d7';

  static String secret = "1f8c3b6eccc3cf3d27db";
  static String cluster = /*"eu"*/"ap2";
  static Map<String,int> maxAuctionValue = {};

  static String hostEndPoint = "";
  static String hostAuthEndPoint = "";
  static int port = 443;
  static PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  HorseDetailCubit horseDetailCubit = HorseDetailCubit();
  static StreamController<Map<String,int>> streamController = StreamController<Map<String,int>>.broadcast();
  Stream<Map<String,int>> get onValueChanged => streamController.stream;
  void initalize() async {

    try {
      await pusher.init(
        useTLS: true,
        apiKey: PusherHelper.key,
        cluster: PusherHelper.cluster,
        onConnectionStateChange: onConnectionStateChange,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        onSubscriptionCount: onSubscriptionCount,
        // authEndpoint: "<Your Authendpoint Url>",
         onAuthorizer: onAuthorizer,
      );
      await pusher.subscribe(channelName: 'private-bidding');
      await pusher.connect();
    } catch (e) {
      log("ERROR In Pusher: $e");
    }
  }
  static void onTriggerEventPressed(double auction) async {
    pusher.trigger(PusherEvent(
        channelName: "private-bidding",
        eventName: "client-bidding",
        data: auction.toString()));
  }

  static void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection: $currentState");
  }


  void onEvent(PusherEvent event) {
    try {
      log("onEvent: $event");
      if (event.data.isEmpty) {
      } else {
        maxAuctionValue =  Map<String,int>.from(jsonDecode(event.data));
        streamController.add(maxAuctionValue);
        print("maxAuctionValue = $maxAuctionValue");
      }
    }catch(e,s){
      print("Error in Event : $e in $s");
    }
  }

  static void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher
        .getChannel(channelName)
        ?.me;
    log("Me: $me");
  }

  static void onSubscriptionError(String message, dynamic e) {
    log("onSubscriptionError: $message Exception: $e");
  }

  static void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  static void onMemberAdded(String channelName, PusherMember member) {
    log("onMemberAdded: $channelName user: $member");
  }

  static void onMemberRemoved(String channelName, PusherMember member) {
    log("onMemberRemoved: $channelName user: $member");
  }

  static void onSubscriptionCount(String channelName, int subscriptionCount) {
    log(
        "onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
  }
  static dynamic onAuthorizer(String channelName, String socketId, dynamic options) async {
    try {
      Dio dio = Dio();
      print("start Auth==>$socketId");
      Response pusherAuthKey = await dio.post(
        (AppEndpoints.baseUrl + AppEndpoints.authPusher),
        data: {
          "socket_id": socketId
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer  ${DIManager.findDep<SharedPrefs>().getToken()}'},
        ),
      );
      if(pusherAuthKey.statusCode==200){
        print(pusherAuthKey.data);
        return pusherAuthKey.data;
      }
    }catch(e,s){
      print("Error when Auth Pusher is $e in $s");
    }
  }
}