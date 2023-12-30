import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../component/Widght.dart';

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({super.key});

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Color.fromRGBO(90, 0, 114, 1),
          size: 35,
        ),
      ),
      title: Center(
        child: text(
            title: "Payment History",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color.fromRGBO(35, 0, 44, 1)),
      ),
      actions: [
        Container(
          width: 50.sp,
        )
        // IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Icons.bookmark_add_outlined,
        //       color: Color.fromRGBO(90, 0, 114, 1),
        //       size: 35,
        //     ))
      ],
    ),
    );
  }
}
