import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sevin_rm/UI/Screens/profile/profile2.dart';

import '../../../helper/camera.dart';
import '../../../helper/error_dialog_helper.dart';
import '../../../helper/snack_bar_helper.dart';
import '../../util/app_them.dart';
import '../component/Widght.dart';
import '../conset/Const.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'edit.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key? key,
  }) : super(key: key);
  @override
  State<EditProfile> createState() => HexagonButtonPageState();
}

class HexagonButtonPageState extends State<EditProfile> {
  int selectedValue = 1;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
  }
  String dateTime = '';
  TextEditingController dateInput = TextEditingController();
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  ////
  String? selectedValueItems = '';
  XFile? imageFileFront;
  void _openGallery(BuildContext context) async {
    final picker = ImagePicker();
    XFile pickedFile = (await picker.pickImage(source: ImageSource.gallery))!;

    // FileManagerCamera camera = FileManagerCamera();
    // XFile? imageFileFront2= await  camera.imagePickerFromGallery(image: pickedFile);
    setState(()  {
      imageFileFront = pickedFile;
    });
    // Navigator.pop(context);
  }


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
          create: (BuildContext context) => ProfileCubitPage()..getProfile(),
          child: BlocConsumer<ProfileCubitPage, ProfileCubitPageStates>(
              listener: (BuildContext context, state) {
            if (state is GetProfileErrorStates) {
              DialogHelper.errorDialog(
                  context, "Error", state.error.toString());
            }
            if (state is UpdateProfileErrorStates) {
              DialogHelper.errorDialog(
                  context, "Error", state.error.toString());
            }
            // if (state is GetProfileSuccessStates) {
            //   SnackBarHelper.mySnackBar("fetch Success", context);
            //   (state.profileModel.message,);
            // }
            if (state is UpdateProfileSuccessStates) {
              SnackBarHelper.mySnackBar("update Success", context);
              (state.updateProfileModel.message,);
              ProfileCubitPage.get(context).getProfile();
            }
          }, builder: (BuildContext context, state) {
            return (state is GetProfileSuccessStates)
                ? Scaffold(
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
                          color: Color1,
                          size: 30,
                        ),
                      ),
                      title: Container(
                        width: 230,
                        alignment: Alignment.center,
                        child: text(
                            title: 'Edit Profile',
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Color1),
                      ),
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  HexagonLine(
                                      lineColor:
                                          Color.fromRGBO(190, 140, 206, 1),
                                      size: 130),
                                  Container(
                                    width: 180,
                                    height: 180,
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                          HexagonImage(
                                          size: 600,
                                          // حجم الشكل السداسي
isFile:imageFileFront == null? false : true,
                                          imagePath: imageFileFront == null ? '': imageFileFront!.path ,
                                          imageUrl:
                                              // 'assets/images/main/image 104.png',
                                              // 'assets/images/main/image 104.png', // عنوان URL للصورة
                                              state.profileModel.data!
                                                      .userImage ??
                                                  "",
                                        ) ,
                                        IconButton(
                                            onPressed: () {
                                              _openGallery(context);

                                            },
                                            icon: const Icon(
                                              Icons.camera_alt_outlined,
                                              color: Colors.white,
                                              size: 35,
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            color: Color.fromRGBO(113, 104, 116, 0.8),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: 44,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color1,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 25, bottom: 3),
                              child: TextFormField(
                                // controller: controller, ليش مو حاطة هون
                                controller: usernameController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Container(
                                    width: 20,
                                    height: 20,
                                    child: Image.asset(
                                      'assets/images/main/ic_user.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Color2,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                  hintText: state.profileModel.data!.userName,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: 44,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color1,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 25, bottom: 3),
                              child: TextFormField(
                                controller: emailController,
                                // controller: controller,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Container(
                                    width: 20,
                                    height: 20,
                                    child: Image.asset(
                                      'assets/images/main/ic_email.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Color2,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                  hintText: state.profileModel.data!.email,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Container(
                            decoration: BoxDecoration(boxShadow: <BoxShadow>[]),
                            margin: EdgeInsets.all(15),
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.blueGrey,
                                    minimumSize: const Size(311, 44),
                                    elevation: 1,
                                    primary: secondaryColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ))),
                                onPressed: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                    dateTime = formattedDate;
                                    print(
                                        dateTime); //formatted date output using intl package =>  2021-03-16
                                    setState(() {
                                      dateInput.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {}
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      dateTime == ''
                                          ? DateFormat('yyyy-MM-dd').format(
                                              state.profileModel.data!
                                                  .createdAt!)
                                          : dateTime,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        Icons.date_range,
                                        color: primaryColor,
                                        size: 35,
                                      ),
                                      onPressed: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1950),
                                            //DateTime.now() - not to allow to choose before today.
                                            lastDate: DateTime(2100));

                                        if (pickedDate != null) {
                                          print(
                                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                          //formatted date output using intl package =>  2021-03-16
                                          setState(() {
                                            dateInput.text =
                                                formattedDate; //set output date to TextField value.
                                          });
                                          dateTime = formattedDate;
                                          print(dateTime);
                                        } else {}
                                      },
                                    ),
                                  ],
                                )),
                          ),
                          // Container(
                          //   width: MediaQuery.of(context).size.width * 0.90,
                          //   height: 44,
                          //   decoration: BoxDecoration(
                          //     border: Border.all(
                          //       color: Color1,
                          //       width: 1.0,
                          //     ),
                          //     borderRadius: BorderRadius.circular(25.0),
                          //   ),
                          //   child: Padding(
                          //     padding:
                          //     const EdgeInsets.only(left: 25, bottom: 3),
                          //     child: TextFormField(
                          //       controller: firstNameController,
                          //       // controller: controller,
                          //       keyboardType: TextInputType.datetime,
                          //       decoration: InputDecoration(
                          //         border: InputBorder.none,
                          //         suffixIcon: Container(
                          //           width: 20,
                          //           height: 20,
                          //           child: Image.asset(
                          //             'assets/images/main/ic_calendar.png',
                          //             width: 20,
                          //             height: 20,
                          //           ),
                          //         ),
                          //         hintStyle: TextStyle(
                          //             color: Color2,
                          //             fontSize: 15,
                          //             fontWeight: FontWeight.w400),
                          //         hintText: state.profileModel.data!.createdAt.toString(),
                          //
                          //         // dataProfile!.data!.createdAt == null
                          //         //     ? ""
                          //         //     : dataProfile!.data!.createdAt as String
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: 44,
                            child: Row(
                              children: [
                                text(
                                    title: "Gender",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(0, 0, 0, 0.5)),
                                Expanded(
                                  // أو Flexible
                                  child: RadioListTile(
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
                                Expanded(
                                  // أو Flexible
                                  child: RadioListTile(
                                    activeColor:
                                        Color.fromRGBO(190, 140, 206, 1),
                                    title: Text(
                                      'Woman',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    value: 2,
                                    contentPadding: EdgeInsets.zero,
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
                          Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: 44,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color1,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 25, bottom: 3),
                              child: TextFormField(
                                // controller: controller,
                                controller: phoneController,
                                readOnly: true,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Container(
                                    width: 70,
                                    child: Row(children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        child: Image.asset(
                                          'assets/images/main/ic_verified.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        child: Image.asset(
                                          'assets/images/main/ic_call.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                    ]),
                                  ),
                                  prefixIcon: Container(
                                    width: 70,
                                    child: Row(children: [
                                      text(
                                          title: "+971",
                                          color: Color.fromRGBO(0, 0, 0, 0.5),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Color.fromRGBO(90, 0, 114, 0.5),
                                      )
                                    ]),
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                  hintText: state.profileModel.data!.mobile,

                                  // dataProfile!.data!.fullMobileNumber,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),

                          //       Center(
                          //         child: DropdownButtonHideUnderline(
                          //           child: DropdownButton2<String>(
                          //             isExpanded: true,
                          //             hint: const Row(
                          //               children: [
                          //                 Icon(
                          //                   Icons.list,
                          //                   size: 16,
                          //                   color: Colors.yellow,
                          //                 ),
                          //                 SizedBox(
                          //                   width: 4,
                          //                 ),
                          //                 Expanded(
                          //                   child: Text(
                          //                     'Select Item',
                          //                     style: TextStyle(
                          //                       fontSize: 14,
                          //                       fontWeight: FontWeight.bold,
                          //                       color: Colors.yellow,
                          //                     ),
                          //                     overflow: TextOverflow.ellipsis,
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //             items: [
                          //               ...items.map((e) => DropdownMenuItem(
                          //             child: Text(e),
                          //         value: e,
                          //       ),
                          // )
                          //   ],
                          //
                          //             value: selectedValueItems,
                          //             onChanged: (String? value) {
                          //               setState(() {
                          //                 selectedValueItems = value;
                          //               });
                          //             },
                          //             buttonStyleData: ButtonStyleData(
                          //               height: 50,
                          //               width: 160,
                          //               padding: const EdgeInsets.only(left: 14, right: 14),
                          //               decoration: BoxDecoration(
                          //                 borderRadius: BorderRadius.circular(14),
                          //                 border: Border.all(
                          //                   color: Colors.black26,
                          //                 ),
                          //                 color: Colors.redAccent,
                          //               ),
                          //               elevation: 2,
                          //             ),
                          //             iconStyleData: const IconStyleData(
                          //               icon: Icon(
                          //                 Icons.arrow_forward_ios_outlined,
                          //               ),
                          //               iconSize: 14,
                          //               iconEnabledColor: Colors.yellow,
                          //               iconDisabledColor: Colors.grey,
                          //             ),
                          //             dropdownStyleData: DropdownStyleData(
                          //               maxHeight: 200,
                          //               width: 200,
                          //               decoration: BoxDecoration(
                          //                 borderRadius: BorderRadius.circular(14),
                          //                 color: Colors.redAccent,
                          //               ),
                          //               offset: const Offset(-20, 0),
                          //               scrollbarTheme: ScrollbarThemeData(
                          //                 radius: const Radius.circular(40),
                          //                 thickness: MaterialStateProperty.all<double>(6),
                          //                 thumbVisibility: MaterialStateProperty.all<bool>(true),
                          //               ),
                          //             ),
                          //             menuItemStyleData: const MenuItemStyleData(
                          //               height: 40,
                          //               padding: EdgeInsets.only(left: 14, right: 14),
                          //             ),
                          //           ),
                          //         ),
                          //       ),

                          // Container(
                          //   width: MediaQuery.of(context).size.width * 0.90,
                          //   height: 44,
                          //   decoration: BoxDecoration(
                          //     // color: Color.fromRGBO(190, 140, 206, 1),
                          //     borderRadius: BorderRadius.circular(30),
                          //     border: Border.all(
                          //       color: Colors.white,
                          //       width: 2.0,
                          //     ),
                          //   ),
                          //   child: Padding(
                          //     padding: const EdgeInsets.symmetric(horizontal: 20),
                          //     child: Row(
                          //       children: [
                          //         DropdownButton<String>(iconSize: 0,
                          //           underline: null,isDense: true,
                          //           value: selectedOption,
                          //           onChanged: (String? newValue) {
                          //             setState(() {
                          //               selectedOption = newValue;
                          //             });
                          //           },
                          //           items: <String>[
                          //             '1000',
                          //             '2000',
                          //             '3000',
                          //             '4000'
                          //           ].map<DropdownMenuItem<String>>(
                          //                   (String value) {
                          //                 return DropdownMenuItem<String>(
                          //                   value: value,
                          //                   child: text(
                          //                       title: value,
                          //                       fontSize: 14,
                          //                       fontWeight: FontWeight.w400,
                          //                       color: Color.fromRGBO(
                          //                           0, 0, 0, 0.87)),
                          //                 );
                          //               }).toList(),
                          //         ),
                          //         Spacer(),
                          //         Icon(Icons.arrow_drop_down_outlined,size: 20,),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          //

                          SizedBox(
                            height: 12.h,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: 44,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color1,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 25, bottom: 3),
                              child: TextFormField(
                                controller: countryController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  // suffixIcon: Icon(
                                  //   Icons.arrow_drop_down,
                                  // ),

                                  hintStyle: TextStyle(
                                    color: Color7,
                                    fontSize: 15,
                                  ),
                                  hintText: state.profileModel.data!.country ??
                                      'Choose your country',

                                  // dataProfile!.data!.country,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            //
                            width: 231,
                            height: 33,
                            alignment: Alignment.center,
                            child: text(
                                title:
                                    "Your email verification is still pending.Please verify your account. ",
                                textAlign: TextAlign.center,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(0, 0, 0, 0.5)),
                          ),
                          SizedBox(
                            height: 34,
                          ),
                          ButtonStaic(
                              onTap: () {
                                print(firstNameController.text);
                                print(lastNameController.text);
                                context.read<ProfileCubitPage>().updateProfile(
                                      firstName: firstNameController
                                              .text.isEmpty
                                          ? state.profileModel.data!.firstName
                                          : firstNameController.text,
                                      lastName: lastNameController.text.isEmpty
                                          ? state.profileModel.data!.lastName
                                          : lastNameController.text,
                                      email: emailController.text.isEmpty
                                          ? state.profileModel.data!.email
                                          : emailController.text,
                                      userName: usernameController.text.isEmpty
                                          ? state.profileModel.data!.userName
                                          : usernameController.text,
                                      dateOfBirth: dateInput.text.isEmpty
                                          ? DateFormat('yyyy-MM-dd').format(
                                              state.profileModel.data!
                                                  .createdAt!)
                                          : dateInput.text,
                                      mobile: phoneController.text.isEmpty
                                          ? state.profileModel.data!.mobile
                                          : phoneController.text,
                                      location: countryController.text.isEmpty
                                          ? state.profileModel.data!.country
                                          : countryController.text,
                                      gender: selectedValue == 0
                                          ? "male"
                                          : "female",
                                  // userImage:  File(imageFileFront?.path ?? '')
                                    );
                              },
                              title: "Update Profile",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              colorText: Colors.white70,
                              heightContainer: 44,
                              widthContainer:
                                  MediaQuery.of(context).size.width * 0.80),
                          SizedBox(
                            height: 34,
                          ),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
        ),
      ]),
    );
  }
}

//Center(child: CircularProgressIndicator(color: Color1,),);
