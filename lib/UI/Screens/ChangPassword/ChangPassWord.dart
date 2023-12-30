import 'package:flutter/material.dart';

import '../component/Widght.dart';
import '../conset/Const.dart';

class ChangPassword extends StatelessWidget {
  ChangPassword({Key? key}) : super(key: key);
  final String flag = '🇦🇪';
  final String callingCode = '+971';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          'assets/images/main/image 12.png',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: [
                              Text(
                                "Change password",
                                style: TextStyle(
                                    color: Color.fromRGBO(35, 0, 44, 1),
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700),
                              ),
                              Spacer()
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color.fromRGBO(90, 0, 114, 1),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(flag,
                                            style: TextStyle(fontSize: 14)),
                                        SizedBox(width: 4.0),
                                        Text(callingCode,
                                            style: TextStyle(fontSize: 14)),
                                      ],
                                    )),
                                SizedBox(width: 16.0),
                                Expanded(
                                  child: TextFieldWidght(
                                      widthC:
                                          MediaQuery.of(context).size.width *
                                              0.90,
                                      heightC:
                                          MediaQuery.of(context).size.height *
                                              0.080,
                                      radius: 15.0,
                                      colorBorder: Color1,
                                      keyboardType: TextInputType.phone,
                                      colorhint: Color5,
                                      widthBorder: 1,
                                      hintText: "0503140232"),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.150,
                          ),
                          GestureDetector(
                            onTap: () {
                              // يتم تنفيذ هذا الكود عند النقر على الزر
                              print('تم النقر على الزر!');
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.90,
                              height: 60.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(90, 0, 114, 1),
                                    Color.fromRGBO(90, 0, 114, 1)
                                    // const Color(0xFFFF80AB), // زهري فاتح
                                    // const Color(0xFFFF4081), // زهري غامق
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(90, 0, 114, 1)
                                        .withOpacity(0.5),
                                    spreadRadius: 2.0,
                                    blurRadius: 10.0,
                                    offset: Offset(-1, 6),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "Send Verification Code",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
