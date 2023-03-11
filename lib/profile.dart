import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Byday_Job_Africa/hompage.dart';
import 'package:Byday_Job_Africa/subscribe.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  String title;
  Profile({Key? key, required this.title}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState(title: title);
}

class _ProfileState extends State<Profile> {
  String title;

  openwhatsapp() async {
    var whatsapp = "+233201657469";
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=hello";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
        await launch(whatsappURl_android);
      }
    }
  }


  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
  _ProfileState({required this.title});
  @override
  Widget build(BuildContext context) {
    var devicewith = MediaQuery.of(context).size.width;
    var deviceheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: deviceheight * 0.15,
          ),
          

          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    offset: Offset(0, 0), color: Colors.black26, blurRadius: 5),
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Connect with Us",
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                    
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    "You can reach us via sms ,phone call  or whatsap  by clicking on the preferred option below",
                    style: GoogleFonts.lato(
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 30,
          ),
          
           SizedBox(
            height: deviceheight * 0.08,
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: (){
                 _makePhoneCall('+233201657469');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFFc07f00),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 9,
                      ),
                      Text("Call Now",
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  openwhatsapp();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFFc07f00),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.message,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 9,
                      ),
                      Text("Whatsapp Us",
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
          
          
          
          
        ],
      )),
    );
  }
}
