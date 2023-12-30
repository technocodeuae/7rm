import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sevin_rm/Core/di/di_manager.dart';
import 'package:sevin_rm/Core/shared_prefs/shared_prefs.dart';
import 'package:sevin_rm/UI/Screens/login/cubit/cubit.dart';
import 'package:sevin_rm/UI/Screens/login/login_controller.dart';
import 'package:sevin_rm/UI/Screens/main_screen/main_screen.dart';
import 'package:sevin_rm/helper/PusherHelper.dart';
import 'package:sevin_rm/helper/error_dialog_helper.dart';
import 'package:sevin_rm/helper/snack_bar_helper.dart';

import '../ChangPassword/ChangPassWord.dart';
import '../Register/Register.dart';
import '../component/Widght.dart';
import '../conset/Const.dart';
import 'cubit/status.dart';

//////
class LoginW extends StatefulWidget {
  LoginW({Key? key}) : super(key: key);

  @override
  State<LoginW> createState() => _LoginWState();
}

class _LoginWState extends State<LoginW> {
  String? selectedCountryCode;
  final String flag = '🇦🇪';
  final String callingCode = '+971';
  LoginController loginController = LoginController();

  List<Map<String, String>> countries = [
    {'code': '+1', 'flag': '🇺🇸'},
    {'code': '+44', 'flag': '🇬🇧'},
    {'code': '+91', 'flag': '🇮🇳'},
    // قم بإضافة بيانات الدول الأخرى هنا
  ];

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
          create: (context) => LoginCubit(),
          child: BlocConsumer<LoginCubit, LoginStates>(
            listener: (context, state) {
              if (state is ErrorState) {
                DialogHelper.errorDialog(context, "Error", state.error);
              } else if (state is Success) {
                if(state.authentication.status!=true){
                  DialogHelper.errorDialog(context, "Error", state.authentication.message??'');
                }
                else {
                  SnackBarHelper.mySnackBar("Login Successfully", context);
                print("AccessTokenLogin : ${state.authentication.access_token}");
                DIManager.findDep<SharedPrefs>()
                    .setToken(state.authentication.access_token);
                  DIManager.findDep<SharedPrefs>()
                      .setYourEmail(state.authentication.user?.email);
                  DIManager.findDep<SharedPrefs>()
                      .setUserNamePerson(state.authentication.user?.firstName);
                  DIManager.findDep<SharedPrefs>()
                      .setUserNamePerson2(state.authentication.user?.lastName);
                DIManager.findDep<SharedPrefs>()
                    .setPasswordToken(state.authentication.password_token);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  // return const MyApp();
                  return MainScreen();
                }));
                }
                // print('تم النقر على الزر!');
              }
            },
            builder: (context, state) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding:  EdgeInsets.all(16.sp),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50.sp,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Container(
                            width: 120.sp,
                            height: 150.sp,
                            child: Image.asset(
                              'assets/images/main/7rmlogo.png',
                            ),
                          ),
                        ),
                        text(
                          title: "'title'.tr",
                          color: Color2,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        text(
                          title: "HORSE AUCTIONS AND BOOKING",
                          color: Color2,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            text(
                              title: "You are welcome",
                              color: Color2,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                            const Spacer()
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Center(
                          child: Row(
                            children: [
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color1,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(flag,
                                          style: const TextStyle(fontSize: 14)),
                                      const SizedBox(width: 4.0),
                                      Text(callingCode,
                                          style: const TextStyle(fontSize: 14)),
                                    ],
                                  )),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05),
                              Expanded(
                                child: TextFieldWidght(
                                    widthC: MediaQuery.of(context).size.width *
                                        0.25,
                                    heightC:
                                        MediaQuery.of(context).size.height *
                                            0.08,
                                    radius: 15.0,
                                    colorBorder: Color1,
                                    keyboardType: TextInputType.phone,
                                    colorhint: Color5,
                                    controller: loginController.phone,
                                    widthBorder: 1),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFieldWidght(
                            widthC: MediaQuery.of(context).size.width * 0.90,
                            heightC: MediaQuery.of(context).size.height * 0.080,
                            radius: 15.0,
                            colorBorder: Color1,
                            keyboardType: TextInputType.visiblePassword,
                            colorhint: Color5,
                            widthBorder: 1,
                            controller: loginController.password,
                            hintText: "PassWord"),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          Register(isForgetPassword: true),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Forgot your password?",
                                  style: TextStyle(color: Color2),
                                )),
                            const Spacer()
                          ],
                        ),
                        state is Loading
                            ? Center(
                                child: CircularProgressIndicator(
                                color: Color1,
                              ))
                            : ButtonStaic(
                                onTap: () {
                                  // يتم تنفيذ هذا الكود عند النقر على الزر
                                  if (loginController.validateLogin(context)) {
                                    context.read<LoginCubit>().login(
                                        loginController.phone.text,
                                        loginController.password.text);
                                  }
                                },
                                title: "Sign In",
                                colors: [Color1, Color1],
                                radius: 25.0,
                                widthContainer:
                                    MediaQuery.of(context).size.width * 0.80,
                                heightContainer: 50.0,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color1.withOpacity(0.5),
                                    spreadRadius: 2.0,
                                    blurRadius: 10.0,
                                    offset: const Offset(-1, 6),
                                  ),
                                ],
                                beginGrident: Alignment.topLeft,
                                endGrident: Alignment.bottomRight,
                                colorText: Color3,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                        const SizedBox(
                          height: 10,
                        ),
                        ButtonStaic(
                            onTap: () {
                              DIManager.findDep<SharedPrefs>().setToken(null);
                              if(DIManager.findDep<SharedPrefs>().getToken() == null){
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainScreen()));
                              }

                            },
                            title: "Sign In as a guest",
                            colors: [Color1, Color1],
                            radius: 25.0,
                            widthContainer:
                                MediaQuery.of(context).size.width * 0.55,
                            heightContainer: 50.0,
                            boxShadow: [
                              BoxShadow(
                                color: Color1.withOpacity(0.5),
                                spreadRadius: 2.0,
                                blurRadius: 10.0,
                                offset: const Offset(-1, 6),
                              ),
                            ],
                            beginGrident: Alignment.topLeft,
                            endGrident: Alignment.bottomRight,
                            colorText: Color3,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            text(
                              title: "Don’t have an account?",
                              color: Color2,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          Register(isForgetPassword: false),
                                    ),
                                  );
                                },
                                child: text(
                                    title: "register Now",
                                    color: Color1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
