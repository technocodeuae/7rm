import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sevin_rm/UI/Screens/Auctions/auctions.dart';
import 'package:sevin_rm/UI/Screens/FilterHorses/filterHorse.dart';
import 'package:sevin_rm/UI/Screens/component/Widght.dart';
import 'package:sevin_rm/UI/Screens/profile/Profile3.dart';

//
import 'Booking_H.dart';
import 'Screens/favorite/favoriteScreen.dart';
import 'Screens/soprtScreen.dart';
import 'util/app_them.dart';

//
class MainScreen2 extends StatefulWidget {
  const MainScreen2({Key? key}) : super(key: key);
////
  @override
  State<MainScreen2> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen2> {
  int _page = 0;
  // Profile2
  List category = [
    {
      "image": "assets/images/img_10.png",
      "text": "Ability &",
    },
    {"image": "assets/images/img_11.png", "text": "Flat race"},
    {"image": "assets/images/img_12.png", "text": "Show horse"},
    {"image": "assets/images/img_13.png", "text": "Pony"},
    {
      "image": "assets/images/img_14.png",
      "text": "Race",
    },
  ];
  int selected_page = 0;
  int selected_page1 = 1;

  bool about = true;
  bool chat = true;
  int id = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          'assets/images/img.png',
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          //
          backgroundColor: Colors.transparent,
          body: selected_page == 0
              ? selected_page1 != 1
                  ? Auctions()
                  : filterScreen(
                      auctionId: 1,
                    )
              : selected_page == 1
                  ? FavoriteScreen()
                  : selected_page == 2
                      ? SportScreen()
                      : selected_page == 3
                          ? MyHomePage()
                          : selected_page == 4
                              ? Profile2()
                              : Container(),
          drawer: Drawer(),
          bottomNavigationBar: CurvedNavigationBar(
            index: 2,
            height: 75.0,
            items: <Widget>[
              Column(
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.home_outlined,
                      size: 30,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        selected_page = 0;
                        selected_page1 = 0;
                        about = true;
                      });
                    },
                  ),
                  text(
                      title: "Home",
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.white)
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.star_border,
                      size: 30,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        selected_page = 1;
                      });
                    },
                  ),
                  text(
                      title: "Favorite",
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.white)
                ],
              ),
              GestureDetector(
                onTap: () {
                  print("llllllll");
                  setState(() {
                    selected_page = 2;

                    chat = false;
                  });
                },
                child: Column(
                  children: [
                    selected_page == 2
                        ? Icon(Icons.close)
                        : Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/img_9.png'))),
                            // child: Image.asset(
                            //   'assets/images/img_9.png',
                            //   color: Colors.black,
                            //   height: 35,
                            //   width: 35,
                            // ),
                          ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selected_page = 3;
                  });
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 18,
                    ),
                    Image.asset(
                      'assets/images/img_6.png',
                      height: 25,
                      width: 25,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    text(
                        title: "My Booking",
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("objectLLLL");
                  setState(() {
                    selected_page = 4;
                  });
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 18,
                    ),
                    Image.asset(
                      'assets/images/img_7.png',
                      height: 25,
                      width: 25,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    text(
                        title: "Profile",
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)
                  ],
                ),
              ),
            ],
            color: navBarColor,
            buttonBackgroundColor: secondaryColor,
            backgroundColor: Colors.transparent.withOpacity(0.0),
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                _page = index;
                print("LLLLLLLLLLLLLLLLLLLLLL");
                print(index);
              });
            },
            letIndexChange: (index) => false,
          ),
        )
      ]),
    );
  }
}
