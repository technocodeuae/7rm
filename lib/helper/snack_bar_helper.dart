import 'package:flutter/material.dart';
import 'package:sevin_rm/UI/Screens/conset/Const.dart';
class SnackBarHelper{
  static mySnackBar(title,BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(title,style: TextStyle(color: Color3),) , backgroundColor: Color1,));
  }
}