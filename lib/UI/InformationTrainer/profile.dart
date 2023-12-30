import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sevin_rm/UI/Screens/component/Widght.dart';
import 'package:sevin_rm/UI/Screens/conset/Const.dart';
import 'package:sevin_rm/data/models/trainers/show_trainer.dart';
import 'package:sevin_rm/helper/Calculate_distance.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../data/models/trainers/trainers_model.dart';
import 'package:flutter_bloc/src/bloc_consumer.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';

import '../Screens/main_screen/bloc/cubit.dart';
import 'cubit/trainer_bloc_cubit.dart';
import 'cubit/trainer_bloc_state.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';

class InformationProfile extends StatefulWidget {
  InformationProfile({
    Key? key,
    this.trainer,
    required this.trainerId,
  }) : super(key: key);
  Trainer? trainer;
  int trainerId;

  @override
  State<InformationProfile> createState() => _InformationProfileState();
}

class _InformationProfileState extends State<InformationProfile> {
  double rating = 0.0;
  double location = 0.0;
  AppHelper appHelper = AppHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    getLocation();
    super.dispose();
  }

  Future<double> getLocation() async {
    return await appHelper.calculateDistance(
      longitude: double.parse(widget.trainer?.longitude ?? '22.5'),
      latitude: double.parse(widget.trainer?.latitude ?? '22.5'),
    );
    print(location);
  }

  ShowTrainerModel? showTrainerModel;
  @override
  Widget build(BuildContext context) {
    print(widget.trainerId);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/main/image 12.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          BlocProvider(
            create: (context) =>
                TrainerBlocCubit()..showTrainers(trainerId: widget.trainerId),
            child: BlocConsumer<TrainerBlocCubit, TrainerBlocState>(
              listener: (BuildContext context, state) {

                if(state is SuccessTrainer){
                  showTrainerModel= state.trainers;
                  print(showTrainerModel!.firstName);
                }
              },
              builder: (BuildContext context, state) {
                if(state is LoadingTrainer){
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color1,
                    ),
                  );
                }

                return Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color.fromRGBO(90, 0, 114, 1),
                        size: 35,
                      ),
                    ),
                    title: Center(
                      child: text(
                          title: "Profile",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(35, 0, 44, 1)),
                    ),
                    actions: [
                      Container(
                        width: 50.sp,
                      )
                      // IconButton(
                      //     onPressed: () {},
                      //     icon: const Icon(
                      //       Icons.bookmark_add_outlined,
                      //       color: Color.fromRGBO(90, 0, 114, 1),
                      //       size: 35,
                      //     ))
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 130.sp,
                            // color: Colors.red,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      // Container(
                                      //   height: 120,
                                      //   width: 120,
                                      //   padding: const EdgeInsets.all(3),
                                      //
                                      //   decoration: BoxDecoration(
                                      //     color: Colors.white,
                                      //     shape: BoxShape.circle,
                                      //     border: Border.all(color: Colors.grey),
                                      //     image: DecorationImage(
                                      //       image: AssetImage(
                                      //           'assets/images/main/trainer2.png'),
                                      //       // قم بتحديد مسار الصورة هنا
                                      //       fit: BoxFit.cover,
                                      //     ),
                                      //   ),
                                      //   // child:
                                      //
                                      //   // Image.network(
                                      //   //   trainers?.data!.trainers[i].userImage ?? '',
                                      //   //   errorBuilder: (context, url, error) => new Icon(Icons.error),)
                                      // ),
                                      CircleAvatar(
                                        radius: 60,
                                        backgroundColor: Colors.grey,
                                        child: CircleAvatar(
                                          radius: 56,
                                          backgroundColor: Colors.transparent,
                                          child:
                                          // widget.trainer?.userImage
                                          // ? Image.asset(
                                          //     'assets/images/main/trainer1.png',
                                          //     fit: BoxFit.fill,
                                          //   ):
                                          Image.network(
                                            showTrainerModel?.userImage ?? "",
                                            fit: BoxFit.fill,
                                            errorBuilder:
                                                (context, error, stackTrace) {
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
                                      ),
                                      // const CircleAvatar(
                                      //   radius: 13,
                                      //   backgroundColor: Colors.white,
                                      // ),
                                      CircleAvatar(
                                        radius: 12,
                                        backgroundColor:
                                        showTrainerModel?.isActive == 1
                                            ? Colors.green
                                            : Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                                // Spacer()
                              ],
                            )),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                text(
                                    title:
                                    '${showTrainerModel?.firstName ?? ""} ${showTrainerModel?.lastName ?? ''}',
                                    fontSize: 22.sp,
                                    // textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w700,
                                    color: const Color.fromRGBO(90, 0, 114, 1)),
                                SizedBox(
                                  height: 2.sp,
                                ),
                                text(
                                    title: "horse trainer",
                                    fontSize: 14.sp,
                                    // textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w400,
                                    color: const Color.fromRGBO(90, 0, 114, 1)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .004,
                        ),
                        SizedBox(
                          height: 30,
                          // color: Colors.amber,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SmoothStarRating(
                                color: const Color.fromRGBO(228, 179, 67, 1),
                                rating: showTrainerModel?.averageEvaluations ?? 0.0 ,
                                // isReadOnly: false,
                                size: 25,
                                filledIconData: Icons.star,
                                halfFilledIconData: Icons.star_half,
                                defaultIconData: Icons.star_border,
                                starCount: 5,
                                allowHalfRating: true,
                                spacing: 2.0,
                                onRatingChanged: (v) {
                                  setState(() {
                                    rating = v;
                                  });
                                },
                              ),
                              text(
                                  title:
                                  " (${showTrainerModel?.averageEvaluations ?? 0} Reviews)",
                                  color: const Color.fromRGBO(34, 32, 32, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * .008,
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push<void>(
                        //       context,
                        //       MaterialPageRoute<void>(
                        //         builder: (BuildContext context) =>
                        //             ChatListScreen(),
                        //       ),
                        //     );
                        //   },
                        //   child: Column(
                        //     children: [
                        //       const CircleAvatar(
                        //         radius: 26,
                        //         backgroundColor: Color.fromRGBO(190, 140, 206, 1),
                        //         child: Icon(
                        //           Icons.chat_bubble,
                        //           color: Colors.white,
                        //           size: 30,
                        //         ),
                        //       ),
                        //       text(
                        //           title: "Chat",
                        //           color: const Color.fromRGBO(0, 0, 0, 0.54),
                        //           fontSize: 13,
                        //           fontWeight: FontWeight.w400)
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * .003,
                        // ),
                        const Divider(
                          color: Color.fromRGBO(50, 52, 70, 1),
                        ),
                        // Container(
                        //   color: Colors.red,
                        //   height: 50,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultTabController(
                                    length: 2,
                                    child: SizedBox(
                                      // width: MediaQuery.of(context).size.width,
                                        height: 140.sp,
                                        child: Column(children: [
                                          const TabBar(
                                            labelColor:
                                            Color.fromRGBO(90, 0, 114, 1),
                                            indicatorColor:
                                            Color.fromRGBO(90, 0, 114, 1),
                                            unselectedLabelColor:
                                            Color.fromRGBO(5, 0, 0, 0.5),
                                            tabs: [
                                              Tab(text: 'Portfolio'),
                                              Tab(text: 'Basic Info'),

                                              // Tab(text: 'Review'),
                                            ],
                                          ),
                                          Expanded(
                                            child: TabBarView(
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          text(
                                                              title:
                                                              "Business name",
                                                              color:
                                                              Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400),
                                                          text(
                                                              title:
                                                              "horse trainer",
                                                              color: const Color
                                                                  .fromRGBO(0,
                                                                  0, 0, 0.54),
                                                              fontSize: 13,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400)
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                      Column(
                                                        children: [
                                                          text(
                                                              title:
                                                              "Start from",
                                                              color:
                                                              Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400),
                                                          text(
                                                              title: "280 AED",
                                                              color: const Color
                                                                  .fromRGBO(0,
                                                                  0, 0, 0.54),
                                                              fontSize: 13,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400)
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              text(
                                                                  title:
                                                                  "Mobile number",
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                  14.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                              text(
                                                                  title: widget
                                                                      .trainer
                                                                      ?.fullMobileNumber ??
                                                                      showTrainerModel?.mobile ?? '',
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      0.54),
                                                                  fontSize:
                                                                  14.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400)
                                                            ],
                                                          ),
                                                          const Spacer(),
                                                          Column(
                                                            children: [
                                                              text(
                                                                  title:
                                                                  "Email",
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                              text(
                                                                  title: widget
                                                                      .trainer
                                                                      ?.email ??
                                                                      ' ',
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      0.54),
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400)
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 7.sp,
                                                      ),
                                                      Row(
                                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              text(
                                                                  title:
                                                                  "Gender :",
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                              SizedBox(
                                                                width: 2.sp,
                                                              ),
                                                              text(
                                                                  title: widget
                                                                      .trainer
                                                                      ?.gender ??
                                                                      showTrainerModel?.gender ?? '',
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      0.54),
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400)
                                                            ],
                                                          ),
                                                          widget
                                                              .trainer
                                                              ?.country
                                                              ?.name  == null &&
                                                              showTrainerModel?.country  ==null?Container():  Row(
                                                            children: [
                                                              text(
                                                                  title:
                                                                  "Country :",
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                  14.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                              SizedBox(
                                                                width: 2.sp,
                                                              ),
                                                              text(
                                                                  title: widget
                                                                      .trainer
                                                                      ?.country
                                                                      ?.name ??
                                                                      showTrainerModel?.country ?? '',
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      0.54),
                                                                  fontSize:
                                                                  14.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400)
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),

                                                // Padding(
                                                //   padding: const EdgeInsets.all(8.0),
                                                //   child: Row(
                                                //     children: [
                                                //       Column(
                                                //         crossAxisAlignment:
                                                //             CrossAxisAlignment.start,
                                                //         children: [
                                                //           text(
                                                //               title: "Business name",
                                                //               color: Colors.black,
                                                //               fontSize: 16,
                                                //               fontWeight:
                                                //                   FontWeight.w400),
                                                //           text(
                                                //               title: "horse trainer",
                                                //               color: const Color.fromRGBO(
                                                //                   0, 0, 0, 0.54),
                                                //               fontSize: 13,
                                                //               fontWeight:
                                                //                   FontWeight.w400)
                                                //         ],
                                                //       ),
                                                //       const Spacer(),
                                                //       Column(
                                                //         children: [
                                                //           text(
                                                //               title: "Start from",
                                                //               color: Colors.black,
                                                //               fontSize: 16,
                                                //               fontWeight:
                                                //                   FontWeight.w400),
                                                //           text(
                                                //               title: "280 AED",
                                                //               color: const Color.fromRGBO(
                                                //                   0, 0, 0, 0.54),
                                                //               fontSize: 13,
                                                //               fontWeight:
                                                //                   FontWeight.w400)
                                                //         ],
                                                //       )
                                                //     ],
                                                //   ),
                                                // ),
                                                // Center(
                                                //     child: Container(
                                                //   height: 300,
                                                //   child: Column(
                                                //     children: [
                                                //       Text('محتوى تصنيف 2'),
                                                //       Text('محتوى تصنيف 2'),
                                                //       Text('محتوى تصنيف 2'),
                                                //       Text('محتوى تصنيف 2'),
                                                //       Text('محتوى تصنيف 2'),
                                                //     ],
                                                //   ),
                                                // )),
                                                // Center(child: Text('محتوى تصنيف 3')),
                                                // Center(child: Text('محتوى تصنيف 3')),
                                                // Center(child: Text('محتوى تصنيف 3')),
                                              ],
                                            ),
                                          ),
                                        ]))),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * .03,
                                ),
                                Row(
                                  children: [
                                    text(
                                        title: "Opening Hours",
                                        color: Colors.black,
                                        textAlign: TextAlign.start,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.019,
                                ),
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 5,
                                      backgroundColor:
                                      Color.fromRGBO(190, 140, 206, 1),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.38,
                                      height:
                                      MediaQuery.of(context).size.height *
                                          0.03,
                                      child: text(
                                          title: "Monday - Friday",
                                          color: const Color.fromRGBO(
                                              0, 0, 0, 0.54),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    text(
                                        title: "8:30 AM - 9:00PM",
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.008,
                                ),
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 5,
                                      backgroundColor:
                                      Color.fromRGBO(190, 140, 206, 1),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.38,
                                      height:
                                      MediaQuery.of(context).size.height *
                                          0.03,
                                      child: text(
                                          title: "Saturday - Sunday",
                                          color: const Color.fromRGBO(
                                              0, 0, 0, 0.54),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    text(
                                        title: "9:00 AM - 1:00PM",
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ],
                                ),


                                // Locations
                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 16.sp),
                                  child: SizedBox(
                                    height: 100.sp,
                                    width: MediaQuery.of(context).size.width,
                                    // color: Colors.grey,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.60,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              text(
                                                  title: "Country",
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                              text(
                                                  title: widget.trainer?.country?.name ?? showTrainerModel?.country
                                                       ??
                                                      "Not Select",
                                                  color: const Color.fromRGBO(
                                                      0, 0, 0, 0.54),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                              // Row(
                                              //   children: [
                                              //     const Icon(
                                              //       Icons.send,
                                              //       color: Color.fromRGBO(
                                              //           90, 0, 114, 1),
                                              //     ),
                                              //     text(
                                              //         title:
                                              //         " Get directions ~ ${location} km",
                                              //         color:
                                              //         const Color.fromRGBO(
                                              //             90, 0, 114, 1),
                                              //         fontSize: 13,
                                              //         fontWeight:
                                              //         FontWeight.w400),
                                              //   ],
                                              // )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                .060),
                                        Image.asset(
                                          'assets/images/main/image 64.png',
                                          fit: BoxFit.cover,
                                          width: 100,
                                          height: 100,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      text(
                                          title: "Photos",
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      const Spacer(),
                                      // text(
                                      //     title: "View all",
                                      //     color: const Color.fromRGBO(
                                      //         90, 0, 114, 1),
                                      //     fontSize: 16,
                                      //     fontWeight: FontWeight.w400),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget
                                          .trainer?.stable?.images.length ??
                                          0,
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.2,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.050,
                                          decoration: BoxDecoration(),
                                          child: Image.network(
                                            showTrainerModel?.images[index].image.toString() ??
                                                'assets/images/main/7rmlogo.png',
                                            fit: BoxFit.fill,
                                            errorBuilder: (BuildContext context,
                                                Object error,
                                                StackTrace? stackTrace) {
                                              // If an error occurs while loading the image, show the fallback image
                                              return Image.asset(
                                                'assets/images/main/7rmlogo.png',
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    )),
                                SizedBox(
                                  height: 20.sp,
                                )
                                //////
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
