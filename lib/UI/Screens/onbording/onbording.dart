import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sevin_rm/UI/Screens/conset/Const.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../component/Widght.dart';
import '../login/login.dart';

class Onbording extends StatefulWidget {
  Onbording({Key? key})
      : super(
          key: key,
        );
//
  @override
  State<Onbording> createState() => _W1State();
}

class _W1State extends State<Onbording> {
  int currentindex = 0;
  final GetStorage _prefs = GetStorage();
  final controller = PageController();
  final controller1 = PageController();
  bool _showOnboarding = true;
  int currentPage = 0;
  int currentPage1 = 0;
  bool isbutton = false;
  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  bool yourCheckForTokenFunction() {
    if (DIManager.findDep<SharedPrefs>().getToken != null) {
      return true;
    }
    return false;
  }

  Future<void> _loadPreferences() async {
    await _prefs.writeIfNull('showOnboarding', true);
    setState(() {
      _showOnboarding = _prefs.read('showOnboarding');
    });
  }

  Future<void> _disableOnboarding() async {
    await _prefs.write('showOnboarding', false);
    setState(() {
      _showOnboarding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          'assets/images/background.png',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.48,
              child: PageView(
                controller: controller,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                    //  currentPage = page;
                    isbutton = currentPage == 2;
                  });
                },
                children: [
                  Column(
                    children: [
                      Container(
                        child: Image.asset(
                          pages[0].nameimage.toString(),
                          width: 480,
                          height: 300,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        child: Image.asset(
                          pages[1].nameimage.toString(),
                          width: 480,
                          height: 300,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        child: Image.asset(
                          pages[2].nameimage.toString(),
                          width: 480,
                          height: 300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotWidth: 12,
                    dotHeight: 10,
                    dotColor: Color4,
                    activeDotColor: Color1,
                  ), // يمكنك استخدام أي تأثير تفضيلي هنا
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.28,
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: controller1,
                onPageChanged: (index) {
                  setState(() {
                    currentPage1 = index;
                    isbutton = currentPage1 == 2;
                  });
                },
                children: [
                  Column(
                    children: [
                      Container(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            text(
                              title: "Find and Book Services",
                              color: Color1,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),

                            SizedBox(
                              height: 6,
                            ),
                            text(
                              title: "Find, book, auctions and horses.",
                              color: Color2,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            // Text(
                            //   "Find, book, auctions and horses.",
                            //   style: TextStyle(
                            //       fontSize: 15,
                            //       fontWeight: FontWeight.w400,
                            //       color: Color.fromRGBO(0, 0, 0, 1)),
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            text(
                              title: "Actions that fit you",
                              color: Color1,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Container(
                              width: 280,
                              child: text(
                                title:
                                    "Choose our Training sessions and auctions offer price Package that fit you.",
                                color: Color2,
                                textAlign: TextAlign.center,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            text(
                              title: "Actions that fit you",
                              color: Color1,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            text(
                              title:
                                  "Book an appointment for Training sessions.",
                              color: Color2,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            isbutton
                ? ButtonStaic(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => LoginW(),
                        ),
                      );
                      // يتم تنفيذ هذا الكود عند النقر على الزر
                      print('تم النقر على الزر!' +
                          currentPage.toString() +
                          currentPage1.toString());

                      DIManager.findDep<SharedPrefs>().setIsFirst(false);
                    },
                    widthContainer: MediaQuery.of(context).size.width * 0.80,
                    heightContainer: 50.0,
                    radius: 25.0,
                    colors: [Color1, Color1],
                    beginGrident: Alignment.topLeft,
                    endGrident: Alignment.bottomRight,
                    title: "Get Started",
                    boxShadow: [
                      BoxShadow(
                        color: Color1.withOpacity(0.5),
                        spreadRadius: 2.0,
                        blurRadius: 10.0,
                        offset: Offset(-1, 6),
                      ),
                    ],
                    colorText: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  )
                : ButtonStaic(
                    onTap: () {
                      if (currentPage < 2 && currentPage1 < 2) {
                        controller.animateToPage(
                          currentPage + 1,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        controller1.animateToPage(
                          currentPage1 + 1,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        controller.animateToPage(
                          0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        controller1.animateToPage(
                          0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        DIManager.findDep<SharedPrefs>().setIsFirst(false);
                      }
                      // يتم تنفيذ هذا الكود عند النقر على الزر
                      print('تم النقر على الزر!');
                    },
                    widthContainer: MediaQuery.of(context).size.width * 0.80,
                    heightContainer: 50.0,
                    radius: 25.0,
                    colors: [Color1, Color1],
                    beginGrident: Alignment.topLeft,
                    endGrident: Alignment.bottomRight,
                    title: "Next",
                    boxShadow: [
                      BoxShadow(
                        color: Color1.withOpacity(0.5),
                        spreadRadius: 2.0,
                        blurRadius: 10.0,
                        offset: Offset(-1, 6),
                      ),
                    ],
                    colorText: Color3,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
            SizedBox(
              height: 10,
            ),
            isbutton
                ? Container()
                : ElevatedButton(
                    style: ButtonStyle(
                      // تغيير عرض الزر
                      minimumSize: MaterialStateProperty.all(Size(100, 50)),
                      // تغيير لون الزر
                      backgroundColor: MaterialStateProperty.all(Color3),
                      // تغيير تأثير الظل
                      elevation: MaterialStateProperty.all(10),
                      // تحكم بحواف الزر
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: Color3),
                        ),
                      ),
                    ),
                    onPressed: () {
                      DIManager.findDep<SharedPrefs>().setIsFirst(false);

                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) => LoginW()),
                      );
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
          ]),
        )
      ]),
    );
  }
}
