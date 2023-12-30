import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sevin_rm/Core/di/di_manager.dart';
import 'package:sevin_rm/Core/shared_prefs/shared_prefs.dart';
import 'package:sevin_rm/UI/Screens/MyAuctions/my_auctions.dart';
import 'package:sevin_rm/UI/Screens/ResetPassword/ResetPassword.dart';
import 'package:sevin_rm/UI/Screens/conset/Const.dart';
import 'package:sevin_rm/UI/Screens/favorite/favoriteScreen.dart';
import 'package:sevin_rm/UI/Screens/login/login.dart';
import 'package:sevin_rm/UI/Screens/main_screen/booking_order.dart';
import 'package:sevin_rm/UI/Screens/payment/payment_history.dart';
import 'package:sevin_rm/UI/Screens/profile/about_app/privacy_policy.dart';
import 'package:sevin_rm/UI/Screens/profile/about_app/terms.dart';
import 'package:sevin_rm/data/models/booking/all_booking.dart';
import 'package:sevin_rm/helper/error_dialog_helper.dart';
import 'package:sevin_rm/helper/snack_bar_helper.dart';
import 'package:share_plus/share_plus.dart';

import '../component/Widght.dart';
import '../package/package_page.dart';
import '../payment/payment_method.dart';
import 'EditProfile.dart';
import 'about_app/about_us.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'profile2.dart';
//
class Profile2 extends StatefulWidget {
  AllBookingModel? allBookingModel;
  Profile2({Key? key, this.allBookingModel}) : super(key: key);

  @override
  State<Profile2> createState() => _Profile2State();
}

String firstName = DIManager.findDep<SharedPrefs>().getUserNamePerson() ?? "";
String lastName = DIManager.findDep<SharedPrefs>().getUserNamePerson2() ?? "";
String email = DIManager.findDep<SharedPrefs>().getEmail() ?? "";
var token = DIManager.findDep<SharedPrefs>().getToken();

