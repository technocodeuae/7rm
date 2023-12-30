import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sevin_rm/UI/Screens/component/Widght.dart';


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> messages = [
    Message(
        sender: 'User', text: 'Hello', time: DateTime.now(), isDelivered: true),
    Message(
        sender: 'Friend',
        text: 'Hi there!',
        time: DateTime.now(),
        isDelivered: false),
  ];
  File? imageFile;
  final picker = ImagePicker();
  TextEditingController _textEditingController = TextEditingController();
  String? pickedFile; // تحديد المتغير العالمي

  void _sendMessage() {
    if (_textEditingController.text.isEmpty && imageFile == null) return;

    setState(() {
      messages.add(
        Message(
          sender: 'User',
          text: _textEditingController.text,
          time: DateTime.now(),
          imageFile: imageFile,
          isDelivered: true,
        ),
      );
      _textEditingController.clear();
      imageFile = null;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageFile = File(pickedFile!.path);
    });
  }

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
              icon:
                  Icon(Icons.arrow_back, color: Color.fromRGBO(90, 0, 114, 1)),
            ),
            title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              CircleAvatar(
                radius: 8,
                backgroundColor: Colors.green,
              ),
              SizedBox(
                width: 10,
              ),
              text(
                  title: "Ben Jhonson",
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(90, 0, 114, 1))
            ]),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.menu,
                    color: Color.fromRGBO(90, 0, 114, 0.87),
                  ))
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    Message message = messages[index];
                    bool isUser = message.sender == 'User';

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: isUser
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          isUser
                              ? Container()
                              : CircleAvatar(
                                  backgroundImage: AssetImage(
                                      "assets/images/main/image 97.png"),
                                ),
                          Container(
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: isUser
                                  ? Color.fromRGBO(190, 140, 206, 0.55)
                                  : Color.fromRGBO(50, 52, 70, 0.85),
                              borderRadius: isUser
                                  ? BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))
                                  : BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                            ),
                            child: Column(
                              crossAxisAlignment: isUser
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                message.imageFile != null
                                    ? Container(
                                        width: 200,
                                        height: 200,
                                        child: Image.file(
                                          File(message.imageFile!
                                              .path), // تمرير مسار الصورة المحددة هنا
                                          fit: BoxFit
                                              .cover, // اختيار تناسب الصورة في العرض
                                        ),
                                      )
                                    : Text(
                                        message.text,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: isUser
                                              ? Color.fromRGBO(33, 35, 39, 1)
                                              : Color.fromRGBO(
                                                  255, 255, 255, 0.87),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                SizedBox(height: 4.0),
                                Row(
                                  mainAxisAlignment: isUser
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${message.time.hour}:${message.time.minute}',
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.grey),
                                    ),
                                    SizedBox(width: 4.0),
                                    if (isUser)
                                      Icon(
                                        message.isDelivered
                                            ? Icons.done_all
                                            : Icons.done,
                                        size: 16.0,
                                        color: Colors.grey,
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                color: Color.fromRGBO(50, 52, 70, 1),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.attach_file,
                          color: Color.fromRGBO(255, 255, 255, 0.5),
                        ),
                        onPressed: () {
                          _pickImage();
                        }

                        // onPressed: () async {
                        //   FilePickerResult? result =
                        //       await FilePicker.platform.pickFiles();
                        //   if (result != null) {
                        //     // قم بمعالجة الملف المحدد هنا
                        //     // يمكنك الحصول على مسار الملف باستخدام result.files.single.path
                        //     print(result.files.single.path.toString());
                        //     pickedFile = result.files.single.path.toString();
                        //     setState(() {
                        //       // إعادة بناء الواجهة لعرض الصورة المحددة
                        //     });
                        //   } // إضافة الكود الخاص بإرسال الملفات
                        // },
                        ),
                    // IconButton(
                    //   icon: Icon(
                    //     Icons.attach_file,
                    //     color: Color.fromRGBO(255, 255, 255, 0.5),
                    //   ),
                    //   onPressed: () async {
                    //     final picker = ImagePicker();
                    //     pickedFile =
                    //         await picker.getImage(source: ImageSource.gallery);
                    //     if (pickedFile != null) {
                    //       setState(() {
                    //         // إعادة بناء الواجهة لعرض الصورة المحددة
                    //       });
                    //     }
                    //   },
                    // ),
                    IconButton(
                      icon: Icon(
                        Icons.emoji_emotions,
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                      ),
                      onPressed: () {
                        // إضافة الكود الخاص بإظهار رموز التعبيرية (الإيموجي)
                      },
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(33, 35, 39, 1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            controller: _textEditingController,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintText: '   Write a comment…',
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
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Color.fromRGBO(225, 204, 232, 1),
                      ),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}

class Message {
  final String sender;
  final String text;
  final File? imageFile;

  final DateTime time;
  final bool isDelivered;

  Message({
    required this.sender,
    required this.text,
    required this.time,
    this.imageFile,
    this.isDelivered = false,
  });
}
