import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sevin_rm/UI/Screens/Register/cubit/cubit.dart';
import 'package:sevin_rm/UI/Screens/Register/register_controller.dart';
import 'package:sevin_rm/UI/Screens/conset/Const.dart';
import 'package:sevin_rm/UI/Screens/login/login.dart';
import 'package:sevin_rm/UI/Screens/main_screen/main_screen.dart';
import 'package:sevin_rm/data/models/auth/auth_model.dart';
import 'package:sevin_rm/helper/snack_bar_helper.dart';
import 'package:sizer/sizer.dart';

import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../../helper/error_dialog_helper.dart';
import '../component/Widght.dart';
import 'cubit/sign_up_states.dart';

// Import the SignUpBloc file


class SignUp_Screen extends StatefulWidget {
  SignUp_Screen({Key? key , required this.myPhone}) : super(key: key);
  String myPhone ;

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  RegisterController  registerController = RegisterController();
  String country = '';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple.withOpacity(0.5),
            leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                  return LoginW();
                }), (route) => false);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            title: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 20.sp),),
            centerTitle: true,
            actions: null,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: BlocConsumer<RegisterCubit, RegisterState>(
              listener: (context, state) {
                if (state is ErrorStateRegister) {
                  DialogHelper.errorDialog(context, "Error", state.error);
                }else if (state is SuccessRegister) {
                  if (state.authenticationRegister.status != true) {
                    DialogHelper.errorDialog(context, "Error",
                        state.authenticationRegister.message!);
                  } else {
                    SnackBarHelper.mySnackBar("Register Successfully", context);
                    (state.authenticationRegister.access_token);
                    DIManager.findDep<SharedPrefs>()
                        .setToken(state.authenticationRegister.access_token);
                    DIManager.findDep<SharedPrefs>()
                        .setYourEmail(state.authenticationRegister.user?.email);
                    DIManager.findDep<SharedPrefs>()
                        .setUserNamePerson(state.authenticationRegister.user?.firstName);
                    DIManager.findDep<SharedPrefs>()
                        .setUserNamePerson2(state.authenticationRegister.user?.lastName);
                    DIManager.findDep<SharedPrefs>()
                        .setPasswordToken(state.authenticationRegister.password_token);
                    // DIManager.findDep<SharedPrefs>()
                    //     .setPasswordToken(
                    //     state.authenticationRegister.password_token);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                          // return const MyApp();
                          return MainScreen();
                        }));
                  }
                }
              },
              builder: (context, state) {
                return  Stack(
                  children: [
                    Image.asset(
                      'assets/images/main/image 12.png',
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      height: 800.sp,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 12.sp),
                      child: Column(
                        children: [
                          // SizedBox(
                          //   height: 20.sp,
                          // ),
                          //
                          // Text(
                          //   'Sign Up',
                          //   style: TextStyle(
                          //     fontSize: 20.sp,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          // SizedBox(height: 1.h),
                          // Text(
                          //   'HORSE AUCTIONS AND BOOKING',
                          //   style: TextStyle(
                          //     fontSize: 12.sp,
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Container(
                              width: 80.sp,
                              height: 80.sp,
                              child: Image.asset(
                                'assets/images/main/7rmlogo.png',
                              ),
                            ),
                          ),
                          // Example of using Bloc for updating the first name
                          title(text: "Your Name"),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: CustomTextField(
                                  hint: "First Name",
                                  controller: registerController.firstNameController,
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Expanded(
                                flex: 1,
                                child: CustomTextField(
                                  hint: "Last Name",
                                  controller: registerController.lastNameController,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          title(text: "Username"),
                          CustomTextField(
                            hint: "username",
                            controller: registerController.usernameController,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          title(text: "Email"),
                          CustomTextField(
                            type: TextInputType.emailAddress,
                            hint: "email",
                            controller: registerController.emailController,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          title(text: "Password"),
                          CustomTextField(
                            hint: "password",
                            controller: registerController.passwordController,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          title(text: "ConfirmPassword"),
                          CustomTextField(
                            hint: "confirm password",
                            controller: registerController.confirmPasswordController,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          title(text: "Your Phone"),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width: 29.w,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5.w, color: Colors.purple),
                                      borderRadius: BorderRadius.circular(13.sp)),
                                  child: InternationalPhoneNumberInput(
                                    selectorConfig: SelectorConfig(
                                      leadingPadding: 4.w,
                                      selectorType: PhoneInputSelectorType.DIALOG,
                                      showFlags: true,
                                      useEmoji: false,
                                      trailingSpace: false,
                                      setSelectorButtonAsPrefixIcon: true,
                                    ),
                                    formatInput: true,
                                    isEnabled: false,
                                    spaceBetweenSelectorAndTextField: 0,
                                    initialValue: PhoneNumber(
                                        phoneNumber: "+971", dialCode: "+971", isoCode: "AE"),
                                    onInputChanged: (PhoneNumber value) {
                                    },
                                    searchBoxDecoration: InputDecoration(
                                      hintText: 'Search',
                                      filled: true,
                                      fillColor: const Color(0xffEAEAEA),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          color: Color(0xffEAEAEA),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                            width: 1.8, color: Colors.purple),
                                      ),
                                    ),
                                    inputDecoration: InputDecoration(
                                      labelText: 'Phone',
                                      labelStyle: const TextStyle(),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          color: Color(0xffEAEAEA),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          width: 1.8,
                                          color: Colors.purple,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          width: 1.8,
                                          color: Colors.purple,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xffEAEAEA),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(15)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Expanded(
                                  flex: 2,
                                  child : CustomTextField(
                                    hint: widget.myPhone,
                                    isEnabled: false,
                                    type: TextInputType.number,
                                  )
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          title(text: 'Your Gender'),
                          Container(
                            height: MediaQuery.sizeOf(context).height * 0.07,
                            width: MediaQuery.sizeOf(context).width,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.purple, width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: DropdownButton<String>(
                              value: registerController.selectedGender,
                              icon:  Padding(
                                padding: EdgeInsets.only(left: 180.sp),
                                child: Icon(Icons.arrow_downward),
                              ),
                              iconSize: 24,
                              elevation: 500,
                              padding: const EdgeInsets.only(left: 5),
                              style:
                              const TextStyle(color: Colors.purple, fontSize: 18),
                              underline: Container(
                                  padding: const EdgeInsets.all(20),
                                  height: 3,
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                              onChanged: (value) {
                                setState(() {
                                  registerController.selectedGender = value!;
                                });
                              },
                              items: registerController.genders
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                    ),
                                    child: Text(value),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              title(text: "Choose yor country"),
SizedBox(width: 10.sp),
                              Container(
                                width: 130.sp,
                                height: 44.sp,
                                decoration: BoxDecoration(
                                  // color: Color.fromRGBO(190, 140, 206, 1),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Colors.purple,
                                    width: 2.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: [
                                      DropdownButton<String>(iconSize: 0,
                                        underline: Container(),isDense: true,
                                        value: selectedOption,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedOption = newValue;
                                            country = newValue ?? '';
                                            registerController.aboutController.text = newValue ?? '';
                                          });
                                        },
                                        items: <String>[
                                          'Abu Dhabi',
                                          'Dubai',
                                          'Sharjah',
                                          'Ajman',
                                          'Umm Al-Quwain',
                                          'Fujairah',
                                          'Ras Al Khaimah',
                                        ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: text(
                                                    title: value,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.87)),
                                              );
                                            }).toList(),
                                      ),

                                      Icon(Icons.arrow_drop_down_outlined,size: 20,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // CustomTextField(
                          //   hint: "A brief about yourself",
                          //   controller: registerController.aboutController,
                          // ),
                          SizedBox(
                            height: 2.h,
                          ),
                          state is LoadingRegister? Center(child: CircularProgressIndicator(color: Color1,))
                              :ButtonStaic(
                              onTap: () {
                                // يتم تنفيذ هذا الكود عند النقر على الزر
                                if (registerController.validateRegister(context)) {
                                  UserAuthenticateModel user =
                                  UserAuthenticateModel(
                                    firstName: registerController.firstNameController.text,
                                    lastName: registerController.lastNameController.text,
                                    userName: registerController.usernameController.text,
                                    email: registerController.emailController.text,
                                    gender: registerController.selectedGender,
                                    mobile: widget.myPhone,
                                    country: country,
                                  );
                                  BlocProvider.of<RegisterCubit>(context).
                                  register(user, null, registerController.passwordController.text);
                                }
                              },
                              title: "Sign Up",
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
                        ],
                      ),
                    ),

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

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final TextInputType? type;
  final void Function(String)? onChanged;
  final bool? isEnabled;

  CustomTextField({required this.hint, this.controller, this.onChanged, this.type, this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      enabled: isEnabled,
      keyboardType: type??TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: BorderSide(width: 0.5.w, color: Colors.purple),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: BorderSide(width: 0.5.w, color: Colors.purple),
        ),
      ),
    );
  }
}

class title extends StatelessWidget {
  final String text;

  title({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
/*
// Events
abstract class SignUpEvent extends Equatable {}

class FirstNameChangedEvent extends SignUpEvent {
  final String firstName;

  FirstNameChangedEvent(this.firstName);

  @override
  List<Object?> get props => [firstName];
}

class LastNameChangedEvent extends SignUpEvent {
  final String lastName;

  LastNameChangedEvent(this.lastName);

  @override
  List<Object?> get props => [lastName];
}

class EmailChangedEvent extends SignUpEvent {
  final String email;

  EmailChangedEvent(this.email);

  @override
  List<Object?> get props => [email];
}*/

/*

// States
abstract class SignUpState extends Equatable {}

class SignUpInitialState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignUpFormUpdatedState extends SignUpState {
  final String firstName;
  final String lastName;
  final String email;

  SignUpFormUpdatedState({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  List<Object?> get props => [firstName, lastName, email];
}
*/

// BLoC
/*
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitialState());

  String firstName = '';
  String lastName = '';
  String email = '';
  String selectedGender = 'Male';
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is FirstNameChangedEvent) {
      firstName = event.firstName;
    } else if (event is LastNameChangedEvent) {
      lastName = event.lastName;
    } else if (event is EmailChangedEvent) {
      email = event.email;
    } else if (event is GenderChangedEvent) {
      selectedGender = event.gender;
    }

    // Emit the updated state
    yield SignUpFormUpdatedState(
      firstName: firstName,
      lastName: lastName,
      email: email,
    );
  }
}
*/

/*
class GenderChangedEvent extends SignUpEvent {
  final String gender;

  GenderChangedEvent(this.gender);

  @override
  List<Object?> get props => [gender];
}
*/
