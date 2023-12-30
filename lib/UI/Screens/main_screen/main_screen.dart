import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/bloc_consumer.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sevin_rm/Core/di/di_manager.dart';
import 'package:sevin_rm/UI/DrwerPage.dart';
import 'package:sevin_rm/UI/Screens/Chat/Person.dart';
import 'package:sevin_rm/UI/Screens/component/Widght.dart';
import 'package:sevin_rm/UI/Screens/main_screen/Local1.dart';
import 'package:sevin_rm/UI/Screens/main_screen/nearby_screen.dart';
import 'package:sevin_rm/UI/Screens/profile/Profile3.dart';
import 'package:sevin_rm/UI/Screens/search/search_screen.dart';
import 'package:sevin_rm/data/models/booking/all_booking.dart';
import 'package:sevin_rm/data/models/categories/categories_model.dart';
import 'package:sevin_rm/data/models/stables/best_stables_model.dart';

import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../../data/models/categories/stables_services_package_model.dart';
import '../../../data/models/stables/stable_trainers_model.dart';
import '../../../data/models/stables/stables_model.dart';
import '../../util/app_them.dart';
import '../HomeScreen/Home.dart';
import '../ServiceScreen/serviese_screen.dart';
import '../booking/selectingBooking.dart';
import '../conset/Const.dart';
import '../filter/filters.dart';
import '../login/login.dart';
import '../stables/all_stables.dart';
import 'bloc/cubit.dart';
import 'bloc/states.dart';
import 'booking_order.dart';

class MainScreen extends StatefulWidget {
  //
  MainScreen({Key? key, this.pagep, this.auctionId}) : super(key: key);
  final int? pagep;
  final int? auctionId;

  int m = 2;

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _page = 0;

  // Profile2
  List category = [
    {
      "image": "assets/images/img_10.png",
      "text": "Ability &",
    },
    {"image": "assets/images/img_11.png", "text": "Flat race"},
    {"image": "assets/images/img_12.png", "text": "Show horse"},
    {"image": "assets/images/img_13.png", "text": "Pony"},
    {"image": "assets/images/img_13.png", "text": "Pony"},
    {"image": "assets/images/img_13.png", "text": "Pony"},
    {"image": "assets/images/img_13.png", "text": "Pony"},
    {
      "image": "assets/images/img_14.png",
      "text": "Race",
    },
  ];

  // int selected_page = widget.pagep!;
  int? selected_page;

  bool about = true;
  bool chat = true;

