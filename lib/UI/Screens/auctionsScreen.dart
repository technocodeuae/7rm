import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../util/app_them.dart';

class AuctiosScreen extends StatefulWidget {
  const AuctiosScreen({Key? key}) : super(key: key);

  @override
  State<AuctiosScreen> createState() => _AuctiosScreenState();
}

class _AuctiosScreenState extends State<AuctiosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.dehaze_rounded,
                  color: Color(0xFF5A0072),
                ))),
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 1,
        title: const Text(
          'Auctions',
          style: TextStyle(
            color: Color(0xFF5A0072),
            fontSize: 22,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [],
        ),
      ),
      //
      drawerScrimColor: Colors.cyan,
      drawer: const Drawer(),
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
        height: 75.0,
        items: <Widget>[
          const Icon(
            Icons.home_outlined,
            size: 30,
            color: Colors.grey,
          ),
          const Icon(
            Icons.location_on_outlined,
            size: 30,
            color: Colors.grey,
          ),
          const Icon(Icons.chat_rounded, size: 30, color: Colors.black),
          Image.asset(
            'assets/images/img_6.png',
            height: 25,
            width: 25,
          ),
          Image.asset(
            'assets/images/img_7.png',
            height: 25,
            width: 25,
          ),
        ],
        color: navBarColor,
        buttonBackgroundColor: secondaryColor,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            //  _page = index;
            print(index);
          });
        },
        letIndexChange: (index) => false,
      ),
    );
  }
}
