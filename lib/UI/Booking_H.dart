import 'package:flutter/material.dart';
import 'package:sevin_rm/UI/Screens/conset/Const.dart';
import 'package:table_calendar/table_calendar.dart';

import 'Homeee.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // CalendarController _calendarController = CalendarController();

  @override
  void initState() {
    super.initState();
    // _calendarController = CalendarController();
  }

  @override
  void dispose() {
    // _calendarController.dispose();
    super.dispose();
  }

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
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                'Auctions Calendar',
                style: TextStyle(
                    color: Color1, fontSize: 22, fontWeight: FontWeight.w700),
              ),
              leading: Container(),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Divider(
                    color: Color1,
                  ),
                  TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.950,
                    height: MediaQuery.of(context).size.height * 0.32,
                    child: ListView.builder(
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            // width: 20,
                            width: MediaQuery.of(context).size.width * 0.90,

                            height: 85,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(children: [
                              Text(
                                "“End of Season Auction 2024”",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.80,
                                height: 20,
                                child: Row(
                                  children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.66),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push<void>(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  MainScreen2(),
                                            ),
                                          );
                                          print("object");
                                        },
                                        icon: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Colors.black,
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 20,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.60,
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: Text(
                                          "29 October 2024",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        );
                      }),
                      itemCount: 5,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            )),
      ]),
    );
  }
}
