import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Byday_Job_Africa/Signin.dart';
import 'package:Byday_Job_Africa/hompage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var devicewith = MediaQuery.of(context).size.width;
    var deviceheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: deviceheight * 0.08,
            ),
            Container(
              padding: EdgeInsets.only(left: 30),
              child: Image.asset(
                'assets/images/carpenter.png',
                height: deviceheight * 0.2,
                width: devicewith * 0.4,
              ),
            ),
            SizedBox(
              height: deviceheight * 0.06,
            ),
            Container(
                padding: EdgeInsets.only(left: 30),
                child: Text("BYDAY JOB AFRICA",
                    style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.bold))),
            SizedBox(
              height: deviceheight * 0.06,
            ),
            Container(
                padding: EdgeInsets.only(left: 30),
                child: Text("Getting a Job abroad\nJust got easier",
                    style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold))),
            SizedBox(
              height: deviceheight * 0.04,
            ),
            Container(
                padding: EdgeInsets.only(left: 30),
                child: Text("Now you can be heard. Find\na job now",
                    style:
                        GoogleFonts.lato(color: Colors.white, fontSize: 16))),
            SizedBox(
              height: deviceheight * 0.07,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      // padding: MaterialStateProperty.all(EdgeInsets.only(left: 30)),
                      fixedSize: MaterialStateProperty.all(Size(300, 50)),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {

                    var box = Hive.box('bydayjobafrica');
                    box.put("firstrun", 1);
                    

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Homepage()));
                  },
                  child: Text(
                    "Get Started",
                    style: GoogleFonts.lato(color: Color(0xFFc07f00)),
                  )),
            )
          ],
        ),
      )),
    );
  }
}
