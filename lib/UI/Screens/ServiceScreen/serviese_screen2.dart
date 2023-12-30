// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
// import 'package:google_maps_flutter_platform_interface/src/types/ui.dart';
// import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
// import 'package:sevin_rm/UI/Screens/main_screen/main_screen.dart';
// import 'package:sevin_rm/UI/util/app_them.dart';
//
// import '../../../Core/di/di_manager.dart';
// import '../../../Core/shared_prefs/shared_prefs.dart';
// import '../filter/filters.dart';
// import '../search/search_screen.dart';
//
// class TinaerScreen2 extends StatefulWidget {
//   const TinaerScreen2({Key? key}) : super(key: key);
//
//   @override
//   State<TinaerScreen2> createState() => _TinaerScreen2State();
// }
//
// class _TinaerScreen2State extends State<TinaerScreen2> {
//   int _page = 0;
//   List category = [
//     {
//       "image": "assets/images/img_10.png",
//       "text": "Ability &",
//     },
//     {"image": "assets/images/img_10.png", "text": "Flat race"},
//     {"image": "assets/images/img_10.png", "text": "Show horse"},
//     {"image": "assets/images/img_13.png", "text": "Pony"},
//     {
//       "image": "assets/images/img_14.png",
//       "text": "Race",
//     },
//   ];
//
//   String firstName = DIManager.findDep<SharedPrefs>().getUserNamePerson() ?? "";
//   String lastName = DIManager.findDep<SharedPrefs>().getUserNamePerson2() ?? "";
//   double? lat = DIManager.findDep<SharedPrefs>().getMyLocationLat();
//   double? lang = DIManager.findDep<SharedPrefs>().getMyLocationLang();
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           padding: const EdgeInsets.all(10),
//           width: double.infinity,
//           height: double.infinity,
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage('assets/images/img.png'),
//                   fit: BoxFit.fill)),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   width: double.infinity,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Hello, $firstName $lastName",
//                           style: TextStyle(
//                               fontSize: 17, fontWeight: FontWeight.w700)),
//                       Container(
//                         child: Row(
//                           children: [
//                             IconButton(
//                                 onPressed: () {},
//                                 icon: const Icon(
//                                   Icons.notification_add_outlined,
//                                   color: primaryColor,
//                                 )),
//                             IconButton(
//                                 onPressed: () {
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                       builder: (_) => Filters(
//                                             auctionId: 0,
//                                           )));
//                                 },
//                                 icon: Icon(
//                                   Icons.filter_alt,
//                                   color: primaryColor,
//                                   size: 32,
//                                 ))
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 const Text("Your location",
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color(0x66000000),
//                     )),
//                 Container(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextButton.icon(
//                           onPressed: () {},
//                           icon: const Icon(
//                             Icons.location_on,
//                             color: Colors.black,
//                           ),
//                           label: Text(
//                             DIManager.findDep<SharedPrefs>()
//                                 .getYourCountry()
//                                 .toString(),
//                             style: TextStyle(fontSize: 12, color: Colors.black),
//                           )),
//                       TextButton.icon(
//                           onPressed: () async {
//                             showBottomSheet(
//                                 context: context,
//                                 builder: (context) => Container(
//                                       height: 400,
//                                       child: PlacePicker(
//                                         apiKey:
//                                             "AIzaSyBJjDpq0S-cRzOkfeC2NtIvch3sVxXmWjs",
//                                         initialPosition: LatLng(
//                                             DIManager.findDep<SharedPrefs>()
//                                                     .getMyLocationLat() ??
//                                                 45.678902,
//                                             DIManager.findDep<SharedPrefs>()
//                                                     .getMyLocationLang() ??
//                                                 123.456789),
//                                         onCameraMove: (position) {
//                                           print("Position : $position");
//                                         },
//                                         onPlacePicked: (value) {
//                                           print(
//                                               "PLace is : ${value.adrAddress} Name : ${value.name}");
//                                           setState(() {
//                                             if (value.name != null) {
//                                               lat =
//                                                   value.geometry?.location.lat;
//                                               lang =
//                                                   value.geometry?.location.lng;
//                                               setState(() {
//                                                 // location = value.name!;
//                                                 DIManager.findDep<SharedPrefs>()
//                                                     .setYourCountry(
//                                                         value.name!);
//                                               });
//                                               // Navigator.of(context).pop();
//                                             }
//                                           });
//                                         },
//                                         useCurrentLocation: true,
//                                         resizeToAvoidBottomInset: true,
//                                         initialMapType: MapType.normal,
//                                       ),
//                                     ));
//                             // }
//                           },
//                           icon: const Icon(
//                             CupertinoIcons.arrow_up_right_diamond,
//                             color: Colors.black,
//                           ),
//                           label: const Text(
//                             "CHANGE",
//                             style: TextStyle(fontSize: 12, color: Colors.black),
//                           ))
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) {
//                         return SearchScreen();
//                       },
//                     ));
//                   },
//                   child: Container(
//                     height: 36,
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                           // contentPadding: EdgeInsets.all(5),
//                           fillColor: secondaryColor,
//                           filled: true,
//                           enabled: false,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: const BorderSide(color: secondaryColor),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide:
//                                   const BorderSide(color: secondaryColor)),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide:
//                                   const BorderSide(color: secondaryColor)),
//                           prefixIcon: const Icon(
//                             Icons.search_rounded,
//                             color: Colors.black,
//                           ),
//                           suffixIcon: const Icon(
//                             Icons.settings_voice_sharp,
//                             color: Colors.black,
//                           ),
//                           hintText: "Search Flat race, Pony and Stable",
//                           hintStyle: const TextStyle(
//                               fontSize: 14, color: Colors.black)),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Trainer specialists',
//                       style: TextStyle(
//                         color: Color(0xFF5A0072),
//                         fontSize: 18,
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w700,
//                         height: 0,
//                       ),
//                     ),
//                     // Text("View all",
//                     //     style: TextStyle(
//                     //       fontSize: 14,
//                     //     )),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 Container(
//                   height: 15,
//                   width: double.infinity,
//                   child: ListView(
//                     scrollDirection: Axis.horizontal,
//                     shrinkWrap: true,
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(left: 36),
//                         child: Text(
//                           'Jumping',
//                           style: TextStyle(
//                             color: Color(0xFF5A3C62),
//                             fontSize: 11,
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w400,
//                             height: 0,
//                           ),
//                         ),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.only(left: 36),
//                         child: Text(
//                           'Training',
//                           style: TextStyle(
//                             color: Color(0xFF5A3C62),
//                             fontSize: 11,
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w400,
//                             height: 0,
//                           ),
//                         ),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.only(left: 36),
//                         child: Text(
//                           'Rent',
//                           style: TextStyle(
//                             color: Color(0xFF5A3C62),
//                             fontSize: 11,
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w400,
//                             height: 0,
//                           ),
//                         ),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.only(left: 36),
//                         child: Text(
//                           'Cleaning',
//                           style: TextStyle(
//                             color: Color(0xFF5A3C62),
//                             fontSize: 11,
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w400,
//                             height: 0,
//                           ),
//                         ),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.only(left: 36),
//                         child: Text(
//                           'Race',
//                           style: TextStyle(
//                             color: Color(0xFF5A3C62),
//                             fontSize: 11,
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w400,
//                             height: 0,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: 150,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (_, i) {
//                       return Container(
//                         child: Column(
//                           children: [
//                             Container(
//                                 height: 60,
//                                 width: 60,
//                                 padding: const EdgeInsets.all(3),
//                                 margin: const EdgeInsets.symmetric(
//                                     horizontal: 6, vertical: 15),
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     shape: BoxShape.circle,
//                                     border: Border.all(color: Colors.grey)),
//                                 child: const CircleAvatar(
//                                   backgroundImage:
//                                       AssetImage('assets/images/img_16.png'),
//                                 )),
//                             Text(
//                               category[i]['text'],
//                               style: const TextStyle(fontSize: 13),
//                             ) //
//                           ],
//                         ),
//                       );
//                     },
//                     itemCount: category.length,
//                   ),
//                 ),
//                 Text(
//                   'Results found (120)',
//                   style: TextStyle(
//                     color: Color(0xFF23002C),
//                     fontSize: 18,
//                     fontFamily: 'Inter',
//                     fontWeight: FontWeight.w700,
//                     height: 0,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 ListView(
//                   scrollDirection: Axis.vertical,
//                   shrinkWrap: true,
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: 125,
//                       child: Row(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(right: 8),
//                             width: 110,
//                             height: 85,
//                             decoration: const BoxDecoration(
//                               image: DecorationImage(
//                                 image: AssetImage(
//                                     'assets/images/main/image 48 (1).png'),
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 height: 27,
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       'Godolphin Stables',
//                                       style: TextStyle(
//                                         color: Colors.black
//                                             .withOpacity(0.8700000047683716),
//                                         fontSize: 16,
//                                         fontFamily: 'Inter',
//                                         fontWeight: FontWeight.w400,
//                                         height: 0,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 18,
//                                     ),
//                                     TextButton.icon(
//                                       onPressed: () {},
//                                       icon: const Icon(
//                                         Icons.location_on,
//                                         color: Color(0x7F080000),
//                                         size: 12,
//                                       ),
//                                       label: Text(
//                                         '1.2 km',
//                                         style: TextStyle(
//                                           color: Color(0x7F080000),
//                                           fontSize: 12,
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w400,
//                                           height: 0,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 height: 15,
//                                 child: Text(
//                                   '288 McClure Court, Arkansas',
//                                   style: TextStyle(
//                                     color: Colors.black
//                                         .withOpacity(0.4000000059604645),
//                                     fontSize: 12,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w400,
//                                     height: 0,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 height: 28,
//                                 child: TextButton.icon(
//                                   onPressed: () {},
//                                   icon: const Icon(
//                                     Icons.star_rate,
//                                     color: Colors.yellow,
//                                     size: 12,
//                                   ),
//                                   label: Text(
//                                     '4.0',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 13,
//                                       fontFamily: 'Inter',
//                                       fontWeight: FontWeight.w400,
//                                       height: 0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 height: 13,
//                                 child: Text(
//                                   '8:30 am - 9:00pm',
//                                   style: TextStyle(
//                                     color: Color(0xFF5A0072),
//                                     fontSize: 13,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w400,
//                                     height: 0,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                     Container(
//                       width: double.infinity,
//                       height: 125,
//                       child: Row(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(right: 8),
//                             width: 110,
//                             height: 85,
//                             decoration: const BoxDecoration(
//                               image: DecorationImage(
//                                 image: AssetImage(
//                                     'assets/images/main/image 49 (1).png'),
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 height: 27,
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       'Godolphin Stables',
//                                       style: TextStyle(
//                                         color: Colors.black
//                                             .withOpacity(0.8700000047683716),
//                                         fontSize: 16,
//                                         fontFamily: 'Inter',
//                                         fontWeight: FontWeight.w400,
//                                         height: 0,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 18,
//                                     ),
//                                     TextButton.icon(
//                                       onPressed: () {},
//                                       icon: const Icon(
//                                         Icons.location_on,
//                                         color: Color(0x7F080000),
//                                         size: 12,
//                                       ),
//                                       label: Text(
//                                         '1.2 km',
//                                         style: TextStyle(
//                                           color: Color(0x7F080000),
//                                           fontSize: 12,
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w400,
//                                           height: 0,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 height: 15,
//                                 child: Text(
//                                   '288 McClure Court, Arkansas',
//                                   style: TextStyle(
//                                     color: Colors.black
//                                         .withOpacity(0.4000000059604645),
//                                     fontSize: 12,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w400,
//                                     height: 0,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 height: 28,
//                                 child: TextButton.icon(
//                                   onPressed: () {},
//                                   icon: const Icon(
//                                     Icons.star_rate,
//                                     color: Colors.yellow,
//                                     size: 12,
//                                   ),
//                                   label: Text(
//                                     '4.0',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 13,
//                                       fontFamily: 'Inter',
//                                       fontWeight: FontWeight.w400,
//                                       height: 0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 height: 13,
//                                 child: Text(
//                                   '8:30 am - 9:00pm',
//                                   style: TextStyle(
//                                     color: Color(0xFF5A0072),
//                                     fontSize: 13,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w400,
//                                     height: 0,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                     Container(
//                       width: double.infinity,
//                       height: 125,
//                       child: Row(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(right: 8),
//                             width: 110,
//                             height: 85,
//                             decoration: const BoxDecoration(
//                               image: DecorationImage(
//                                 image: AssetImage(
//                                     'assets/images/main/image 50 (1).png'),
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 height: 27,
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       'Godolphin Stables',
//                                       style: TextStyle(
//                                         color: Colors.black
//                                             .withOpacity(0.8700000047683716),
//                                         fontSize: 16,
//                                         fontFamily: 'Inter',
//                                         fontWeight: FontWeight.w400,
//                                         height: 0,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 18,
//                                     ),
//                                     TextButton.icon(
//                                       onPressed: () {},
//                                       icon: const Icon(
//                                         Icons.location_on,
//                                         color: Color(0x7F080000),
//                                         size: 12,
//                                       ),
//                                       label: Text(
//                                         '1.2 km',
//                                         style: TextStyle(
//                                           color: Color(0x7F080000),
//                                           fontSize: 12,
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w400,
//                                           height: 0,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 height: 15,
//                                 child: Text(
//                                   '288 McClure Court, Arkansas',
//                                   style: TextStyle(
//                                     color: Colors.black
//                                         .withOpacity(0.4000000059604645),
//                                     fontSize: 12,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w400,
//                                     height: 0,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 height: 28,
//                                 child: TextButton.icon(
//                                   onPressed: () {},
//                                   icon: const Icon(
//                                     Icons.star_rate,
//                                     color: Colors.yellow,
//                                     size: 12,
//                                   ),
//                                   label: Text(
//                                     '4.0',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 13,
//                                       fontFamily: 'Inter',
//                                       fontWeight: FontWeight.w400,
//                                       height: 0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 height: 13,
//                                 child: Text(
//                                   '8:30 am - 9:00pm',
//                                   style: TextStyle(
//                                     color: Color(0xFF5A0072),
//                                     fontSize: 13,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w400,
//                                     height: 0,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                     Container(
//                       width: double.infinity,
//                       height: 125,
//                       child: Row(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(right: 8),
//                             width: 110,
//                             height: 85,
//                             decoration: const BoxDecoration(
//                               image: DecorationImage(
//                                 image: AssetImage('assets/images/img_22.png'),
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 height: 27,
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       'Godolphin Stables',
//                                       style: TextStyle(
//                                         color: Colors.black
//                                             .withOpacity(0.8700000047683716),
//                                         fontSize: 16,
//                                         fontFamily: 'Inter',
//                                         fontWeight: FontWeight.w400,
//                                         height: 0,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 18,
//                                     ),
//                                     TextButton.icon(
//                                       onPressed: () {},
//                                       icon: const Icon(
//                                         Icons.location_on,
//                                         color: Color(0x7F080000),
//                                         size: 12,
//                                       ),
//                                       label: Text(
//                                         '1.2 km',
//                                         style: TextStyle(
//                                           color: Color(0x7F080000),
//                                           fontSize: 12,
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w400,
//                                           height: 0,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 height: 15,
//                                 child: Text(
//                                   '288 McClure Court, Arkansas',
//                                   style: TextStyle(
//                                     color: Colors.black
//                                         .withOpacity(0.4000000059604645),
//                                     fontSize: 12,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w400,
//                                     height: 0,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 height: 28,
//                                 child: TextButton.icon(
//                                   onPressed: () {},
//                                   icon: const Icon(
//                                     Icons.star_rate,
//                                     color: Colors.yellow,
//                                     size: 12,
//                                   ),
//                                   label: Text(
//                                     '4.0',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 13,
//                                       fontFamily: 'Inter',
//                                       fontWeight: FontWeight.w400,
//                                       height: 0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 height: 13,
//                                 child: Text(
//                                   '8:30 am - 9:00pm',
//                                   style: TextStyle(
//                                     color: Color(0xFF5A0072),
//                                     fontSize: 13,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w400,
//                                     height: 0,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                     Container(
//                       width: double.infinity,
//                       height: 125,
//                       child: Row(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(right: 8),
//                             width: 110,
//                             height: 85,
//                             decoration: const BoxDecoration(
//                               image: DecorationImage(
//                                 image: AssetImage('assets/images/img_22.png'),
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 height: 27,
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       'Godolphin Stables',
//                                       style: TextStyle(
//                                         color: Colors.black
//                                             .withOpacity(0.8700000047683716),
//                                         fontSize: 16,
//                                         fontFamily: 'Inter',
//                                         fontWeight: FontWeight.w400,
//                                         height: 0,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 18,
//                                     ),
//                                     TextButton.icon(
//                                       onPressed: () {},
//                                       icon: const Icon(
//                                         Icons.location_on,
//                                         color: Color(0x7F080000),
//                                         size: 12,
//                                       ),
//                                       label: Text(
//                                         '1.2 km',
//                                         style: TextStyle(
//                                           color: Color(0x7F080000),
//                                           fontSize: 12,
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w400,
//                                           height: 0,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 height: 15,
//                                 child: Text(
//                                   '288 McClure Court, Arkansas',
//                                   style: TextStyle(
//                                     color: Colors.black
//                                         .withOpacity(0.4000000059604645),
//                                     fontSize: 12,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w400,
//                                     height: 0,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 height: 28,
//                                 child: TextButton.icon(
//                                   onPressed: () {},
//                                   icon: const Icon(
//                                     Icons.star_rate,
//                                     color: Colors.yellow,
//                                     size: 12,
//                                   ),
//                                   label: Text(
//                                     '4.0',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 13,
//                                       fontFamily: 'Inter',
//                                       fontWeight: FontWeight.w400,
//                                       height: 0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 height: 13,
//                                 child: Text(
//                                   '8:30 am - 9:00pm',
//                                   style: TextStyle(
//                                     color: Color(0xFF5A0072),
//                                     fontSize: 13,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w400,
//                                     height: 0,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         drawer: const Drawer(),
//         // bottomNavigationBar: CurvedNavigationBar(
//         // index: 2,
//         // height: 75.0,
//         // items: <Widget>[
//         // const Icon(
//         // Icons.home_outlined,
//         // size: 30,
//         // color: Colors.grey,
//         // ),
//         // const Icon(
//         // Icons.location_on_outlined,
//         // size: 30,
//         // color: Colors.grey,
//         // ),
//         // Image.asset(
//         // 'assets/images/img_9.png',
//         // color: Colors.black,
//         // height: 35,
//         // width: 35,
//         // ),
//         // Image.asset(
//         // 'assets/images/img_6.png',
//         // height: 25,
//         // width: 25,
//         // ),
//         // Image.asset(
//         // 'assets/images/img_7.png',
//         // height: 25,
//         // width: 25,
//         // ),
//         // ],
//         // color: navBarColor,
//         // buttonBackgroundColor: secondaryColor,
//         // backgroundColor: Colors.white,
//         // animationCurve: Curves.easeInOut,
//         // animationDuration: const Duration(milliseconds: 600),
//         // onTap: (index) {
//         // setState(() {
//         // _page = index;
//         // print(index);
//         // });
//         // },
//         // letIndexChange: (index) => false,
//         // ),
//
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: Color.fromRGBO(190, 140, 206, 1),
//           onPressed: () {
//             Navigator.push<void>(
//               context,
//               MaterialPageRoute<void>(
//                 builder: (BuildContext context) => MainScreen(pagep: 1),
//               ),
//             );
//           },
//           child: const Icon(
//             Icons.map_outlined,
//           ),
//         ),
//       ),
//     );
//   }
// }
