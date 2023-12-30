import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../conset/Const.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'About Us',
          style: TextStyle(
              color: Color1, fontSize: 22, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          color: Color1,
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/main/image 12.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Column(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16.sp),
                  margin: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.3),
                    border: Border.all(
                      color: Colors.purple.withOpacity(0.8),
                      width: 0.2,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.sp),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Seven RM proudly offers interactive simulcast online bidding services for quality horse auctions throughout the United Arab Emirates as well as special "online only" horse auction events. From long-standing monthly horse sales to premier catalog sales to specialty-focused sales, we serve ALL disciplines & tastes! We work hand in hand with quality horse auction companies to provide the best online bidding experience available and bring horses from anywhere in the country right to your phone or computer. No more missing out on the horse of your dreams because you just can\'t attend the sale in person that day!',
                        style: TextStyle(
                          fontSize: 14.sp
                        ),
                        maxLines: null,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
