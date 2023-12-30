import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

import 'package:otp_text_field/otp_text_field.dart';

import 'package:otp_text_field/style.dart';
import 'package:sevin_rm/UI/Screens/Register/cubit/cubit.dart';
import 'package:sevin_rm/UI/Screens/Register/sign_up_screen.dart';
import 'package:sevin_rm/UI/Screens/component/Widght.dart';
import 'package:sevin_rm/UI/Screens/conset/Const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevin_rm/helper/error_dialog_helper.dart';

import '../../../helper/snack_bar_helper.dart';
import '../ResetPassword/ResetPassword.dart';
import 'cubit/sign_up_states.dart';


class ForgotPasswordVerificationPage extends StatefulWidget {
  String mobile ;
  String mobileOTP ;
  bool isForgetPassword;
  ForgotPasswordVerificationPage({Key? key ,required this.mobile , required this.isForgetPassword,required this.mobileOTP}) : super(key: key);
  @override
  State<ForgotPasswordVerificationPage> createState() {
    return _ForgotPasswordVerificationPageState();
  }
}

class _ForgotPasswordVerificationPageState
    extends State<ForgotPasswordVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  List<String> otpValues = ['', '', '', '', ''];
  bool iscolor = false;

  bool _pinSuccess = false;

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 300;
    dynamic otp;
    return Scaffold(
        backgroundColor: Color3,
        body: Stack(
          children: [
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
                  icon: Icon(Icons.arrow_back, color: Color1),
                ),
              ),
              body: SingleChildScrollView(
                child: BlocProvider(
                  create: (context) => RegisterCubit(),
                  child: BlocConsumer<RegisterCubit,RegisterState>(
                    listener: (context, state) {
                      if (state is ErrorStateValidate) {
                        DialogHelper.errorDialog(context, "Error", state.error);
                      }else if (state is SuccessValidate) {
                        print("Validation ${state.validation}");
                        if(widget.isForgetPassword) {
                          Navigator.push(context , MaterialPageRoute(builder: (context) {
                            return ResetPassword(isForgetPassword: widget.isForgetPassword,mobile: widget.mobile);
                          }));
                        }else{
                          // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
                          Navigator.pushAndRemoveUntil(context , MaterialPageRoute(builder: (context) {
                            return SignUp_Screen(myPhone: widget.mobile,);
                          }),(route) => false);
                        }
                        // widget.isForgetPassword?
                        // Navigator.push(context , MaterialPageRoute(builder: (context) {
                        //   return ResetPassword(isForgetPassword: widget.isForgetPassword,mobile: widget.mobile);
                        // })) :
                        // Navigator.push(context , MaterialPageRoute(builder: (context) {
                        //   return SignUp_Screen(myPhone: widget.mobile,);
                        // }));
                      }
                    },
                      builder: (context,state) {

                      return Column(
                            children: [
                              SafeArea(
                                child: Form(
                                  key: _formKey,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          text(
                                              title: "Verification Code",
                                              color: Color2,
                                              fontSize: 28,
                                              fontWeight: FontWeight.w700),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: text(
                                                title:
                                                "Enter the verification code that you received via a text message to your phone number",
                                                textAlign: TextAlign.center,
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(
                                            height:
                                            MediaQuery.of(context).size.height * 0.06,
                                          ),
                                          OTPTextField(
                                            length: 4,
                                            width: 300,
                                            outlineBorderRadius: 400,
                                            fieldWidth: 50,
                                            style: TextStyle(fontSize: 20),
                                            textFieldAlignment:
                                            MainAxisAlignment.spaceAround,
                                            // fieldStyle: FieldStyle.underline,
                                            onCompleted: (pin) {
                                              print("PIN $pin");
                                              if(widget.mobileOTP ==pin ){
                                                BlocProvider.of<RegisterCubit>(context)
                                                    .ValidateMobileNumber(pin, widget.mobile);
                                              }else{

                                                SnackBarHelper.mySnackBar("OTP is not true , try again ..",context);

                                              }

                                              // c.valueotp(pin);
                                              // setState(() {
                                              //   otp = pin;
                                              //   print(pin.toString() +
                                              //       "****************************************************");
                                              //   _pinSuccess = true;
                                              // });
                                            },
                                            fieldStyle: FieldStyle.box,

                                            // outlineBorderRadius: 20,
                                            spaceBetween: 10,
                                            onChanged: (value) {
                                              setState(() {
                                                otpValues = value.split('');
                                                iscolor =
                                                otpValues.contains('') ? false : true;
                                              });
                                            },
                                            otpFieldStyle: OtpFieldStyle(
                                                focusBorderColor:
                                                Color.fromRGBO(19, 140, 206, 1),
                                                backgroundColor:
                                                Color.fromRGBO(190, 140, 206, 1),
                                                disabledBorderColor: Colors.red,
                                                enabledBorderColor: Colors.blue),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          if(state is !LoadingValidate)...[
                                            TimerCountdown(
                                              format: CountDownTimerFormat.hoursMinutesSeconds,
                                              enableDescriptions: false,
                                              timeTextStyle: const TextStyle(
                                                  color: Colors.purple,
                                                  fontSize: 16,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.bold,
                                                  height: 0),
                                              colonsTextStyle: const TextStyle(
                                                  color:  Colors.purple,
                                                  fontSize: 16,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.bold,
                                                  height: 0),
                                              endTime: DateTime.now().add(
                                                  Duration(

                                                      seconds: 25
                                                  )
                                              ),
                                              onEnd: () {
                                                // setState(() {
                                                //   isFinishTime = true;
                                                // });
                                                // isFinishTime = true;
                                              },
                                              /* build: (context, double time) {
                                                            return Text(
                                                              'Time left $time',
                                                              style: const TextStyle(
                                                                color: Color(0xFFAC0000),
                                                                fontSize: 18,
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.bold,
                                                                height: 0,
                                                              ),
                                                            );
                                                          },*/

                                            ),
                                            // text(
                                            //     title: "00:25",
                                            //     textAlign: TextAlign.center,
                                            //     color: Color1,
                                            //     fontSize: 13,
                                            //     fontWeight: FontWeight.w400),
                                            SizedBox(
                                              height: 50.sp,
                                            ),
                                            if(state is SuccessValidate)...[
                                            if(!state.validation)
                                              text(
                                                title: "Otp is Wrong",
                                                color: Colors.red,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                            text(
                                              title: "Didn’t you received any code?",
                                              color: Color2,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            TextButton(
                                                onPressed: () {

                                                  if(widget.isForgetPassword)
                                                  {
                                                    BlocProvider.of<RegisterCubit>(context)
                                                        .sendOtpForgetPassword(widget.mobile);
                                                  }else
                                                  {
                                                    BlocProvider.of<RegisterCubit>(context)
                                                        .sendOtp(widget.mobile);

                                                  }
                                                },
                                                child: text(
                                                    title: "Resend a new code",
                                                    color: Color1,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16)),
                                          ]else...[
                                             Center(child: CircularProgressIndicator(color: Color1,))
                                          ]
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                    }
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
