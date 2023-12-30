import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sevin_rm/data/models/stables/stables_information.dart';

class Screen3 extends StatefulWidget {
  const Screen3({Key? key, this.stableInfoModel}) : super(key: key);
  final StableInformationModel? stableInfoModel;

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 0.42,
        child: SingleChildScrollView(
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(), // يمنع التمرير العمودي

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // عدد الأعمدة في الشبكة
            ),
            itemCount: widget.stableInfoModel!.stableImages.length,
            itemBuilder: (BuildContext context, int index) {
              // return Image.asset(
              //   widget.stableInfoModel!.stableImages[index].toString(),
              //   width: 172,
              //   height: 172,
              // );

              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                  ),
                  child: Image.network(
                    widget.stableInfoModel!.stableImages[index].image.toString() ,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return Image.asset('assets/images/main/7rmlogo.png',
                          );
                    },
                    //////
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
//////
