import 'package:flutter/material.dart';
import 'package:sevin_rm/UI/Screens/component/Widght.dart';


import 'chat.dart';

class Conversation {
  final String name;
  final String message;
  final String image;
  final int unreadMessages;
  final DateTime messageTime; // حقل لتخزين وقت إرسال الرسالة

  Conversation({
    required this.name,
    required this.message,
    required this.image,
    required this.unreadMessages,
    required this.messageTime,
  });
}

class ChatListScreen extends StatelessWidget {
  final List<Conversation> conversations = [
    Conversation(
      name: 'Dino Waelchi',
      message: 'Can I book Jumping Package offer?',
      image: 'assets/images/main/image 99.png',
      unreadMessages: 0,
      messageTime:
          DateTime(2023, 10, 19, 10, 30), // تعيين وقت إرسال الرسالة هنا
    ),
    Conversation(
      name: 'Daniel William',
      message: 'Hey!',
      image: 'assets/images/main/image 98.png',
      unreadMessages: 3,
      messageTime:
          DateTime(2023, 10, 18, 14, 45), // تعيين وقت إرسال الرسالة هنا
    ),
    Conversation(
      name: 'Victor Black',
      message: 'Which kind of package & offers provide?',
      image: 'assets/images/main/image 97.png',
      unreadMessages: 2,
      messageTime:
          DateTime(2023, 10, 18, 14, 45), // تعيين وقت إرسال الرسالة هنا
    ),

    // Add more conversations as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
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
            leading: Container(),
            title: Center(
              child: text(
                  title: "Messages",
                  color: Color.fromRGBO(90, 0, 114, 1),
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: Color.fromRGBO(90, 0, 114, 0.87),
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Divider(
                  color: Color.fromRGBO(138, 134, 139, 0.8),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.86,
                  child: ListView.separated(
                    itemCount: conversations.length,
                    separatorBuilder: (BuildContext, int) => Divider(
                      color: Color.fromRGBO(138, 134, 139, 0.8),
                    ),
                    itemBuilder: (context, index) {
                      final conversation = conversations[index];
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(conversation.image),
                        ),
                        title: Text(
                          conversation.name,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.87),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        subtitle: Text(
                          conversation.message,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                        trailing: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: conversation.unreadMessages.toInt() == 0
                              ? Container()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text(
                                    //   conversation.message,
                                    //   style: TextStyle(
                                    //       color: Color.fromRGBO(0, 0, 0, 0.5),
                                    //       fontSize: 13,
                                    //       fontWeight: FontWeight.w400),
                                    // ),
                                    Column(
                                      children: [
                                        Text(
                                          '${conversation.messageTime.hour}:${conversation.messageTime.minute.toString().padLeft(2, '0')}', // عرض الوقت المحدد لكل رسالة
                                          style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.4),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(6.0),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromRGBO(
                                                190, 140, 206, 0.5),
                                          ),
                                          child: Text(
                                            '${conversation.unreadMessages}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => ChatScreen(),
                            ),
                          ); // Navigate to chat screen for selected conversation
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
