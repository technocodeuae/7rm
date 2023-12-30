import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sevin_rm/UI/Screens/Register/register_controller.dart';
import 'package:sevin_rm/UI/Screens/component/Widght.dart';
import 'package:sevin_rm/UI/Screens/conset/Const.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevin_rm/UI/Screens/profile/about_app/terms.dart';
import 'package:sevin_rm/helper/error_dialog_helper.dart';
import '../../../helper/snack_bar_helper.dart';
import 'mobile_validation.dart';
import 'cubit/cubit.dart';
import 'cubit/sign_up_states.dart';

class Register extends StatefulWidget {
  bool isForgetPassword;
  Register({Key? key,required this.isForgetPassword}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final String flag = '🇦🇪';

  final String callingCode = '+971';

  RegisterController registerController = RegisterController();

  bool isTrue = false;
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
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Color2,
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
                          text(
                              title: widget.isForgetPassword?"Forget Password" :  "register",
                              color: Color6,
                              fontSize: 28,
                              fontWeight: FontWeight.w700),
                          SizedBox(
                            height: 10,
                          ),
                          !widget.isForgetPassword? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: text(
                                title: "You are welcome",
                                textAlign: TextAlign.center,
                                color: Color2,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ) : const SizedBox.shrink(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          Center(
                            child: Row(
                              children: [
                                Container(
                                    width: 95.sp,
                                    height: 50.sp,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(16.0),
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
                                            style: TextStyle(fontSize: 14)),
                                        SizedBox(width: 4.0),
                                        Text(callingCode,
                                            style: TextStyle(fontSize: 14)),
                                      ],
                                    )),
                                SizedBox(width: 16.0),
                                Expanded(
                                  child: TextFieldWidght(
                                      widthC:350.sp,
                                      heightC:50.sp,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(9),
                                      ],
                                      radius: 15.0,
                                      colorBorder: Color1,
                                      keyboardType: TextInputType.phone,
                                      colorhint: Color5,
                                      controller: registerController.mobile,
                                      widthBorder: 1),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.150,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Row(
                              children: [
                                IconButton(onPressed: (){
                                 setState(() {
                                   isTrue=!isTrue;
                                 });
                                }, icon: !isTrue?Icon(Icons.check_box_outline_blank_rounded):Icon(Icons.check_box,color: Colors.green,)),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context){return TermsAndConditionsPage();}));
                                  },
                                  child: text(
                                      title: "Terms and Conditions",
                                      textAlign: TextAlign.center,
                                      color: Color1,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                Spacer()
                              ],
                            ),
                          ),
                          BlocProvider(
                            create: (context) => RegisterCubit(),
                            child: BlocConsumer<RegisterCubit,RegisterState>(
                              listener: (context, state) {
                                if (state is ErrorStateOTP) {
                                  DialogHelper.errorDialog(context, "Error", state.error);
                                }else if (state is SuccessOTP){
                                  if(!state.otpModel.status!){
                                    DialogHelper.errorDialog(context, "Error", state.otpModel.message!);
                                  }
                                  else{
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            ForgotPasswordVerificationPage(
                                              isForgetPassword: widget.isForgetPassword,
                                                mobile: registerController
                                                    .mobile.text,
                                            mobileOTP: state.otpModel.data??'',
                                            ),
                                      ),
                                    );
                                  }
                                }
                              },
                                builder: (context,state) {


                                return state is LoadingOTP ?
                                      CircularProgressIndicator(color: Color1)
                                    : ButtonStaic(
                                    onTap: () {
                                      if(isTrue){
                                        if(registerController.isMobileValidation(context)){

                                          if(widget.isForgetPassword)
                                          {
                                            BlocProvider.of<RegisterCubit>(context)
                                                .sendOtpForgetPassword(registerController.mobile.text);
                                          }else
                                          {
                                            BlocProvider.of<RegisterCubit>(context)
                                                .sendOtp(registerController.mobile.text);

                                          }




                                        }else{
                                              }

                                      }else{
                                        SnackBarHelper.mySnackBar("You must agree to the terms and conditions",context);

                                      }
                                      print('تم النقر على الزر!');
                                    },
                                    title: "Next",
                                    colors: [Color1, Color1],
                                    radius: 25.0,
                                    widthContainer:
                                        MediaQuery.of(context).size.width * 0.90,
                                    heightContainer: 60.0,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color1.withOpacity(0.5),
                                        spreadRadius: 2.0,
                                        blurRadius: 10.0,
                                        offset: Offset(-1, 6),
                                      ),
                                    ],
                                    beginGrident: Alignment.topLeft,
                                    endGrident: Alignment.bottomRight,
                                    colorText: Color3,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700);
                              }
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                text(
                                  title: "Already have an account?",
                                  color: Color2,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: text(
                                      title: "Sign in",
                                      color: Color2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ],
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
        )
      ]),
    );
  }
}
