import 'package:flutter/material.dart';
import 'package:sevin_rm/helper/snack_bar_helper.dart';

class ResetPasswordController{
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();


  bool validateReset(BuildContext context)
  {
    if (phone.text.isNotEmpty) {
      if (password.text.isNotEmpty && password.text.length >= 8
          && confirm_password.text.isNotEmpty && confirm_password.text.length>=8
      &&password.text==confirm_password.text) {
        return true;
      }
      else {
        if (password.text.isEmpty) {
          SnackBarHelper.mySnackBar("please_enter_password",context);
        }else if (confirm_password.text.isEmpty){
          SnackBarHelper.mySnackBar("please_enter_confirm_password",context);
        } else if (password.text.length < 8 || confirm_password.text.length < 8) {
          SnackBarHelper.mySnackBar("should_be_at_least_8_character",context);
        } else if (password.text!=confirm_password.text){
          SnackBarHelper.mySnackBar("Doesn't match between password",context);
        }
      }
    } else {
      if (phone.text.isEmpty) {
        SnackBarHelper.mySnackBar("please_enter_a_phone_number",context);
      }
    }
    return false;
  }
}