  void initState() {
    super.initState();
    selected_page = widget.pagep == null ? 0 : widget.pagep;
    // يمكنك استخدام widget.pagep هنا أو في أي دوال أخرى
    AppCubitMainPage().getAllCategories();
    AppCubitMainPage().getBestStables();
    AppCubitMainPage().getAllStables();
    AppCubitMainPage().getAllBooking();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // يمكنك أيضًا استخدام widget.pagep هنا أو في أي دوال أخرى
  //   AppCubitMainPage().getAllCategories();
  // }

  // StablesModel? dataBestStables;
  BestStablesModel? dataBestStables;
  StablesModel? dataStables;
  DataCategoriesModel? dataCategoriesModel;
  StablesPackagesServicesCategoryModel? dataIncludeCategoriesModel;
  AllBookingModel? dataAllBooking;
  StableTrainersModel? stableTrainersModel;
  // StableInformationModel? stableInformationModel;
  @override
  Widget build(BuildContext context) {
    // int selected_page = widget.pagep == null ? 0 : widget.pagep!;
    print(selected_page.toString() +
        "LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          'assets/images/img.png',
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        BlocProvider(
          create: (context) => AppCubitMainPage()
            ..getAllCategories()
            ..getBestStables()
            ..getAllStables()
            ..getStableTrainers(),
          child: BlocConsumer<AppCubitMainPage, AppCubitMainPageStates>(
            listener: (BuildContext context, state) {
              if (state is GetAllStablesSuccessStates) {
                print(state.stablesModel.data);
                dataStables = state.stablesModel;
              }

              if (state is GetAllBookingSuccessStates) {
                print(state.allBookingModel);
                dataAllBooking = state.allBookingModel;
                print(state.allBookingModel);
              }

              if (state is GetNearbyStablesSuccessStates) {
                print(state.stablesNearbyModel.message);
              }
              if (state is GetCategoriesIncludeDataSuccessStates) {
                dataIncludeCategoriesModel = state.categoriesIncludeModel;
              }
              if (state is GetCategoriesDataSuccessStates) {
                print(state.categoriesModel.message);
                dataCategoriesModel = state.categoriesModel.data;

                print(dataCategoriesModel!.categories!.length);
              }

              if (state is GetStableTrainersSuccessStates) {
                print(state.stableTrainersModel.data!.trainers[0].firstName);
                stableTrainersModel = state.stableTrainersModel;
              }

              if (state is GetBestStablesSuccessStates) {
                print(state.bestStablesModel);
                dataBestStables = state.bestStablesModel;

                print(dataBestStables!.data!.length);
              }
              // if (state is GetStableInformationSuccessStates) {
              //   print(state.stableInformationModel.message);
              //
              //   stableInformationModel =state.stableInformationModel;
              // }
            },
            builder: (BuildContext context, state) {
              // final changePasswordState = state.changePassword;
              // AppCubitMainPage.get(context)
              //     .dataCategoriesModel
              //     ?.categories
              //     ?.length !=
              //     null
              //     ? print(AppCubitMainPage.get(context)
              //     .dataCategoriesModel
              //     ?.categories
              //     ?.length)
              //     : print(
              //     'AppCubitMainPage.get(context).dataCategoriesModel?.categories?.length');
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: selected_page == 0
                    ? about
                        ? Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            height: double.infinity,
                            // decoration: BoxDecoration(
                            //     image: DecorationImage(
                            //         image: AssetImage('assets/images/img.png'),
                            //         fit: BoxFit.fill)),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Builder(
                                            builder: (context) => IconButton(
                                                onPressed: () {
                                                  // Scaffold.of(context).openDrawer();

                                                  Navigator.push<void>(
                                                    context,
                                                    MaterialPageRoute<void>(
                                                      builder: (BuildContext
                                                              context) =>
                                                          DrwerPage(),
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.dehaze_rounded,
                                                  color: primaryColor,
                                                ))),
                                        Container(
                                            padding: EdgeInsets.only(top: 0),
                                            alignment: Alignment.center,
                                            child: Transform.translate(
                                              offset: Offset(36.w, -2.h),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '7',
                                                    style: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 46.sp,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 44.sp,
                                                    height: 44.sp,
                                                    child: Image.asset(
                                                      'assets/images/main/7rmlogo.png',
                                                    ),
                                                  ),
                                                  Text(
                                                    'M',
                                                    style: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 46.sp,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        SizedBox(height: 52),
                                        Container(
                                          child: Row(
                                            children: [
                                              Stack(
                                                alignment:
                                                    Alignment.centerRight,
                                                children: [
                                                  Container(
                                                    width: 40,
                                                    child: IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons
                                                              .notifications_none_outlined,
                                                          color: primaryColor,
                                                          size: 33,
                                                        )),
                                                  ),
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 7,
                                                        backgroundColor:
                                                            Color.fromRGBO(
                                                                50, 52, 70, 1),
                                                      ),
                                                      CircleAvatar(
                                                        radius: 5,
                                                        backgroundColor:
                                                            Colors.white,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              IconButton(
                                                  onPressed: () {

                                                    if (DIManager.findDep<SharedPrefs>().getToken() != null){

                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  Filters(
                                                                    auctionId:
                                                                    widget.auctionId ??
                                                                        0,
                                                                  )));
                                                    }else {

                                                      Navigator.push(context,
                                                          MaterialPageRoute(builder: (context) {
                                                            return LoginW();
                                                          }));
                                                    }


                                                  },
                                                  icon: Icon(
                                                    Icons.filter_alt,
                                                    color: primaryColor,
                                                    size: 32,
                                                  ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Find and book best services",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF23002C),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 40,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 40),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return SearchScreen();
                                          },
                                        ));
                                      },
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            // contentPadding: EdgeInsets.all(5),
                                            fillColor: secondaryColor,
                                            filled: true,
                                            enabled: false,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: secondaryColor),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                borderSide: BorderSide(
                                                    color: secondaryColor)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                borderSide: BorderSide(
                                                    color: secondaryColor)),
                                            prefixIcon: Icon(
                                              Icons.search_rounded,
                                              color: Colors.black,
                                            ),
                                            hintText:
                                                "Search Flat race, Pony and Stable",
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 69,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Top categories",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: primaryColor,
                                          )),
                                      // InkWell(
                                      //   onTap: () {},
                                      //   child: Text("View all",
                                      //       style: TextStyle(
                                      //         fontSize: 14,
                                      //       )),
                                      // ),
                                    ],
                                  ),
                                  dataCategoriesModel?.categories?.length ==
                                          null
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 60),
                                          child: Center(
                                              child: CircularProgressIndicator(
                                            color: Color1,
                                          )),
                                        )
                                      : Container(
                                          height: 100.sp,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (_, i) {
                                              return GestureDetector(
                                                onTap: () {
                                                  // print("object");
                                                  setState(() {
                                                    about = false;
                                                  });
                                                  AppCubitMainPage.get(context)
                                                      .getIncludeCategory(
                                                    categoryId:
                                                        dataCategoriesModel
                                                                ?.categories![i]
                                                                .id ??
                                                            0,
                                                  );
                                                  print(about.toString() +
                                                      "mmmmmmmmam");
                                                },
                                                child: Container(
                                                  height: 82.sp,
                                                  width: 70.sp,
                                                  padding: EdgeInsets.all(5),
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 10.sp,
                                                      vertical: 5.sp),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: primaryColor,
                                                            blurRadius: 5,
                                                            offset:
                                                                Offset(0, 5))
                                                      ]),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    // mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      // SizedBox(
                                                      //   height: 10.sp,
                                                      // ),
                                                      Image.network(
                                                        dataCategoriesModel
                                                                ?.categories![i]
                                                                .image ??
                                                            "",
                                                        errorBuilder: (context,
                                                            error, stackTrace) {
                                                          return Center(
                                                            child: Image.asset(
                                                              'assets/images/main/7rmlogo.png',
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      Text(
                                                          dataCategoriesModel
                                                                  ?.categories![
                                                                      i]
                                                                  .name ??
                                                              '',
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis))
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount: dataCategoriesModel
                                                    ?.categories?.length ??
                                                2,
                                          ),
                                        ),
                                  SizedBox(
                                    height: 70.sp,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("  Best Stables",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: primaryColor,
                                          )),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push<void>(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  AllStaplesPage(
                                                      dataStablesModel:
                                                          dataStables),
                                            ),
                                          );
                                        },
                                        child: Text("View all",
                                            style: TextStyle(
                                              fontSize: 14,
                                            )),
                                      ),
                                    ],
                                  ),
                                  dataBestStables
                                      ?.data?.length == null ? Padding(
                                          padding:
                                               EdgeInsets.only(top: 60.sp),
                                          child: Center(
                                              child: CircularProgressIndicator(
                                            color: Color1,
                                          )),
                                        )
                                      : Container(
                                          height: 210.sp,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (_, index) {
                                              // StablesRemoteDataSourceImpl stablesRemoteDataSourceImpl =  StablesRemoteDataSourceImpl();
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push<void>(
                                                    context,
                                                    MaterialPageRoute<void>(
                                                      builder: (BuildContext
                                                              context) =>
                                                          Home(
                                                        stableId:
                                                            dataBestStables
                                                                    ?.data[
                                                                        index]
                                                                    .id ??
                                                                0,
                                                      ),
                                                    ),
                                                  );
                                                  // stablesRemoteDataSourceImpl.getIndexStables();
                                                  // AppCubitMainPage.get(context)
                                                  //     .getAllStables();
                                                  // AppCubitMainPage.get(context)
                                                  //     .getAllCategories();
                                                },
                                                child: Container(
                                                  width: 232.sp,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 10.sp,
                                                      vertical: 15.sp),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Color(
                                                                0x80BE8FFF),
                                                            blurRadius: 5,
                                                            offset:
                                                                Offset(3, 5))
                                                      ]),
                                                  child: Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.push<
                                                                void>(
                                                              context,
                                                              MaterialPageRoute<
                                                                  void>(
                                                                builder:
                                                                    (BuildContext
                                                                            context) =>
                                                                        Home(
                                                                  stableId: dataBestStables
                                                                          ?.data[
                                                                              index]
                                                                          .id ??
                                                                      0,
                                                                ),
                                                              ),
                                                            );

                                                            // AppCubitMainPage.get(context).geAllStables();
                                                            // AppCubitMainPage.get(context).getAllCategories();
                                                            // AppCubitMainPage.get(context).getStableTrainers();
                                                            // AppCubitMainPage.get(context).getNearbyStables();
                                                            // // AppCubitMainPage.get(context).getStableInformation(stableId: 1);
                                                            // AppCubitMainPage
                                                            //         .get(
                                                            //             context)
                                                            //     .getBestStables();
                                                          },
                                                          child: Container(
                                                            width: 240.sp,
                                                            height: 100.sp,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.black,
                                                              //dataBestStables!.stables!
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.sp),
                                                            ),
                                                            child:
                                                                Image.network(
                                                              dataBestStables
                                                                      ?.data[
                                                                          index]
                                                                      ?.profileImage ??
                                                                  'assets/images/main/7rmlogo.png',
                                                              fit: BoxFit.fill,
                                                              errorBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      Object
                                                                          error,
                                                                      StackTrace?
                                                                          stackTrace) {
                                                                return Image.asset(
                                                                    'assets/images/main/7rmlogo.png',
                                                                    );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      8.sp),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                width: 120.sp,
                                                                child: Text(
                                                                  dataBestStables
                                                                          ?.data[
                                                                              index]
                                                                          .name ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.sp,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis),
                                                                ),
                                                              ),
                                                              TextButton.icon(
                                                                  onPressed:
                                                                      () {},
                                                                  icon: Icon(
                                                                    Icons
                                                                        .star_rate,
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                                  label: dataBestStables
                                                                              !.data![index]
                                                                              .evaluations.isEmpty
                                                                      ? Text(
                                                                          '0',
                                                                          style:
                                                                              TextStyle(color: Colors.black),
                                                                        )
                                                                      : Text(
                                                                          dataBestStables?.data![index].evaluations[0].averageEvaluation ??
                                                                              '',
                                                                          style:
                                                                              TextStyle(color: Colors.black),
                                                                        ))
                                                            ],
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          5),
                                                              child: Container(
                                                                width: 150.sp,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              8.0),
                                                                  child: Text(
                                                                    dataBestStables
                                                                            ?.data![index]
                                                                            .description ??
                                                                        '',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    softWrap:
                                                                        true,
                                                                    maxLines: 1,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            InkWell(
                                                              onTap: (() {
                                                                // AppCubitMainPage.get(context).getStableInformation(stableId: dataBestStables
                                                                //     ?.stables[
                                                                // index]
                                                                //     .id ??
                                                                //     0,);

                                                                if (DIManager.findDep<
                                                                            SharedPrefs>()
                                                                        .getToken() !=
                                                                    null) {
                                                                  Navigator
                                                                      .push<
                                                                          void>(
                                                                    context,
                                                                    MaterialPageRoute<
                                                                        void>(
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          BookingScreen(
                                                                        stableId:
                                                                            dataBestStables?.data[index].id ??
                                                                                0,
                                                                      ),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  Navigator
                                                                      .push<
                                                                          void>(
                                                                    context,
                                                                    MaterialPageRoute<
                                                                        void>(
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          LoginW(),
                                                                    ),
                                                                  );
                                                                }
                                                              }),
                                                              child: Container(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        10),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey),
                                                                    borderRadius: BorderRadius.only(
                                                                        bottomRight:
                                                                            Radius.circular(
                                                                                10),
                                                                        topLeft:
                                                                            Radius.circular(10))),
                                                                child: Text(
                                                                    "Book",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                    )),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount: dataBestStables
                                                ?.data?.length,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          )
                        : NearbyScreen(
                            dataIncludeCategory: dataIncludeCategoriesModel,
                            dataStablesModel: dataStables,
                          )
                    : selected_page == 1
                        ? Location1()
                        : selected_page == 2
                            ? ChatListScreen()
                            : selected_page == 3
                                ? BookingOrderPage(
                                    fromProfile: false,
                                    allBookingModel: dataAllBooking,
                                  )
                                : selected_page == 4
                                    ? Profile2(
                                        allBookingModel: dataAllBooking,
                                      )
                                    : selected_page == 10
                                        ? ServieseScreen(
                                            dataStables: dataStables,
                                            dataBestStables: dataBestStables,
                                            stableTrainersModel:
                                                stableTrainersModel,
                                          )
                                        : Container(),
                bottomNavigationBar: CurvedNavigationBar(
                  index: 2,
                  height: 75.0,
                  items: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          selected_page = 0;
                          about = true;
                        });
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 6.sp,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.home_outlined,
                              size: 30,
                              color: selected_page == 0
                                  ? LinearGradientColor2
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                selected_page = 0;
                                about = true;
                              });
                            },
                          ),
                          text(
                              title: "Home",
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.white)
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selected_page = 1;
                        });
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 6,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.location_on_outlined,
                              size: 30,
                              color: selected_page == 1
                                  ? LinearGradientColor2
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                selected_page = 1;
                              });
                            },
                          ),
                          text(
                              title: "Near by",
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.white)
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("llllllll");
                        setState(() {
                          selected_page = 2;

                          chat = false;
                        });
                      },
                      child: Column(
                        children: [
                          selected_page == 2
                              ? Icon(Icons.close)
                              : Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/img_9.png'))),
                                  // child: Image.asset(
                                  //   'assets/images/img_9.png',
                                  //   color: Colors.black,
                                  //   height: 35,
                                  //   width: 35,
                                  // ),
                                ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selected_page = 3;
                          AppCubitMainPage.get(context).getAllBooking();
                        });
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 18,
                          ),
                          Image.asset(
                            'assets/images/img_6.png',
                            height: 25,
                            width: 25,
                            color: selected_page == 3
                                ? LinearGradientColor2
                                : Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          text(
                              title: "My Booking",
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.white)
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print("objectLLLL");
                        setState(() {
                          selected_page = 4;
                        });
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 18,
                          ),
                          Image.asset(
                            'assets/images/img_7.png',
                            height: 25,
                            width: 25,
                            color: selected_page == 4
                                ? LinearGradientColor2
                                : Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          text(
                              title: "Profile",
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.white)
                        ],
                      ),
                    ),
                  ],
                  color: navBarColor,
                  buttonBackgroundColor: secondaryColor,
                  backgroundColor: Colors.transparent.withOpacity(0.0),
                  animationCurve: Curves.easeInOut,
                  animationDuration: Duration(milliseconds: 600),
                  onTap: (index) {
                    setState(() {
                      _page = index;
                      print("LLLLLLLLLLLLLLLLLLLLLL");
                      print(index);
                    });
                    //
                  },
                  letIndexChange: (index) => false,
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
