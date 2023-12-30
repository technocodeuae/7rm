import 'package:flutter/material.dart';


import '../component/Widght.dart';
import '../conset/Const.dart';
import '../onbording/onbording.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _OnbordingState();
}

class _OnbordingState extends State<SplashScreen> {
  void initState() {
    super.initState();
    // استدعاء دالة لتأخير الانتقال إلى الواجهة الأخرى بعد فترة زمنية
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Onbording()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          'assets/images/main/image 16.jpg',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: 150,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: [
                          LinearGradientColor1,
                          LinearGradientColor2,
                          LinearGradientColor3
                        ]),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Transform.rotate(
                  angle: 55 * 0.0174533, // زاوية الميل بالراديان (45 درجة)
                  child: Column(
                    children: [
                      Container(
                        width: 50, // تحديد طول الخط
                        height: 3,
                        color: ColorLine2,
                        margin: EdgeInsets.only(right: 5), // تقريب الخط الأول
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 60, // تحديد طول الخط
                        height: 4,
                        color: ColorLine1,
                        margin: EdgeInsets.only(right: 5), // تقريب الخط الأول
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: Column(
                    children: [
                      text(
                          title: "7RM",
                          color: Color1,
                          fontSize: 31,
                          fontWeight: FontWeight.w700),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          text(
                              title: "HORSE AUCTIONS AND BOOKING",
                              color: Color2,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                          Spacer()
                        ],
                      ),
                    ],
                  ),
                ),
                Transform.rotate(
                  angle: 55 * 0.0174533, // زاوية الميل بالراديان (45 درجة)
                  child: Column(
                    children: [
                      Container(
                        width: 50, // تحديد طول الخط
                        height: 3,
                        color: ColorLine2,
                        margin: EdgeInsets.only(right: 5), // تقريب الخط الأول
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 60, // تحديد طول الخط
                        height: 4,
                        color: Color.fromRGBO(90, 0, 114, 1),
                        margin: EdgeInsets.only(right: 5), // تقريب الخط الأول
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            text(
                title: "@ Melenuim 2023. All rights reserved.",
                color: Color2,
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ]),
        )
      ]),
    );
  }
}
