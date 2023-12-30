/*
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/app_them.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class Location extends StatefulWidget {
   Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(//
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/img.png'), fit: BoxFit.fill)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Hello, John Doe",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                Container(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notification_add_outlined,
                            color: primaryColor,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.filter_alt,
                            color: primaryColor,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: const Text("Your location",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0x66000000),
                )),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Abu Dhabi",
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    )),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.arrow_up_right_diamond,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "CHANGE",
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              decoration: InputDecoration(
                  // contentPadding: EdgeInsets.all(5),
                  fillColor: secondaryColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: secondaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: secondaryColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: secondaryColor)),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: Colors.black,
                  ),
                  suffixIcon: const Icon(
                    Icons.settings_voice_sharp,
                    color: Colors.black,
                  ),
                  hintText: "Search Flat race, Pony and Stable",
                  hintStyle:
                      const TextStyle(fontSize: 14, color: Colors.black)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: GoogleMap(initialCameraPosition:_kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 220,
                      padding: EdgeInsets.only(bottom: 20),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, i) {
                          return Container(
                            width: 230,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  const BoxShadow(
                                      color: Color(0x80BE8FFF),
                                      blurRadius: 5,
                                      offset: Offset(3, 5))
                                ]),
                            child: Stack(
                              children: [
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 230,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/img_15.png"),
                                              fit: BoxFit.fill),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text(
                                            "Al Jiyad Stables",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          TextButton.icon(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.star_rate,
                                                color: Colors.amber,
                                              ),
                                              label: const Text(
                                                '5.0',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ))
                                        ],
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "288 McClure Court, Arkansasgffrehhhheeeeee",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            topLeft: Radius.circular(10))),
                                    child: const Text("Book",
                                        style: TextStyle(
                                          fontSize: 14,
                                        )),
                                  ),
                                  bottom: 0,
                                  right: 0,
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: 5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: () {
// Sli
        },
        child: Icon(
          Icons.menu,
          color: Colors.white,
        ),
      ),
    );
  }
}
*/
