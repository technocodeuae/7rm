import 'package:flutter/material.dart';
import 'package:sevin_rm/UI/Screens/ResetPassword/cubit/cubit.dart';
import 'package:sevin_rm/UI/Screens/ResetPassword/reset_password_controller.dart';
import 'package:sevin_rm/UI/Screens/login/login.dart';
import 'package:sevin_rm/UI/Screens/main_screen/main_screen.dart';
import 'package:sevin_rm/helper/error_dialog_helper.dart';
import 'package:sevin_rm/helper/snack_bar_helper.dart';

import '../component/Widght.dart';
import '../conset/Const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/reset_password_states.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({Key? key , required this.isForgetPassword , this.mobile}) : super(key: key);
  final String flag = '🇦🇪';
  final String callingCode = '+971';
  bool isForgetPassword;
  String? mobile;
  ResetPasswordController resetController = ResetPasswordController();
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
          create: (context) => ResetPasswordCubit(),
          child:  BlocConsumer<ResetPasswordCubit,ResetPasswordStates>(
          listener: (context, state) {
            if(state is ErrorState){
              DialogHelper.errorDialog(context, "Error", state.error);
            }else if(state is Success){
              SnackBarHelper.mySnackBar("Reset Password Successfully", context);
              if(isForgetPassword){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return  LoginW();
                }));
              }
              else {
                Navigator.pushReplacement(context, MaterialPageRoute(builder:
                    (context) {
                  return MainScreen();
                }));
              }
            }
          },
          builder: (context, state) {
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
                    color: Colors.black,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SafeArea(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                               Row(
                                children: [
                                  Text(
                                    isForgetPassword ? "ForgetPassword" : "Reset password",
                                    style: const TextStyle(
                                        color: Color.fromRGBO(35, 0, 44, 1),
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const Spacer()
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Center(
                                child: Row(
                                  children: [
                                    Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width *
                                            0.25,
                                        height: MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.08,
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color.fromRGBO(
                                                90, 0, 114, 1),
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              15.0),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(flag,
                                                style: const TextStyle(
                                                    fontSize: 14)),
                                            const SizedBox(width: 4.0),
                                            Text(callingCode,
                                                style: const TextStyle(
                                                    fontSize: 14)),
                                          ],
                                        )),
                                    const SizedBox(width: 16.0),
                                    Expanded(
                                      child: TextFieldWidght(
                                          widthC:
                                          MediaQuery
                                              .of(context)
                                              .size
                                              .width *
                                              0.90,
                                          heightC:
                                          MediaQuery
                                              .of(context)
                                              .size
                                              .height *
                                              0.080,
                                          radius: 15.0,
                                          colorBorder: Color1,
                                          keyboardType: TextInputType.phone,
                                          colorhint: Color5,
                                          controller: resetController.phone,
                                          widthBorder: 1,
                                          isEnabled: mobile!=null ? false : true,
                                          hintText: mobile??"0503140232"),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              TextFieldWidght(
                                  widthC: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.90,
                                  heightC: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.080,
                                  radius: 15.0,
                                  colorBorder: Color1,
                                  keyboardType: TextInputType.visiblePassword,
                                  colorhint: Color5,
                                  widthBorder: 1,
                                  controller: resetController.password,
                                  hintText: "Password"),
                              const SizedBox(
                                height: 40,
                              ),
                              TextFieldWidght(
                                  widthC: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.90,
                                  heightC: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.080,
                                  radius: 15.0,
                                  colorBorder: Color1,
                                  keyboardType: TextInputType.visiblePassword,
                                  colorhint: Color5,
                                  widthBorder: 1,
                                  controller: resetController.confirm_password,
                                  hintText: "Confirm Password"),

                              SizedBox(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.150,
                              ),
                              state is Loading ? Center(child: CircularProgressIndicator(color: Color1,))
                                  :
                              GestureDetector(
                                onTap: () {
                                  if(isForgetPassword){
                                    resetController.phone.text = mobile!;
                                  }
                                  if(resetController.validateReset(context)){
                                    context.read<ResetPasswordCubit>().
                                    resetPassword(resetController.phone.text, resetController.password.text);
                                  }
                                },
                                child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.90,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromRGBO(90, 0, 114, 1),
                                        Color.fromRGBO(90, 0, 114, 1)
                                        // const Color(0xFFFF80AB), // زهري فاتح
                                        // const Color(0xFFFF4081), // زهري غامق
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromRGBO(
                                            90, 0, 114, 1)
                                            .withOpacity(0.5),
                                        spreadRadius: 2.0,
                                        blurRadius: 10.0,
                                        offset: const Offset(-1, 6),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "ResetPassword",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          })
        )]),
    );
  }
}
