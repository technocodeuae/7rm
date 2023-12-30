import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sevin_rm/UI/Screens/conset/Const.dart';

Text text(
        {required String title,
        double? fontSize,
        FontWeight? fontWeight,
        Color? color,
        TextAlign? textAlign}) =>
    Text(
      title,
      textAlign: textAlign,
      style: TextStyle(
          fontSize: fontSize ?? 18,
          fontWeight: fontWeight ?? FontWeight.bold,
          color: color ?? Colors.red),
    );

TextFormField deTextFromFaild(
    {void Function(String)? onChanged,
    String? Function(String?)? validator,
    TextEditingController? controller,
    InputBorder? border,
    TextInputType? keyboardType,
    TextStyle? hintStyle,
    bool ispassword = false,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? hintText}) {
  return TextFormField(
      validator: validator,
      keyboardType: keyboardType,
      controller: controller,
      onChanged: onChanged,
      obscureText: ispassword,
      decoration: InputDecoration(
        border: border,
        hintStyle: hintStyle,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ));
}

MaterialButton dfmaterialButton(
    {GlobalKey<FormState>? KeyTextFaild,
    required void Function()? onPressed,
    Color? color,
    required String title}) {
  return MaterialButton(
    color: Colors.blue,
    onPressed: onPressed,
    child: text(
      title: title,
      color: color ?? Colors.white,
    ),
  );
}

class ComToken {
  String? Token;
  void setToken(String token) {
    Token = token;
  }

  String? getToken() {
    return Token;
  }
}

Widget ContainerWidget({
  AlignmentGeometry? alignment,
  EdgeInsetsGeometry? padding,
  Color? color,
  BorderRadiusGeometry? borderRadius,
  double? width,
  double? height,
  Widget? child,
}) {
  return Container(
    height: height,
    width: width,
    child: child,
    alignment: alignment,
    color: color,
    padding: padding,
    decoration: BoxDecoration(borderRadius: borderRadius, color: color),
  );
}

Widget ButtonStaic(
    {Function()? onTap,
    double? widthContainer,
    double? heightContainer,
    double? radius,
    List<Color>? colors,
    AlignmentGeometry? beginGrident,
    AlignmentGeometry? endGrident,
    required String title,
    double? fontSize,
    FontWeight? fontWeight,
    Color? colorText,
    TextAlign? textAlign,
    List<BoxShadow>? boxShadow}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: widthContainer,
      height: heightContainer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 25.0),
        gradient: LinearGradient(
          colors: colors ??
              [
                Color1,
                Color1,
              ],
          begin: beginGrident ?? Alignment.topLeft,
          end: endGrident ?? Alignment.bottomRight,
        ),
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: Color1.withOpacity(0.5),
                spreadRadius: 2.0,
                blurRadius: 10.0,
                offset: Offset(-1, 6),
              ),
            ],
      ),
      child: Center(
        child: text(
          title: title,
          color: colorText ?? Colors.white,
          fontSize: fontSize ?? 16.0,
          fontWeight: fontWeight ?? FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget TextFieldWidght(
    {double? widthC,
    double? heightC,
    Color? colorBorder,
    double? widthBorder,
    double? radius,
    TextInputType? keyboardType,
    TextEditingController? controller,
    Color? colorhint,
    List<TextInputFormatter>? inputFormatters,
    bool? isEnabled,
    String? hintText}) {
  return Container(
    width: widthC,
    height: heightC,
    decoration: BoxDecoration(
      border: Border.all(
        color: colorBorder ?? Color1,
        width: widthBorder ?? 1.0,
      ),
      borderRadius: BorderRadius.circular(radius ?? 15.0),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: TextFormField(
        enabled: isEnabled,
        controller: controller,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType ?? TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: colorhint ?? Color5,
          ),
          hintText: hintText ?? "Enter you number",
        ),
      ),
    ),
  );
}

///////////////////
////TextField
///
///
///
///homeGesdedector
Widget HomeGesdector(
    {Function()? onTap,
    double? radiusCirleAvatar,
    required String nameImage,
    required String title}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        CircleAvatar(
          radius: radiusCirleAvatar ?? 20,
          backgroundColor: Colors.transparent,
          child: Image.asset(
            'assets/images/main/${nameImage}.png',

            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
          ),
        ),
        text(
            title: title,
            color: Color1,
            fontSize: 13,
            fontWeight: FontWeight.w400)
      ],
    ),
  );
}

/////////
Widget ListCirclePerson(
    {required String title, Function()? onTap, required int indexImage}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white,
              ),
              Center(
                child: Container(
                  width: 50.0, // قم بتحديد عرض الصورة هنا
                  height: 50.0, // قم بتحديد ارتفاع الصورة هنا
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    'assets/images/main/trainer${indexImage + 1}.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Image.asset(
                          'assets/images/main/7rmlogo.png',
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        text(
            title: title,
            color: Color.fromRGBO(90, 60, 98, 1),
            fontSize: 12,
            fontWeight: FontWeight.w400),

        ////////////////////////////
      ],
    ),
  );
}

Widget ButtonMenu({
  required BuildContext context,
  Function()? onTap,
  Function()? onTapArrow,
  required String data,
  String? image,
}) {
  return Center(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * .90,
        height: 44,
        decoration: BoxDecoration(
          border: Border.all(color: Color1, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .03,
            ),
            image == null
                ? Container(
                    width: 35,
                  )
                : Container(
                    width: 35,
                    child: Image.asset(
                      'assets/images/main/${image.toString()}.png',
                      // fit: BoxFit.cover,
                      width: 35,
                      height: 35,
                    ),
                  ),
            SizedBox(width: 8.0),
            Text(data),
            Spacer(),
            GestureDetector(
              onTap: onTapArrow,
              child: Container(
                width: 35,
                child: Image.asset(
                  'assets/images/main/right-arrow.png',
                  // fit: BoxFit.cover,
                  width: 35,
                  height: 35,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .03,
            ),
          ],
        ),
      ),
    ),
  );
}
