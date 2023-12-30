import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/bloc_consumer.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/package/all_package_model.dart';
import '../../../data/models/stables/stables_information.dart';
import '../../../helper/error_dialog_helper.dart';
import '../../../helper/snack_bar_helper.dart';
import '../../util/app_them.dart';
import '../HomeScreen/details_package.dart';
import '../HomeScreen/details_package_for_all.dart';
import '../conset/Const.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class PackagePage extends StatefulWidget {
   PackagePage({super.key,});


  @override
  State<PackagePage> createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {
  AllPackagesModel? allPackagesModel;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocProvider(
        create: (context) => AllPackageCubitPage()..getAllPackages(),
        child: BlocConsumer<AllPackageCubitPage, PackageCubitPageStates>(
          listener: (context, state) {
            if (state is GetPackagesErrorStates) {
              DialogHelper.errorDialog(
                  context, "Error", state.error.toString());
            }
            if (state is GetPackagesSuccessStates) {
              allPackagesModel = state.allPackagesModel;
              print(state.allPackagesModel);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Image.asset(
                  'assets/images/img.png',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                state is GetPackagesSuccessStates
                    ? Column(
                        children: [
                          SizedBox(
                            height: 35.h,
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
                                width: 60.w,
                              ),
                              Text(
                                "Package & Offers",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 20.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 720.h,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: state
                                    .allPackagesModel.data.length,
                                itemBuilder: (_, i) {
                                  return InkWell(
                                    onTap: () {

                                      if(state.allPackagesModel
                                          .data[i]
                                          .stables.isNotEmpty) {
                                        Navigator.push<void>(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                DetailsPackagePageForAllPackages(
                                                  stableId: state
                                                      .allPackagesModel
                                                      .data[i]
                                                      .stables[0]
                                                      .id ?? 0,

                                                  packageId: state.allPackagesModel
                                                      .data[i].id ??
                                                      0,
                                                ),
                                          ),
                                        );
                                      } else
                                          {
                                            SnackBarHelper.mySnackBar("This Package don't available", context);
                                          }

                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      padding: EdgeInsets.only(bottom: 10),
                                      width: MediaQuery.of(context).size.width /
                                          1.1,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            const BoxShadow(
                                                color: Color(0x80BE8FFF),
                                                blurRadius: 8,
                                                offset: Offset(3, 5))
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                ////////
                                                width: double.infinity,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Image.network(
                                                  state
                                                          .allPackagesModel
                                                          .data[i]
                                                          .image ??
                                                      "",
                                                  fit: BoxFit.fill,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Center(
                                                      child: Image.asset(
                                                        'assets/images/main/7rmlogo.png',
                                                      ),
                                                    );
                                                  },
                                                  // width: MediaQuery.of(context).size.width,
                                                  // height: MediaQuery.of(context).size.height,
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 185,
                                                      child: Text(
                                                        "LOOK AWESOME & SAVE MORE DISCOUNT",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                      width: 100,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "Book Now",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        239,
                                                                        191,
                                                                        255,
                                                                        1)),
                                                          ),
                                                          Text(
                                                            state
                                                                    .allPackagesModel
                                                                    .data[
                                                                        i]
                                                                    .price
                                                                    .toString() ??
                                                                "0",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Padding(
                                          //   padding: EdgeInsets.symmetric(
                                          //       horizontal: 8),
                                          //   child: Row(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment
                                          //             .spaceBetween,
                                          //     children: [
                                          //       Text(
                                          //         state
                                          //                 .allPackagesModel
                                          //                 .formattedPackages[i]
                                          //                 .name ??
                                          //             "",
                                          //         style: TextStyle(
                                          //             fontSize: 15,
                                          //             overflow: TextOverflow
                                          //                 .ellipsis),
                                          //       ),
                                          //       TextButton.icon(
                                          //           onPressed: () {},
                                          //           icon: const Icon(
                                          //             Icons.star_rate,
                                          //             color: Colors.amber,
                                          //           ),
                                          //           label: const Text(
                                          //             '5.0',
                                          //             style: TextStyle(
                                          //                 color: Colors.black),
                                          //           ))
                                          //     ],
                                          //   ),
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              state
                                                      .allPackagesModel
                                                      .data[i]
                                                      .name ??
                                                  "",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              state
                                                      .allPackagesModel
                                                      .data[i]
                                                      .description ??
                                                  "",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(
                        color: Color1,
                      ))
              ],
            );
          },
        ),
      ),
    );
  }
}
