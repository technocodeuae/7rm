import 'package:flutter/material.dart';
import 'package:sevin_rm/UI/Screens/component/Widght.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../../../data/models/stables/stables_information.dart';
import '../../conset/Const.dart';

class Screen4 extends StatefulWidget {
  const Screen4({Key? key, this.stableInfoModel}) : super(key: key);
  final StableInformationModel? stableInfoModel;

  @override
  State<Screen4> createState() => _Screen4State();
}

////////////
class _Screen4State extends State<Screen4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  text(
                      title: "Write your Review",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  Spacer(),
                  Container(
                    // color: Colors.red,
                    width: 120,
                    height: 17,
                    alignment: Alignment.center,
                    child: SmoothStarRating(
                      borderColor: Color.fromRGBO(112, 112, 112, 1),
                      color: Color.fromRGBO(228, 179, 67, 1),
                      rating: rating1,
                      // isReadOnly: false,
                      size: 20,
                      filledIconData: Icons.star,
                      halfFilledIconData: Icons.star_half,
                      defaultIconData: Icons.star_border,
                      starCount: 5,
                      allowHalfRating: true,
                      spacing: 2.0,
                      onRatingChanged: (v1) {
                        setState(() {
                          rating1 = v1;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 29,
                          backgroundColor: Colors.blue,
                        ),
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.white,
                        ),
                        CircleAvatar(
                          radius: 27,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.transparent,
                            child: Image.asset(
                              'assets/images/main/image 88.png',
                              fit: BoxFit.cover,
                              // width: MediaQuery.of(context).size.width,
                              // height: MediaQuery.of(context).size.height,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(190, 140, 206, 0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.50,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                              // controller: _textEditingController,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: '   Leave your experience…',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(142, 142, 147, 1),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.record_voice_over_outlined))
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      print("post");
                    },
                    child: Container(
                      width: 71,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromRGBO(190, 140, 206, 0.5)),
                      child: text(
                          title: "Post",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(33, 35, 39, 1)),
                    ),
                  )
                ],
              ),
              Divider(
                color: Color.fromRGBO(50, 52, 70, 1),
                thickness: 1.0,
              ),
              Row(
                children: [
                  text(
                      title: "All Reviews",
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(90, 0, 114, 0.5)),
                  text(
                      title: "(128)",
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(0, 0, 0, 0.5)),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.45,
                child: ListView.separated(
                  shrinkWrap: false,
                  itemCount: conversations.length,
                  separatorBuilder: (BuildContext, int) => Divider(
                    color: Color.fromRGBO(138, 134, 139, 0.8),
                  ),
                  itemBuilder: (context, index) {
                    final conversation = conversations[index];
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(conversation.image),
                          ),
                          title: Row(
                            children: [
                              Text(
                                conversation.name,
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.87),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              Spacer(),
                              Text(
                                '${conversation.messageTime}', // عرض الوقت المحدد لكل رسالة
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 0.4),
                                ),
                              ),
                            ],
                          ),
                          subtitle: SmoothStarRating(
                            borderColor: Color.fromRGBO(112, 112, 112, 1),
                            color: Color.fromRGBO(228, 179, 67, 1),
                            rating: conversation.unreadMessages,
                            // isReadOnly: false,
                            size: 20,
                            filledIconData: Icons.star,
                            halfFilledIconData: Icons.star_half,
                            defaultIconData: Icons.star_border,
                            starCount: 5,
                            allowHalfRating: true,
                            spacing: 2.0,
                            onRatingChanged: (v) {
                              setState(() {
                                rating = v;
                              });
                            },
                          ),
                          onTap: () {
                            // Navigator.push<void>(
                            //   context,
                            //   MaterialPageRoute<void>(
                            //     builder: (BuildContext context) => ChatScreen(),
                            //   ),
                            // ); // Navigate to chat screen for selected conversation
                          },
                        ),
                        Text(
                          conversation.message,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
