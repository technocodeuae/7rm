// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sevin_rm/UI/Screens/component/Widght.dart';
//
// import '../../../data/models/stables/stables_information.dart';
// import '../booking/cubit/cubit.dart';
// import '../booking/cubit/states.dart';
// import '../conset/Const.dart';
// import 'booking_packages.dart';
// import 'package:flutter_bloc/src/bloc_consumer.dart';
// import 'package:flutter_bloc/src/bloc_provider.dart';
// class DetailsPackagePage extends StatefulWidget {
//   const DetailsPackagePage({
//     Key? key,
//     this.imagename,
//     required this.packageId,
//     required this.stableId,
//     this.counterId,
//   }) : super(key: key);
//   final String? imagename;
//   final int? counterId;
//   final int? packageId;
//   final int stableId;
//
//   @override
//   State<DetailsPackagePage> createState() => _DetailsPackagePageState();
// }
//
// class _DetailsPackagePageState extends State<DetailsPackagePage> {
//   int sumPrice = 0;
//
//
//
//   @override
//   void initState() {
//     // totalPrice();
//     super.initState();
//   }
//
//   List<String> items = ['خيار 1', 'خيار 2', 'خيار 3'];
//
//   // القيمة المحددة حاليًا
//   String selectedValue = 'خيار 1';
//   StableInformationModel? stableInfoModel;
//
//   @override
//   Widget build(BuildContext context) {
//     print("widget.stableId:${widget.stableId}");
//     return BlocProvider(
//       create: (context) =>
//       BookingCubitPage()..getStableInformation(stableId: widget.stableId),
//       child: BlocConsumer<BookingCubitPage, BookingCubitPageStates>(
//         listener: (BuildContext context, state) {
//           if (state is GetStableInformationSuccessStates) {
//             print(state.stableInformationModel.message);
//             stableInfoModel = state.stableInformationModel;
//
//
//
//             print(sumPrice);
//             print(stableInfoModel);
//           }
//           //
//           // if(state is GetStableInformationSuccessStates){
//           //   print(state.bookingAvailableTimes.message);
//           //   bookingAvailableTimes =state.bookingAvailableTimes;
//           //   print(bookingAvailableTimes?.specialistsAvailableTimes.length);
//           // }
//         },
//         builder: (BuildContext context, state) {
//
//             var package = stableInfoModel?.stableDetails[0].packages.length ?? 0;
//             for (int i = 0; i < package; i++) {
//               sumPrice += stableInfoModel!.stableDetails[0]
//                   .packages[widget.counterId ??1].price ??
//                   0;
//             }
//
//           print(sumPrice);
//     return Scaffold(
//       body: state is GetStableInformationLoadingStates ? Center(
//         child: CircularProgressIndicator(
//           color: Color1,
//         ),
//       ): Column(
//         children: [
//           Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.5),
//                     spreadRadius: 5,
//                     blurRadius: 7,
//                     offset: Offset(0, -6),
//                   ),
//                 ],
//               ),
//               // color: Colors.yellow,
//               child: Stack(children: [
//                 stableInfoModel!.stableImages.isEmpty ?Container():  Container(
//                   child: Image.network(
//                     stableInfoModel?.stableImages[0].toString() ?? "",
//                     errorBuilder: (context, error, stackTrace) {
//                       return Center(
//                         child: Image.asset(
//                           'assets/images/main/7rmlogo.png',
//                         ),
//                       );
//                     },
//                     fit: BoxFit.cover,
//                     width: MediaQuery.of(context).size.width,
//                     // height: MediaQuery.of(context).size.height,
//                     height: 220.sp,
//                   ),
//                 ),
//                 Scaffold(
//                   backgroundColor: Colors.transparent,
//                   appBar: AppBar(
//                     backgroundColor: Colors.transparent,
//                     elevation: 0.0,
//                     leading: IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: Icon(
//                           Icons.arrow_back,
//                           color: Colors.white,
//                         )),
//                   ),
//                   body: Column(
//                     children: [
//                       SizedBox(
//                         height: 120.sp,
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width,
//                         height: 553.sp,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(30.sp),
//                                 topRight: Radius.circular(30.sp))),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 15.sp, vertical: 15.sp),
//                           child: SingleChildScrollView(
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(
//                                     height: 10.sp,
//                                   ),
//                                   text(
//                                       title: stableInfoModel
//                                               ?.stableDetails[0]
//                                               .packages[widget.counterId ?? 0]
//                                               .name ??
//                                           '',
//                                       color: Color.fromRGBO(90, 0, 114, 1),
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w700),
//                                   SizedBox(
//                                     height: 40.sp,
//                                   ),
//                                   text(
//                                       title: stableInfoModel
//                                               ?.stableDetails[0]
//                                               .packages[widget.counterId ?? 1]
//                                               .description ??
//                                           '',
//                                       color: Colors.black,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400),
//                                   SizedBox(
//                                     height: 50.sp,
//                                   ),
//                                   Row(
//                                     children: [
//                                       text(
//                                           title: "Service",
//                                           color: Color.fromRGBO(90, 0, 114, 1),
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w700),
//                                       Spacer(),
//                                       Container(
//                                         child: Row(children: [
//                                           text(
//                                               title: "Total: ",
//                                               color: Colors.black,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w400),
//                                           text(
//                                               title: '$sumPrice AED',
//                                               color:
//                                                   Color.fromRGBO(90, 0, 114, 1),
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w400),
//                                         ]),
//                                       )
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 27.sp,
//                                   ),
//
//                                   Container(
//                                     height: 100.sp,
//                                     child: ListView.builder(
//                                         itemCount: stableInfoModel
//                                             ?.stableDetails[0]
//                                             .packages[widget.counterId ?? 1]
//                                             .packageServices
//                                             .length,
//                                         itemBuilder: (context, index) {
//                                           return Column(
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       // Container(
//                                                       //   width: 10.sp,
//                                                       //   height: 10.sp,
//                                                       //   child:  Image.network(
//                                                       //
//                                                       //     widget
//                                                       //         .stableInfoModel
//                                                       //         ?.stableDetails[
//                                                       //     0]
//                                                       //         .packages[widget
//                                                       //         .counterId]
//                                                       //         .packageServices[
//                                                       //     index]
//                                                       //         .items ??
//                                                       //         '',
//                                                       //     errorBuilder: (context,
//                                                       //         error, stackTrace) {
//                                                       //       return Center(
//                                                       //         child: Image.asset(
//                                                       //           'assets/images/main/7rmlogo.png',
//                                                       //         ),
//                                                       //       ); ////
//                                                       //     },
//                                                       //     // 'assets/images/main/Component 47 – 1.png',
//                                                       //     // fit: BoxFit.cover,
//                                                       //     width: 20,
//                                                       //     height: 20,
//                                                       //   ),
//                                                       // ),
//
//                                                       Container(
//                                                         width: 10.sp,
//                                                         height: 10.sp,
//                                                         decoration: BoxDecoration(
//                                                             color: Color1,
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         40)),
//                                                       ),
//                                                       SizedBox(
//                                                         width: 10.w,
//                                                       ),
//                                                       text(
//                                                           title: stableInfoModel
//                                                                   ?.stableDetails[
//                                                                       0]
//                                                                   .packages[
//                                                                       widget.counterId ??
//                                                                           1]
//                                                                   .packageServices[
//                                                                       index]
//                                                                   .name ??
//                                                               'undefined',
//                                                           color: Color.fromRGBO(
//                                                               90, 0, 114, 1),
//                                                           fontSize: 15,
//                                                           fontWeight:
//                                                               FontWeight.w400),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: 5.h,
//                                               ),
//                                             ],
//                                           );
//                                         }),
//                                   ),
//
//                                   // SizedBox(
//                                   //   height: 24,
//                                   // ),
//                                   // Row(
//                                   //   children: [
//                                   //     Row(
//                                   //       children: [
//                                   //         Image.asset(
//                                   //           'assets/images/main/Component 47 – 1.png',
//                                   //           // fit: BoxFit.cover,
//                                   //           width: 20,
//                                   //           height: 20,
//                                   //         ),
//                                   //         text(
//                                   //             title: " Water",
//                                   //             color:
//                                   //                 Color.fromRGBO(90, 0, 114, 1),
//                                   //             fontSize: 15,
//                                   //             fontWeight: FontWeight.w400),
//                                   //       ],
//                                   //     ),
//                                   //     Spacer()
//                                   //   ],
//                                   // ),
//                                   // SizedBox(
//                                   //   height: 193,
//                                   // ),
//                                   SizedBox(
//                                     height: 120.h,
//                                   ),
//                                   Center(
//                                     child: InkWell(
//                                       onTap: () {
//                                         print(stableInfoModel!
//                                                 .stableDetails[0].id ??
//                                             0);
//                                         print(widget.packageId);
//                                         Navigator.of(context).push(
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     BookingPackagesPage(
//                                                       stableId: stableInfoModel!
//                                                               .stableDetails[0]
//                                                               .id ??
//                                                           0,
//                                                       packageId:
//                                                           widget.packageId,
//                                                     )));
//                                       },
//                                       child: Container(
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 0.80,
//                                         height: 50.0,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(25.0),
//                                           gradient: LinearGradient(
//                                             colors: [
//                                               Color.fromRGBO(90, 0, 114, 1),
//                                               Color.fromRGBO(90, 0, 114, 1)
//                                               // const Color(0xFFFF80AB), // زهري فاتح
//                                               // const Color(0xFFFF4081), // زهري غامق
//                                             ],
//                                             begin: Alignment.topLeft,
//                                             end: Alignment.bottomRight,
//                                           ),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color:
//                                                   Color.fromRGBO(90, 0, 114, 1)
//                                                       .withOpacity(0.5),
//                                               spreadRadius: 2.0,
//                                               blurRadius: 10.0,
//                                               offset: Offset(-1, 6),
//                                             ),
//                                           ],
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             "Book now",
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 16.0,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ]),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ])),
//           // Container(
//           //   width: MediaQuery.of(context).size.width,
//           //   height: 400,
//           //   color: Colors.yellow,
//           // )
//         ],
//       ),
//     );
//   },
// ),
// );
//   }
// }
