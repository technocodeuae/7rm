import 'package:flutter/material.dart';

import '../UI/Screens/conset/Const.dart';

class DialogHelper{


  static errorDialog(BuildContext context , String title , String errorMessage){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        backgroundColor: Color1,
        title: Text(title,style: TextStyle(color : Color3)),
        content: Text(errorMessage,style: TextStyle(color : Color3))
      );
    });
  }
  static LoadingDialog(BuildContext context){
    showDialog(context: context, builder: (context) {
      return Center(
        child: Container(
            color: Color3,
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height/2,
            alignment: Alignment.center,
            child: CircularProgressIndicator(color: Color1,)
        ),
      );
    });
  }
}