import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

//
class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/img.png"), fit: BoxFit.fill),
          // borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            AppBar(
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFF5A0072),
                ),
              ),
              centerTitle: true,
              toolbarHeight: 80,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'Horses',
                style: TextStyle(
                  color: Color(0xFF5A0072),
                  fontSize: 22,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Divider(
              thickness: 2.0,
              color: Colors.black,
            ),
            const SizedBox(
              width: double.infinity,
              height: 250.0,
            )
          ],
        ),
      ),
    );
  }
}
