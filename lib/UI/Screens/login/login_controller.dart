import 'package:flutter/cupertino.dart';

import '../../../helper/snack_bar_helper.dart';

class LoginController {
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  bool validateLogin(BuildContext context) {
    if (phone.text.isNotEmpty) {
      if (password.text.isNotEmpty && password.text.length >= 8) {
        return true;
      } else {
        if (password.text.isEmpty) {
          SnackBarHelper.mySnackBar("please_enter_password", context);
        } else if (password.text.length < 8) {
          SnackBarHelper.mySnackBar("should_be_at_least_8_character", context);
        }
      }
    } else {
      if (phone.text.isEmpty) {
        SnackBarHelper.mySnackBar("please_enter_a_phone_number", context);
      }
    }
    return false;
  }
}
