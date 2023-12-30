import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sevin_rm/UI/Screens/conset/Const.dart';
import 'package:sevin_rm/data/models/stables/stables_model.dart';

import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../util/app_them.dart';
import '../HomeScreen/Home.dart';
import '../booking/selectingBooking.dart';
import '../login/login.dart';

//
class AllStaplesPage extends StatefulWidget {
  StablesModel? dataStablesModel;
  AllStaplesPage({super.key, required this.dataStablesModel});

  @override
  State<AllStaplesPage> createState() => _AllStaplesPageState();
}

class _AllStaplesPageState extends State<AllStaplesPage> {


  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 900000.0);
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("All Stables",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: primaryColor,
            )),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/img.png',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          if (widget.dataStablesModel == null) ...[
            Center(
              child: CircularProgressIndicator(
                color: Color1,
              ),
            ),
          ] else ...[
            if (widget.dataStablesModel?.data.length != 0) ...[
              ListView.builder(
                scrollDirection: Axis.vertical,
                controller: _scrollController,
                reverse: widget.dataStablesModel!.data.length < 4
                    ? false
                    : true,
                itemBuilder: (_, index) {
                  // StablesRemoteDataSourceImpl stablesRemoteDataSourceImpl =  StablesRemoteDataSourceImpl();
                  // print(widget.dataStablesModel?.stables![index].evaluations![0].averageEvaluation);
                  return InkWell(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => Home(
                            stableId:
                                widget.dataStablesModel!.data![index].id ??
                                    0,
                          ),
                        ),
                      );
                      // stablesRemoteDataSourceImpl.getIndexStables();
                      // AppCubitMainPage.get(context).geAllStables();
                      // AppCubitMainPage.get(context).getAllCategories();
                    },
                    child: Container(
                      width: 240,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.sp),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0x80BE8FFF),
                                blurRadius: 5,
                                offset: Offset(3, 5))
                          ]),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 400.sp,
                              height: 150.sp,
                              decoration: BoxDecoration(
                                color: Colors.black,
//                                //dataBestStables!.data!
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.network(
                                widget.dataStablesModel!.data![index]
                                        .profileImage ??
                                    'assets/images/main/7rmlogo.png',
                                fit: BoxFit.fill,
                                errorBuilder: (BuildContext context,
                                    Object error, StackTrace? stackTrace) {
                                  // If an error occurs while loading the image, show the fallback image
                                  return Image.asset(
                                      'assets/images/main/7rmlogo.png',
                                   );
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.dataStablesModel!.data![index]
                                            .name ??
                                        '',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  TextButton.icon(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.star_rate,
                                        color: Colors.amber,
                                      ),
                                      label: widget
                                              .dataStablesModel!
                                              .data![index]
                                              .evaluations
                                              .isNotEmpty
                                          ? Text(
                                              widget
                                                      .dataStablesModel
                                                      ?.data![index]
                                                      .evaluations![0]
                                                      .averageEvaluation ??
                                                  '',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          : Text(
                                              '0',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ))
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 280.w,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      widget.dataStablesModel!.data![index]
                                              .description ??
                                          '',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: (() {
                                    if (DIManager.findDep<SharedPrefs>()
                                            .getToken() !=
                                        null) {
                                      Navigator.push<void>(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              BookingScreen(
                                            stableId: widget.dataStablesModel!
                                                    .data![index].id ??
                                                0,
                                          ),
                                        ),
                                      );
                                    } else {
                                      Navigator.push<void>(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              LoginW(),
                                        ),
                                      );
                                    }
                                  }),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            topLeft: Radius.circular(10))),
                                    child: Text("Book",
                                        style: TextStyle(
                                          fontSize: 14,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: widget.dataStablesModel?.data.length,
              ),
            ] else ...[
              Center(
                child: Container(
                  child: Text(
                    'No Result',
                    style: TextStyle(fontSize: 17.sp),
                  ),
                ),
              )
            ],
          ],
        ],
      ),
    );
  }
}