class _Profile2State extends State<Profile2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Image.asset(
        'assets/images/main/image 12.png',
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
      BlocProvider(
          create: (context) => LogoutCubit(),
          child: BlocConsumer<LogoutCubit, LogoutStates>(
              listener: (context, state) {
            if (state is ErrorStateLogout) {
              DialogHelper.errorDialog(context, "Error", state.error);
            } else if (state is SuccessLogout) {
              SnackBarHelper.mySnackBar("Logout Successfully", context);

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return LoginW();
              }));
              // print('تم النقر على الزر!');
            }
          }, builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                actions: [
                  // Stack(
                  //   alignment: Alignment.centerRight,
                  //   children: [
                  //     Container(
                  //       width: 40,
                  //       child: IconButton(
                  //           onPressed: () {},
                  //           icon: Icon(
                  //             Icons.notifications_none_outlined,
                  //             color: primaryColor,
                  //             size: 33,
                  //           )),
                  //     ),
                  //     Stack(
                  //       alignment: Alignment.center,
                  //       children: [
                  //         CircleAvatar(
                  //           radius: 7,
                  //           backgroundColor: Color.fromRGBO(50, 52, 70, 1),
                  //         ),
                  //         CircleAvatar(
                  //           radius: 5,
                  //           backgroundColor: Colors.white,
                  //         ),
                  //       ],
                  //     )
                  //   ],
                  // ),
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(
                  //       Icons.settings,
                  //       color: primaryColor,
                  //       size: 32,
                  //     ))
                ],
              ),
              body: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: 4,
                  ),
                  token == null
                      ? Container(
                          child: ButtonStaic(
                              onTap: () {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => LoginW(),
                                  ),
                                );
                              },
                              title: "Join us",
                              fontSize: 14.sp,
                              colorText: Colors.white,
                              fontWeight: FontWeight.w400,
                              heightContainer: 48,
                              widthContainer: 80.w),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Container(
                                width: 117,
                                height: 102,
                                child: HexagonImage(
                                  size: 300,
                                  // حجم الشكل السداسي
                                  isFile: false,
                                  imageUrl:
                                      'assets/images/main/image 104.png', // عنوان URL للصورة
                                ),
                              ),
                              SizedBox(
                                width: 17,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text(
                                      title: "$firstName $lastName",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Color1),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  text(
                                      title: email,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color7),
                                  SizedBox(
                                    height: 19,
                                  ),
                                  ButtonStaic(
                                      onTap: (() {
                                        Navigator.push<void>(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                EditProfile(),
                                          ),
                                        );
                                      }),
                                      title: "Edit profile",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      colorText: Color2,
                                      colors: [Color8, Color8],
                                      widthContainer: 131,
                                      heightContainer: 36),
                                ],
                              )
                            ],
                          ),
                        ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Divider(color: Color.fromRGBO(113, 104, 116, 0.8)),
                  token == null
                      ? Container()
                      : InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => BookingOrderPage(
                                      fromProfile: true,
                                      allBookingModel: widget.allBookingModel,
                                    )));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 17.5.w),
                            child: Container(
                              height: 44,
                              child: Row(
                                children: [
                                  Container(
                                    width: 29,
                                    height: 27,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/main/PARCEL.png'),
                                            fit: BoxFit.cover)),
                                  ),
                                  SizedBox(
                                    width: 18.48,
                                  ),
                                  text(
                                      title: "Booking Order & Appointments",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color9),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    BookingOrderPage(
                                                      fromProfile: true,
                                                      allBookingModel: widget
                                                          .allBookingModel,
                                                    )));
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Color10,
                                        size: 20,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                  Padding(
                    padding: EdgeInsets.only(left: 17.5.w),
                    child: Divider(color: Color.fromRGBO(50, 52, 70, 1)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => PackagePage()));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 17.5.w),
                      child: Container(
                        height: 44,
                        child: Row(
                          children: [
                            Container(
                              width: 29,
                              height: 27,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/main/Path 5276.png'),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: 18.48,
                            ),
                            text(
                                title: "Package & Offers",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Color9),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  //PackagePage

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => PackagePage()));
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Color10,
                                  size: 20,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  token == null
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(left: 17.5.w),
                          child: Divider(color: Color.fromRGBO(50, 52, 70, 1)),
                        ),
                  token == null
                      ? Container()
                      : InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => FavoriteScreen()));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 17.5.w),
                            child: Container(
                              height: 44,
                              child: Row(
                                children: [
                                  Container(
                                    width: 29,
                                    height: 27,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/main/Path 5273.png'),
                                            fit: BoxFit.cover)),
                                  ),
                                  SizedBox(
                                    width: 18.48,
                                  ),
                                  text(
                                      title: "Favourite Istable",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color9),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    FavoriteScreen()));
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Color10,
                                        size: 20,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                  token == null
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(left: 17.5.w),
                          child: Divider(color: Color.fromRGBO(50, 52, 70, 1)),
                        ),
                  token == null
                      ? Container()
                      : InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => MyAuctionsPage()));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 17.5.w),
                            child: Container(
                              height: 44,
                              child: Row(
                                children: [
                                  Container(
                                    width: 29,
                                    height: 27,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/main/noun_Credit Card_1939036.png'),
                                            fit: BoxFit.cover)),
                                  ),
                                  SizedBox(
                                    width: 18.48,
                                  ),
                                  text(
                                      title: "My Auctions",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color9),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    MyAuctionsPage()));
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Color10,
                                        size: 20,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                  Padding(
                    padding: EdgeInsets.only(left: 17.5.w),
                    child: Divider(color: Color.fromRGBO(50, 52, 70, 1)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => PaymentMethodPage()));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 17.5.w),
                      child: Container(
                        height: 44,
                        child: Row(
                          children: [
                            Container(
                              width: 29,
                              height: 27,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/main/noun_Credit Card_1939036.png'),
                                      fit: BoxFit.fill)),
                            ),
                            SizedBox(
                              width: 18.48,
                            ),
                            text(
                                title: "Payment Methods",
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color9),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => PaymentMethodPage()));
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Color10,
                                  size: 20,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  token == null
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(left: 17.5.w),
                          child: Divider(color: Color.fromRGBO(50, 52, 70, 1)),
                        ),
                  token == null
                      ? Container()
                      : InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => PaymentHistoryPage()));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 17.5.w),
                            child: Container(
                              height: 44,
                              child: Row(
                                children: [
                                  Container(
                                    width: 29,
                                    height: 27,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/main/noun_invoice report_2545301 (1).png'),
                                            fit: BoxFit.fill)),
                                  ),
                                  SizedBox(
                                    width: 18.48,
                                  ),
                                  text(
                                      title: "Payment History",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color9),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    PaymentHistoryPage()));
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Color10,
                                        size: 20,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                  token == null
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(left: 17.5.w),
                          child: Divider(color: Color.fromRGBO(50, 52, 70, 1)),
                        ),
                  token == null
                      ? Container()
                      : InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ResetPassword(
                                  isForgetPassword: false,
                                );
                              },
                            ));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 17.5.w),
                            child: Container(
                              height: 44,
                              child: Row(
                                children: [
                                  Container(
                                    width: 29,
                                    height: 27,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/main/noun_Key_677345.png'),
                                            fit: BoxFit.fill)),
                                  ),
                                  SizedBox(
                                    width: 18.48,
                                  ),
                                  text(
                                      title: "Reset Password",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color9),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return ResetPassword(
                                              isForgetPassword: false,
                                            );
                                          },
                                        ));
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Color10,
                                        size: 20,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                  token == null
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(left: 17.5.w),
                          child: Divider(color: Color.fromRGBO(50, 52, 70, 1)),
                        ),
                  token == null
                      ? Container()
                      : InkWell(
                          onTap: () {
                            Share.share('Hello Welcome to 7RM',
                                subject: 'Welcome Message');
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 17.5.w),
                            child: Container(
                              height: 44.sp,
                              child: Row(
                                children: [
                                  Container(
                                    width: 29.sp,
                                    height: 27.sp,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/main/noun_follower_2086893.png'),
                                            fit: BoxFit.fill)),
                                  ),
                                  SizedBox(
                                    width: 18.sp,
                                  ),
                                  text(
                                      title: "Invites Friends",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color9),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      Share.share('Hello Welcome to 7RM',
                                          subject: 'Welcome Message');
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Color10,
                                      size: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                  Padding(
                    padding: EdgeInsets.only(left: 17.5.w),
                    child: Divider(color: Color.fromRGBO(50, 52, 70, 1)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return PrivacyPolicyPage();
                        },
                      ));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 17.5.w),
                      child: Container(
                        height: 44,
                        child: Row(
                          children: [
                            Container(
                              width: 29,
                              height: 27,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/main/ic_info.png'),
                                      fit: BoxFit.fill)),
                            ),
                            SizedBox(
                              width: 18.48,
                            ),
                            text(
                                title: "Privacy Policy",
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color9),
                            Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Color10,
                                  size: 20,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 17.5.w),
                    child: Divider(color: Color.fromRGBO(50, 52, 70, 1)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return TermsAndConditionsPage();
                        },
                      ));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 17.5.w),
                      child: Container(
                        height: 44,
                        child: Row(
                          children: [
                            Container(
                              width: 29,
                              height: 27,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/main/ic_info.png'),
                                      fit: BoxFit.fill)),
                            ),
                            SizedBox(
                              width: 18.48,
                            ),
                            text(
                                title: "Terms & Conditions",
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color9),
                            Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Color10,
                                  size: 20,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 17.5.w),
                    child: Divider(color: Color.fromRGBO(50, 52, 70, 1)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return AboutUsPage();
                        },
                      ));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 17.5.w),
                      child: Container(
                        height: 44,
                        child: Row(
                          children: [
                            Container(
                              width: 29,
                              height: 27,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/main/ic_info.png'),
                                      fit: BoxFit.fill)),
                            ),
                            SizedBox(
                              width: 18.48,
                            ),
                            text(
                                title: "About Us",
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color9),
                            Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Color10,
                                  size: 20,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 17.5.w),
                    child: Divider(color: Color.fromRGBO(50, 52, 70, 1)),
                  ),
                  token == null
                      ? Container()
                      : InkWell(
                          onTap: () {
                            LogoutCubit.get(context).logout(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 17.5.w),
                            child: Container(
                              height: 44,
                              child: Row(
                                children: [
                                  Container(
                                    width: 29,
                                    height: 27,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              'assets/images/main/fotor_2023-3-13_1_5_31.png',
                                            ),
                                            fit: BoxFit.cover)),
                                  ),
                                  SizedBox(
                                    width: 18.48,
                                  ),
                                  text(
                                      title: "Log out",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color9),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        LogoutCubit.get(context)
                                            .logout(context);
                                        // DIManager.findDep<SharedPrefs>().setToken(null);
                                        // SnackBarHelper.mySnackBar("Logout Successfully", context);

                                        // Navigator.pushReplacement(context,
                                        //     MaterialPageRoute(builder: (context) {
                                        //   return LoginW();
                                        // }));
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Color10,
                                        size: 20,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                  token == null
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(left: 17.5.w),
                          child: Divider(color: Color.fromRGBO(50, 52, 70, 1)),
                        ),
                ]),
              ),
            );
          }))
    ]));
  }
}
