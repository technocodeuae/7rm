import 'package:flutter/material.dart';
import 'package:sevin_rm/UI/Screens/conset/Const.dart';

class SportScreen extends StatefulWidget {
  const SportScreen({Key? key}) : super(key: key);

  @override
  State<SportScreen> createState() => _SportScreenState();
}

class _SportScreenState extends State<SportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          'assets/images/img.png',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            // toolbarHeight: 80,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: const Text(
              'Supports',
              style: TextStyle(
                color: Color(0xFF5A0072),
                fontSize: 22,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  color: Color1,
                ),
                Center(
                  child: Container(
                    width: 270,
                    height: 273,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/img_18.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          hintText: " Email",
                          alignLabelWithHint: false,
                          filled: true),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                    )),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintText: "Phone number",
                      alignLabelWithHint: false,
                      filled: true,
                    ),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: const Text(
                      'Write a message',
                      style: TextStyle(
                        color: Color(0xFF5A0072),
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Container(
                    margin: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          // labelText: "Ticket Form",

                          hintText:
                              'Please, can you help me??\nI have a problem to login into my account....',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            // height: 0,
                          ),
                          fillColor: Colors.white,
                          alignLabelWithHint: false,
                          filled: true),
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      textInputAction: TextInputAction.done,
                    )),
                Center(
                  child: Container(
                    width: 311,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(311, 44),
                          elevation: 1,
                          primary: Color1,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ))),
                      onPressed: () {},
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'Send ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
          // bottomNavigationBar: CurvedNavigationBar(
          //   index: 2,
          //   height: 75.0,
          //   items: <Widget>[
          //     const Icon(
          //       Icons.home_outlined,
          //       size: 30,
          //       color: Colors.grey,
          //     ),
          //     const Icon(
          //       Icons.location_on_outlined,
          //       size: 30,
          //       color: Colors.grey,
          //     ),
          //     const Icon(Icons.chat_rounded, size: 30, color: Colors.black),
          //     Image.asset(
          //       'assets/images/img_6.png',
          //       height: 25,
          //       width: 25,
          //     ),**
          //     Image.asset(
          //       'assets/images/img_7.png',
          //       height: 25,
          //       width: 25,
          //     ),
          //   ],
          //   color: navBarColor,
          //   buttonBackgroundColor: secondaryColor,
          //   backgroundColor: Colors.white,
          //   animationCurve: Curves.easeInOut,
          //   animationDuration: const Duration(milliseconds: 600),
          //   onTap: (index) {
          //     setState(() {
          //       //  _page = index;
          //       print(index);
          //     });
          //   },
          //   letIndexChange: (index) => false,
          // ),
        )
      ]),
    );
  }
}
