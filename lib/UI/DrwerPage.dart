import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sevin_rm/UI/Screens/component/Widght.dart';
import 'package:sevin_rm/UI/Screens/conset/Const.dart';
import 'package:sevin_rm/UI/Screens/main_screen/main_screen.dart';

//
import 'Screens/Auctions/auctions.dart';

class DrwerPage extends StatelessWidget {
  const DrwerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          'assets/images/main/image 16.jpg',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            //   leading: Icon(
            //     Icons.arrow_back,
            //     color: Color1,
            //     size: 25,
            //   ),
          ),
          body: Column(children: [
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
                        margin:
                            const EdgeInsets.only(right: 5), // تقريب الخط الأول
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 60, // تحديد طول الخط
                        height: 4,
                        color: ColorLine1,
                        // margin: EdgeInsets.only(right: 5), // تقريب الخط الأول
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Column(
                    children: [
                      text(
                          title: "CHOOSE YOUR SERVICE",
                          color: Color1,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                      const SizedBox(
                        height: 10,
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
                        margin:
                            const EdgeInsets.only(right: 5), // تقريب الخط الأول
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 60, // تحديد طول الخط
                        height: 4,
                        color: const Color.fromRGBO(90, 0, 114, 1),
                        margin:
                            const EdgeInsets.only(right: 5), // تقريب الخط الأول
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 52.50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => MainScreen(),
                  ),
                );
              },
              child: Container(
                width: 118.sp,
                height: 118.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color1,
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Appointment Horse",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(
              height: 28.sp,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const Auctions(),
                  ),
                );
              },
              child: Container(
                width: 118.sp,
                height: 118.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color1,
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Auction",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            // GestureDetector(
            //   onTap: () {},
            //   child: Container(
            //     width: 118,
            //     height: 118,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(15),
            //       color: Color1,
            //     ),
            //     alignment: Alignment.center,
            //     child: Text(
            //       "Appointment Salon ",
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 18,
            //           fontWeight: FontWeight.w700),
            //     ),
            //   ),
            // ),

            const Spacer(),
            text(
                title: "@ 7RM 2023. All rights reserved.",
                color: Color2,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ]),
        )
      ],
    ));
  }
}
