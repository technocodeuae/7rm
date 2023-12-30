import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sevin_rm/UI/Screens/HomeScreen/details_package.dart';
import 'package:sevin_rm/UI/Screens/component/Widght.dart';
import 'package:sevin_rm/data/models/stables/stables_information.dart';

import '../../conset/Const.dart';
import '../details_package_for_all.dart';

//
class Screen2 extends StatefulWidget {
  const Screen2({Key? key, this.stableInfoModel,this.stableId}) : super(key: key);
  final StableInformationModel? stableInfoModel;
  final int? stableId;

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  List<bool> _isSelected = [
    true,
    false,
  ];
  int selectedButton = 0;
  bool scrollBool = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15.sp,
            ),
            ToggleButtons(
              isSelected: _isSelected,
              fillColor: Color.fromRGBO(190, 140, 206, 1),
              onPressed: (int index) {
                setState(() {
                  print(index);
                  print(index.toString());
                  if (index == 1) {
                    scrollBool = false;
                  } else {
                    scrollBool = true;
                  }
                  for (int buttonIndex = 0;
                      buttonIndex < _isSelected.length;
                      buttonIndex++) {
                    _isSelected[buttonIndex] = buttonIndex == index;
                  }
                  selectedButton = index;
                });
              },
              children: [
                Container(
                  width: 90.sp,
                  alignment: Alignment.center,
                  child: text(
                      title: "Services",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(33, 35, 39, 1)),
                ),
                Container(
                  width: 130.sp,
                  alignment: Alignment.center,
                  child: text(
                      title: "Package & Offers",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 0.5)),
                ),
                // Container(
                //   width: 90,
                //   alignment: Alignment.center,
                //   child: text(
                //       title: "Services",
                //       fontSize: 14,
                //       fontWeight: FontWeight.w400,
                //       color: Color.fromRGBO(0, 0, 0, 0.5)),
                // ),
                // if(false){print("object");}

                // SizedBox(height: ,)
              ],
            ),
            // secrbool
            //     ? secrbool1 == false
            //         ? Container()
            //         : Column(
            //             children: [
            //               SizedBox(height: 10),
            //               ListView.builder(
            //                 shrinkWrap: true,
            //                 scrollDirection: Axis.vertical,
            //                 itemBuilder: (_, i) {
            //                   return ListTile(
            //                     leading: Container(
            //                       width: 50,
            //                       height: 50,
            //                       decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(8.0),
            //                         gradient: const LinearGradient(
            //                           colors: [
            //                             Color.fromRGBO(90, 0, 114, 1),
            //                             Color.fromRGBO(90, 0, 114, 1)
            //                             // const Color(0xFFFF80AB), // زهري فاتح
            //                             // const Color(0xFFFF4081), // زهري غامق
            //                           ],
            //                           begin: Alignment.topLeft,
            //                           end: Alignment.bottomRight,
            //                         ),
            //                         boxShadow: [
            //                           BoxShadow(
            //                             color: const Color.fromRGBO(90, 0, 114, 1)
            //                                 .withOpacity(0.5),
            //                             spreadRadius: 2.0,
            //                             blurRadius: 10.0,
            //                             offset: const Offset(-1, 6),
            //                           ),
            //                         ],
            //                         image: const DecorationImage(
            //                             scale: 1,
            //                             image: AssetImage(
            //                               'assets/images/main/horse (1) (1).png',
            //                             )),
            //                       ),
            //                       // child: Image.asset(
            //                       //   'assets/images/main/image 69.png',
            //                       //   // fit: BoxFit.cover,
            //                       //   width: MediaQuery.of(context).size.width,
            //                       //   height: MediaQuery.of(context).size.height,
            //                       // ),
            //                     ),
            //                     title: text(
            //                         title: widget
            //                                 .stableInfoModel
            //                                 ?.stableDetails[0]
            //                                 .services[i]
            //                                 .name ??
            //                             "",
            //                         fontSize: 16,
            //                         fontWeight: FontWeight.w400,
            //                         color: const Color.fromRGBO(3, 2, 3, 1)),
            //                     trailing: GestureDetector(
            //                       onTap: () {
            //                         print("llllllll");
            //                         setState(() {
            //                           secrbool = false;
            //                         });
            //                       },
            //                       child: text(
            //                           title: "View",
            //                           fontSize: 16,
            //                           fontWeight: FontWeight.w400,
            //                           color: Color.fromRGBO(90, 60, 98, 1)),
            //                     ),
            //                     // subtitle: Text('النص الفرعي للسطر'),
            //                     // onTap: () {
            //                     //   // تنفيذ الإجراء عند النقر على السطر
            //                     //   print('تم النقر على السطر');
            //                     // },
            //                   );
            //                 },
            //                 itemCount: widget.stableInfoModel?.stableDetails[0]
            //                     .services.length,
            //
            //                 // widget.dataIncludeCategory?.stables.length,
            //               ),
            //               SizedBox(height: 20),
            //             ],
            //           )
            //     :
            //     ///////////////////////////////////////////
            //     secrbool1 == false
            //         ? Container()
            //         : Column(
            //             children: [
            //               SizedBox(height: 10),
            //               ListTile(
            //                 leading: Container(
            //                   width: 50,
            //                   height: 50,
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(8.0),
            //                     gradient: LinearGradient(
            //                       colors: [
            //                         Color.fromRGBO(90, 0, 114, 1),
            //                         Color.fromRGBO(90, 0, 114, 1)
            //                         // const Color(0xFFFF80AB), // زهري فاتح
            //                         // const Color(0xFFFF4081), // زهري غامق
            //                       ],
            //                       begin: Alignment.topLeft,
            //                       end: Alignment.bottomRight,
            //                     ),
            //                     boxShadow: [
            //                       BoxShadow(
            //                         color: Color.fromRGBO(90, 0, 114, 1)
            //                             .withOpacity(0.5),
            //                         spreadRadius: 2.0,
            //                         blurRadius: 10.0,
            //                         offset: Offset(-1, 6),
            //                       ),
            //                     ],
            //                     image: DecorationImage(
            //                         scale: 1,
            //                         image: AssetImage(
            //                           'assets/images/main/horse (1) (1).png',
            //                         )),
            //                   ),
            //                   // child: Image.asset(
            //                   //   'assets/images/main/image 69.png',
            //                   //   // fit: BoxFit.cover,
            //                   //   width: MediaQuery.of(context).size.width,
            //                   //   height: MediaQuery.of(context).size.height,
            //                   // ),
            //                 ),
            //                 title: text(
            //                     title: "Jumping",
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.w400,
            //                     color: Color.fromRGBO(3, 2, 3, 1)),
            //                 trailing:
            //                 Container(
            //                   width: 168,
            //                   height: 60,
            //                   decoration: BoxDecoration(
            //                     color: Color.fromRGBO(190, 140, 206, 1),
            //                     borderRadius: BorderRadius.circular(10),
            //                     border: Border.all(
            //                       color: Colors.white,
            //                       width: 2.0,
            //                     ),
            //                   ),
            //                   child: Column(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     children: [
            //                       DropdownButton<String>(
            //                         underline: null,
            //                         value: selectedOption,
            //                         onChanged: (String? newValue) {
            //                           setState(() {
            //                             selectedOption = newValue;
            //                           });
            //                         },
            //                         items: <String>[
            //                           '1000',
            //                           '2000',
            //                           '3000',
            //                           '4000'
            //                         ].map<DropdownMenuItem<String>>(
            //                             (String value) {
            //                           return DropdownMenuItem<String>(
            //                             value: value,
            //                             child: Row(
            //                               children: [
            //                                 text(
            //                                     title: "price",
            //                                     fontSize: 14,
            //                                     fontWeight: FontWeight.w400,
            //                                     color: Color.fromRGBO(
            //                                         0, 0, 0, 0.87)),
            //                                 SizedBox(
            //                                   width: 15,
            //                                 ),
            //                                 text(
            //                                     title: value,
            //                                     fontSize: 14,
            //                                     fontWeight: FontWeight.w400,
            //                                     color: Color.fromRGBO(
            //                                         0, 0, 0, 0.87)),
            //                               ],
            //                             ),
            //                           );
            //                         }).toList(),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 // subtitle: Text('النص الفرعي للسطر'),
            //                 onTap: () {
            //                   // تنفيذ الإجراء عند النقر على السطر
            //                   print('تم النقر على السطر');
            //                 },
            //               ),
            //               SizedBox(height: 10),
            //               ListTile(
            //                 leading: Container(
            //                   width: 50,
            //                   height: 50,
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(8.0),
            //                     gradient: LinearGradient(
            //                       colors: [
            //                         Color.fromRGBO(90, 0, 114, 1),
            //                         Color.fromRGBO(90, 0, 114, 1)
            //                         // const Color(0xFFFF80AB), // زهري فاتح
            //                         // const Color(0xFFFF4081), // زهري غامق
            //                       ],
            //                       begin: Alignment.topLeft,
            //                       end: Alignment.bottomRight,
            //                     ),
            //                     boxShadow: [
            //                       BoxShadow(
            //                         color: Color.fromRGBO(90, 0, 114, 1)
            //                             .withOpacity(0.5),
            //                         spreadRadius: 2.0,
            //                         blurRadius: 10.0,
            //                         offset: Offset(-1, 6),
            //                       ),
            //                     ],
            //                     image: DecorationImage(
            //                         scale: 1,
            //                         image: AssetImage(
            //                           'assets/images/main/horse-riding.png',
            //                         )),
            //                   ),
            //                   // child: Image.asset(
            //                   //   'assets/images/main/image 69.png',
            //                   //   // fit: BoxFit.cover,
            //                   //   width: MediaQuery.of(context).size.width,
            //                   //   height: MediaQuery.of(context).size.height,
            //                   // ),
            //                 ),
            //                 title: text(
            //                     title: "Cleaning",
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.w400,
            //                     color: Color.fromRGBO(3, 2, 3, 1)),
            //                 trailing: Container(
            //                   width: 168,
            //                   height: 60,
            //                   decoration: BoxDecoration(
            //                     color: Color.fromRGBO(190, 140, 206, 1),
            //                     borderRadius: BorderRadius.circular(10),
            //                     border: Border.all(
            //                       color: Colors.white,
            //                       width: 2.0,
            //                     ),
            //                   ),
            //                   child: Column(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     children: [
            //                       DropdownButton<String>(
            //                         underline: null,
            //                         value: selectedOption1,
            //                         onChanged: (String? newValue) {
            //                           setState(() {
            //                             selectedOption1 = newValue;
            //                           });
            //                         },
            //                         items: <String>[
            //                           '1000',
            //                           '2000',
            //                           '3000',
            //                           '4000'
            //                         ].map<DropdownMenuItem<String>>(
            //                             (String value) {
            //                           return DropdownMenuItem<String>(
            //                             value: value,
            //                             child: Row(
            //                               children: [
            //                                 text(
            //                                     title: "Select type",
            //                                     fontSize: 14,
            //                                     fontWeight: FontWeight.w400,
            //                                     color: Color.fromRGBO(
            //                                         0, 0, 0, 0.4)),
            //                                 SizedBox(
            //                                   width: 15,
            //                                 ),
            //                                 text(
            //                                     title: value,
            //                                     fontSize: 14,
            //                                     fontWeight: FontWeight.w400,
            //                                     color: Color.fromRGBO(
            //                                         0, 0, 0, 0.87)),
            //                               ],
            //                             ),
            //                           );
            //                         }).toList(),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 // subtitle: Text('النص الفرعي للسطر'),
            //                 onTap: () {
            //                   // تنفيذ الإجراء عند النقر على السطر
            //                   print('تم النقر على السطر');
            //                 },
            //               ),
            //               SizedBox(height: 10),
            //               ListTile(
            //                 leading: Container(
            //                   width: 50,
            //                   height: 50,
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(8.0),
            //                     gradient: LinearGradient(
            //                       colors: [
            //                         Color.fromRGBO(90, 0, 114, 1),
            //                         Color.fromRGBO(90, 0, 114, 1)
            //                         // const Color(0xFFFF80AB), // زهري فاتح
            //                         // const Color(0xFFFF4081), // زهري غامق
            //                       ],
            //                       begin: Alignment.topLeft,
            //                       end: Alignment.bottomRight,
            //                     ),
            //                     boxShadow: [
            //                       BoxShadow(
            //                         color: Color.fromRGBO(90, 0, 114, 1)
            //                             .withOpacity(0.5),
            //                         spreadRadius: 2.0,
            //                         blurRadius: 10.0,
            //                         offset: Offset(-1, 6),
            //                       ),
            //                     ],
            //                     image: DecorationImage(
            //                         scale: 1,
            //                         image: AssetImage(
            //                           'assets/images/main/horse.png',
            //                         )),
            //                   ),
            //                   // child: Image.asset(
            //                   //   'assets/images/main/image 69.png',
            //                   //   // fit: BoxFit.cover,
            //                   //   width: MediaQuery.of(context).size.width,
            //                   //   height: MediaQuery.of(context).size.height,
            //                   // ),
            //                 ),
            //                 title: text(
            //                     title: "Cleaning",
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.w400,
            //                     color: Color.fromRGBO(3, 2, 3, 1)),
            //                 trailing: Container(
            //                   width: 168,
            //                   height: 60,
            //                   decoration: BoxDecoration(
            //                     color: Color.fromRGBO(190, 140, 206, 1),
            //                     borderRadius: BorderRadius.circular(10),
            //                     border: Border.all(
            //                       color: Colors.white,
            //                       width: 2.0,
            //                     ),
            //                   ),
            //                   child: Column(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     children: [
            //                       DropdownButton<String>(
            //                         underline: null,
            //                         value: selectedOption2,
            //                         onChanged: (String? newValue) {
            //                           setState(() {
            //                             selectedOption2 = newValue;
            //                           });
            //                         },
            //                         items: <String>[
            //                           '1000',
            //                           '2000',
            //                           '3000',
            //                           '4000'
            //                         ].map<DropdownMenuItem<String>>(
            //                             (String value) {
            //                           return DropdownMenuItem<String>(
            //                             value: value,
            //                             child: Row(
            //                               children: [
            //                                 text(
            //                                     title: "Select type",
            //                                     fontSize: 14,
            //                                     fontWeight: FontWeight.w400,
            //                                     color: Color.fromRGBO(
            //                                         0, 0, 0, 0.4)),
            //                                 SizedBox(
            //                                   width: 15,
            //                                 ),
            //                                 text(
            //                                     title: value,
            //                                     fontSize: 14,
            //                                     fontWeight: FontWeight.w400,
            //                                     color: Color.fromRGBO(
            //                                         0, 0, 0, 0.87)),
            //                               ],
            //                             ),
            //                           );
            //                         }).toList(),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 // subtitle: Text('النص الفرعي للسطر'),
            //                 onTap: () {
            //                   // تنفيذ الإجراء عند النقر على السطر
            //                   print('تم النقر على السطر');
            //                 },
            //               ),
            //             ],
            //           ),

            ////////////////////////////////////
            ///
            if (scrollBool == false)
              Container()
            else
              Column(
                children: [
                  SizedBox(height: 10.sp),
                  Container(
                    height: 900.sp,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (_, i) {
                        return ListTile(
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Color1.withOpacity(0.7),
                            ),
                            // child: Image.asset(
                            //   'assets/images/main/image 69.png',
                            //   // fit: BoxFit.cover,
                            //   width: MediaQuery.of(context).size.width,
                            //   height: MediaQuery.of(context).size.height,
                            // ),
                            child: Image.network(
                              widget.stableInfoModel?.stableServices
                                      [i].imagePath ??
                                  'assets/images/main/7rmlogo.png',
                              fit: BoxFit.fill,
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return Image.asset(
                                    'assets/images/main/7rmlogo.png',
                                    fit: BoxFit.fill);
                              },
                            ),
                          ),
                          title: text(
                              title: widget.stableInfoModel?.stableServices[i].name ??
                                  "",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(3, 2, 3, 1)),
                          trailing: Text(
                            "${widget.stableInfoModel?.stableServices[i].price.toString() ?? ''} "
                            " AED",
                          ),
                          // subtitle: Text('النص الفرعي للسطر'),
                          // onTap: () {
                          //   // تنفيذ الإجراء عند النقر على السطر
                          //   print('تم النقر على السطر');
                          // },
                        );
                      },
                      itemCount: widget
                          .stableInfoModel?.stableServices.length,

                      // widget.dataIncludeCategory?.stables.length,
                    ),
                  ),
                  SizedBox(height: 20.sp),
                ],
              ),

            ///
            scrollBool
                ? Container()
                : Column(
                    children: [
                      SizedBox(
                        height: 4.sp,
                      ),
                      Container(
                        height: 900.sp,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,

                          physics: BouncingScrollPhysics(),
                          itemBuilder: (_, i) {
                            return InkWell(
                              onTap: () {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        DetailsPackagePageForAllPackages(

                                    stableId: widget.stableId ?? 0,

                                      packageId: widget
                                              .stableInfoModel!
                                              .stableDetails?.packages[i]
                                              .id ??
                                          0,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: Container(
                                      height: 230.sp,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.sp))),
                                      child:
                                      // widget
                                      //     .stableInfoModel
                                      //     !.stableDetails[0]
                                      //     .services.isEmpty ?Container():
                                      //
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: (() {
                                              Navigator.push<void>(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder:
                                                      (BuildContext context) =>
                                                          DetailsPackagePageForAllPackages(

                                                  stableId: widget.stableId ?? 0,
                                                    packageId: widget
                                                            .stableInfoModel!
                                                            .stableDetails
                                                            ?.packages[i]
                                                            .id ??
                                                        0,
                                                  ),
                                                ),
                                              );
                                            }),
                                            child: Container(
                                              width: 350.sp,
                                              height: 161.sp,
                                              decoration: BoxDecoration(
                                                color: Colors.yellow,
                                                borderRadius:
                                                    BorderRadius.circular(8.sp),
                                              ),
                                              child: Image.network(
                                                widget
                                                        .stableInfoModel
                                                        ?.stableDetails?.packages[i].image ??
                                                    'assets/images/main/7rmlogo.png',
                                                fit: BoxFit.fill,
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object error,
                                                    StackTrace? stackTrace) {
                                                  return Image.asset(
                                                      'assets/images/main/7rmlogo.png',
                                                      );
                                                },
                                              ),
                                            ),
                                            //
                                            ////
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              children: [
                                                text(
                                                    title: widget
                                                            .stableInfoModel!
                                                            .stableDetails
                                                            ?.packages[i]
                                                            .name
                                                            .toString() ??
                                                        "",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black),
                                                Spacer(),
                                                text(
                                                  title: "Book Now",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      190, 140, 206, 1),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              children: [
                                                text(
                                                    title: widget
                                                            .stableInfoModel!
                                                            .stableDetails
                                                            ?.packages[i]
                                                            .description
                                                            .toString() ??
                                                        "",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.5)),
                                                Spacer(),
                                                text(
                                                    title: widget
                                                                .stableInfoModel!
                                                                .stableDetails!.packages[i]
                                                                .price
                                                                .toString() +
                                                            " AED" ??
                                                        "",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: widget.stableInfoModel?.stableDetails
                              ?.packages.length,

                          // widget.dataIncludeCategory?.stables.length,
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
//////
