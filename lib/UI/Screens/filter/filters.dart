import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevin_rm/UI/Screens/conset/Const.dart';
import 'package:sevin_rm/UI/Screens/filter/cubit/cubit.dart';
import 'package:sevin_rm/UI/Screens/filter/cubit/states.dart';
import 'package:sevin_rm/UI/Screens/filter/filter_result_screen.dart';
import 'package:sevin_rm/data/models/filter/filters_model.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../../helper/error_dialog_helper.dart';
import '../../../helper/snack_bar_helper.dart';
import '../../util/app_them.dart';
import '../component/Widght.dart';

class Filters extends StatefulWidget {
  Filters({Key? key, required this.auctionId}) : super(key: key);
  int? auctionId;

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  int selectedValue = 1;
  int price = 100;
  bool f1 = false;

  bool f2 = false;
  bool f3 = false;
  bool f4 = false;
  bool f5 = false;
  bool f6 = false;
  bool p1 = false;
  bool p2 = false;
  bool p3 = false;
  double rate = 0.0;
  List gender = ["Man", "Female"];
  String currentGenger = "Man";
  String selectSort = "";
  bool selectSortAgeMax = false;
  bool selectSortAgeMin = false;
  var selectedMin = 0;
  var selectedMax = 0;
  FiltersModel? filtersModel;
  PageController pageController1 = PageController(initialPage: 5);
  PageController pageController2 = PageController(initialPage: 5);
  TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => FiltersCubit(),
            child: BlocConsumer<FiltersCubit, FiltersStates>(
              listener: (context, state) {
                if (state is ErrorStateFilters) {
                  DialogHelper.errorDialog(
                      context, "Error", state.error.toString());
                } else if (state is SuccessFilters) {
                  filtersModel = state.filter;
                  if (state.filter.data.length == 0) {
                    SnackBarHelper.mySnackBar("No results found", context);
                  } else {
                    SnackBarHelper.mySnackBar(
                        "found results successfully", context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      // return const MyApp();
                      return FilterResultScreen(
                        filtersModel: filtersModel,
                      );
                    }));
                  }
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                          ),
                          const Text("Filters",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.black)),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  bool f1 = false;

                                  f2 = false;
                                  f3 = false;
                                  f4 = false;
                                  f5 = false;
                                  f6 = false;
                                  p1 = false;
                                  p2 = false;
                                  p3 = false;
                                  rate = 0.0;
                                  rating = 0.0;
                                  currentGenger = "Man";
                                  selectSort = "";
                                  selectSortAgeMin = false;
                                  selectSortAgeMax = false;
                                  selectedMin = 0;
                                  selectedMax = 0;
                                  selectedOption = '0';
                                  selectedOption1 = '0';
                                  priceController.text = '';
                                });
                              },
                              child: const Text(
                                'Reset',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ))
                        ],
                      ),
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Services',
                            style: TextStyle(color: primaryColor, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FittedBox(
                            child: Container(
                              child: Row(
                                //
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ChoiceChip(
                                    label: Text('horse training',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                    onSelected: (bool selected) {
                                      setState(() {
                                        f1 = selected;
                                      });
                                    },
                                    selected: f1,
                                    selectedColor: primaryColor,
                                    disabledColor: secondaryColor,
                                    selectedShadowColor: primaryColor,
                                    backgroundColor: secondaryColor,
                                    side: BorderSide(color: secondaryColor),
                                  ),
                                  ChoiceChip(
                                    label: Text('Stable',
                                        style: TextStyle(color: Colors.white)),
                                    onSelected: (bool selected) {
                                      setState(() {
                                        f2 = selected;
                                      });
                                    },
                                    selected: f2,
                                    selectedColor: primaryColor,
                                    disabledColor: secondaryColor,
                                    selectedShadowColor: primaryColor,
                                    backgroundColor: secondaryColor,
                                    side: BorderSide(color: secondaryColor),
                                  ),
                                  ChoiceChip(
                                    label: Text('horse training 1',
                                        style: TextStyle(color: Colors.white)),
                                    onSelected: (bool selected) {
                                      setState(() {
                                        f3 = selected;
                                      });
                                    },
                                    selected: f3,
                                    selectedColor: primaryColor,
                                    disabledColor: secondaryColor,
                                    selectedShadowColor: primaryColor,
                                    backgroundColor: secondaryColor,
                                    side: BorderSide(color: secondaryColor),
                                  )
                                ],
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ChoiceChip(
                                    label: Text(
                                      'training',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onSelected: (bool selected) {
                                      setState(() {
                                        f4 = selected;
                                      });
                                    },
                                    selected: f4,
                                    selectedColor: primaryColor,
                                    disabledColor: secondaryColor,
                                    selectedShadowColor: primaryColor,
                                    backgroundColor: secondaryColor,
                                    side: BorderSide(color: secondaryColor),
                                  ),
                                  ChoiceChip(
                                    label: Text('horse training 1',
                                        style: TextStyle(color: Colors.white)),
                                    onSelected: (bool selected) {
                                      setState(() {
                                        f5 = selected;
                                      });
                                    },
                                    selected: f5,
                                    selectedColor: primaryColor,
                                    disabledColor: secondaryColor,
                                    selectedShadowColor: primaryColor,
                                    backgroundColor: secondaryColor,
                                    side: BorderSide(color: secondaryColor),
                                  ),
                                  ChoiceChip(
                                    label: Text('horse training 1',
                                        style: TextStyle(color: Colors.white)),
                                    onSelected: (bool selected) {
                                      setState(() {
                                        f6 = selected;
                                      });
                                    },
                                    selected: f6,
                                    selectedColor: primaryColor,
                                    disabledColor: secondaryColor,
                                    selectedShadowColor: primaryColor,
                                    backgroundColor: secondaryColor,
                                    side: BorderSide(color: secondaryColor),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Rating",
                            style: TextStyle(fontSize: 18, color: primaryColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              // RatingBar(

                              //   ratingWidget: RatingWidget(
                              //       full: Icon(
                              //         Icons.star_sharp,
                              //         color: Colors.amber,
                              //       ),
                              //       empty: Icon(
                              //         Icons.star_border_purple500_sharp,
                              //         color: Colors.grey,
                              //       ),
                              //       half: Icon(
                              //         Icons.star_half_sharp,
                              //         color: Colors.amber,
                              //       )),
                              //   onRatingUpdate: (star) {
                              //     setState(() {
                              //       rate = star;
                              //     });
                              //   },
                              //   allowHalfRating: true,
                              //   itemCount: 5,
                              //   initialRating: rate,
                              //   glow: true,
                              //   itemSize:35,

                              // ),

                              SmoothStarRating(
                                borderColor: Color.fromRGBO(112, 112, 112, 1),
                                color: Color.fromRGBO(228, 179, 67, 1),
                                rating: rating,
                                // isReadOnly: false,
                                size: 20,
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
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                rating.toString() + " Star",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Gender",
                            style: TextStyle(fontSize: 18, color: primaryColor),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.70,
                            height: 44,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // text(
                                //     title: "Gender",
                                //     fontSize: 16,
                                //     fontWeight: FontWeight.w400,
                                //     color: Color.fromRGBO(0, 0, 0, 0.5)),
                                Container(
                                  width: 100,
                                  // أو Flexible
                                  child: RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    activeColor:
                                        Color.fromRGBO(190, 140, 206, 1),
                                    // tileColor: Colors.red,

                                    title: Text(
                                      'Male',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    value: 1,
                                    groupValue: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value as int;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  width: 110,
                                  // أو Flexible
                                  child: RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    activeColor:
                                        Color.fromRGBO(190, 140, 206, 1),
                                    title: Text(
                                      'Female',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    value: 2,
                                    // contentPadding: EdgeInsets.zero,
                                    groupValue: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value as int;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Sort by",
                            style: TextStyle(fontSize: 18, color: primaryColor),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectSort = "s1";
                              });
                            },
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Most Popular",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: selectSort == "s1"
                                            ? primaryColor
                                            : Colors.black),
                                  ),
                                  selectSort == "s1"
                                      ? Icon(
                                          Icons.done,
                                          color: primaryColor,
                                        )
                                      : Container(),
                                ]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectSort = "s3";
                              });
                            },
                            child: Row(children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Cost Low to High",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: selectSort == "s3"
                                            ? primaryColor
                                            : Colors.black),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Min age:",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13.sp),
                                          ),
                                          SizedBox(
                                            width: 5.sp,
                                          ),

                                          Container(
                                            width: 50.sp,
                                            height: 50.sp,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  190, 140, 206, 1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  DropdownButton<String>(
                                                    underline: null,
                                                    value: selectedOption1,
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        selectedOption1 =
                                                            newValue;
                                                        selectedMin = int.parse(
                                                            newValue!);

                                                        selectSortAgeMin = true;
                                                      });
                                                    },
                                                    items: <String>[
                                                      '0',
                                                      '1',
                                                      '2',
                                                      '3',
                                                      '4',
                                                      '5',
                                                      '6',
                                                      '7',
                                                      '8',
                                                      '9',
                                                      '10',
                                                      '11',
                                                      '12',
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: text(
                                                            title: value,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Color.fromRGBO(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    0.87)),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // Container(
                                          //   height: 5.h,
                                          //   width: 13.w,
                                          //   decoration: BoxDecoration(
                                          //     borderRadius:
                                          //         BorderRadius.circular(50.sp),
                                          //     color: Color10,
                                          //   ),
                                          //   child: PageView.builder(
                                          //     onPageChanged: (i) {
                                          //       setState(() {
                                          //         pageController1.initialPage;
                                          //         selectedMin = i;
                                          //       });
                                          //     },
                                          //     controller: PageController(
                                          //       viewportFraction: 0.4,
                                          //     ),
                                          //     scrollDirection: Axis.vertical,
                                          //     itemCount: 11,
                                          //     itemBuilder: (context, index) {
                                          //       return Center(
                                          //         child: Text(
                                          //           "${index}",
                                          //           style: TextStyle(
                                          //               fontSize:
                                          //                   selectedMin == index
                                          //                       ? 11.sp
                                          //                       : 7.sp,
                                          //               fontWeight:
                                          //                   FontWeight.w400,
                                          //               color: Colors.white),
                                          //         ),
                                          //       );
                                          //     },
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 25.sp,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Max age:",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13.sp),
                                          ),
                                          Container(
                                            width: 50.sp,
                                            height: 50.sp,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  190, 140, 206, 1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  DropdownButton<String>(
                                                    underline: null,
                                                    value: selectedOption,
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        selectedOption =
                                                            newValue;
                                                        selectedMax = int.parse(
                                                            newValue!);
                                                        selectSort += '3';
                                                        selectSortAgeMax = true;
                                                      });
                                                    },
                                                    items: <String>[
                                                      '0',
                                                      '1',
                                                      '2',
                                                      '3',
                                                      '4',
                                                      '5',
                                                      '6',
                                                      '7',
                                                      '8',
                                                      '9',
                                                      '10',
                                                      '11',
                                                      '12',
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: text(
                                                            title: value,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Color.fromRGBO(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    0.87)),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Container(
                                          //   height: 5.h,
                                          //   width: 13.w,
                                          //   decoration: BoxDecoration(
                                          //     borderRadius:
                                          //         BorderRadius.circular(50.sp),
                                          //     color: Color10,
                                          //   ),
                                          //   child: PageView.builder(
                                          //     onPageChanged: (i) {
                                          //       setState(() {
                                          //         selectedMax = i;
                                          //         pageController2.initialPage;
                                          //       });
                                          //     },
                                          //     controller: PageController(
                                          //       viewportFraction: 0.45,
                                          //     ),
                                          //     scrollDirection: Axis.vertical,
                                          //     itemCount: 10,
                                          //     itemBuilder: (context, index) {
                                          //       return Center(
                                          //         child: Text(
                                          //           "${index}",
                                          //           style: TextStyle(
                                          //               fontSize:
                                          //                   selectedMax == index
                                          //                       ? 11.sp
                                          //                       : 7.sp,
                                          //               fontWeight:
                                          //                   FontWeight.w400,
                                          //               color: Colors.white),
                                          //         ),
                                          //       );
                                          //     },
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              selectSortAgeMax && selectSortAgeMin
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 25.sp,
                                        ),
                                        Icon(
                                          Icons.done,
                                          color: primaryColor,
                                        ),
                                      ],
                                    )
                                  : Container(),
                            ]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectSort = "s2";
                              });
                            },
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Cost High to Low",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: selectSort == "s2"
                                            ? primaryColor
                                            : Colors.black),
                                  ),
                                  selectSort == "s2"
                                      ? Icon(
                                          Icons.done,
                                          color: primaryColor,
                                        )
                                      : Container(),
                                ]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Price:",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color1,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                        child: TextFormField(
                                          controller: priceController,
                                          // controller: controller,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                color: Color2,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w400),
                                            hintText: "Enter price",

                                            // dataProfile!.data!.country,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 28.w,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          state is LoadingFilters
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: Color10,
                                ))
                              : Align(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: () {
                                      context.read<FiltersCubit>().filter(
                                            // widget.auctionId,
                                            // selectedMin,
                                            // selectedMa
                                            // x,
                                            // price,
                                            auctionId: widget.auctionId ?? 0,
                                            maxAge: selectedMax,
                                            minAge: selectedMin,
                                            price: priceController.text,
                                          );
                                      print(selectedMin);
                                      print(selectedMax);
                                      print(widget.auctionId);
                                      print(price);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      height: 44,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(90, 0, 114, 1),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      alignment: Alignment.center,
                                      child: Text('Apply Filter',
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 20)),
                                    ),
                                  ),
                                )
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
