import 'package:flutter/cupertino.dart';
import 'package:sevin_rm/helper/snack_bar_helper.dart';

class RegisterController{


  TextEditingController mobile = TextEditingController();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  String selectedGender = 'Male';
  List<String> genders = [
  "Male","Female"
  ];

  bool isMobileValidation(BuildContext context){
    if(mobile.text.isNotEmpty){
      if(mobile.text.length==9){
        return true;
      }else{
        SnackBarHelper.mySnackBar("Mobile is Invalid", context);
      }
    }else{
      SnackBarHelper.mySnackBar("please Enter Mobile", context);
    }
    return false;
  }
  bool validateRegister(BuildContext context) {
    // Check if all fields are not empty
    print("firstname ${firstNameController.text} "
        "lastNAme :${lastNameController.text}"
        "userName : ${usernameController.text}"
        "email : ${emailController.text}"
        "password : ${passwordController.text}"
        "confirm : ${confirmPasswordController.text}"
        "country : ${aboutController.text}");
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        aboutController.text.isEmpty) {
      SnackBarHelper.mySnackBar("please fill all Fields ", context);
      return false;
    }

    // Check if password has at least 8 characters
    else if (passwordController.text.length < 8) {
      SnackBarHelper.mySnackBar("password should be at least 8 character", context);
      return false;
    }
    else if(confirmPasswordController.text.length<8){
      SnackBarHelper.mySnackBar("confirm password should be at least 8 character", context);
      return false;
    }
    // Check if phone has exactly 9 characters
    else if (passwordController.text!=confirmPasswordController.text){
      SnackBarHelper.mySnackBar("confirm password doesn't match with password", context);
      return false;
    }
    return true;
  }

}