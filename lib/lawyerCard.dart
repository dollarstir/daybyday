import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Byday_Job_Africa/Profile.dart';

class LawyerCard extends StatelessWidget {
  // final String image;
  final String title;
  final String type;
  final String rating;
  final String firm;
  final String location;
  final String image;
  final  Function() tap;

  const LawyerCard({
    // required Key key,
    // required this.image,
    required this.title,
    required this.type,
    required this.rating,
    required this.firm,
    required this.location,
    required this.image,
    required this.tap,
    
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 20, bottom: 5, top: 5),
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                offset: Offset(0, 0), color: Colors.black26, blurRadius: 5),
          ],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              this.image??'assets/images/1.jpg',
              height: 70,
              width: 70,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(child: Text(this.title)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                child: Text(
                  this.type,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
                // height: 20,
                // width: ,
                // width: 2,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 23, 128, 58),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                  child: Text(this.rating,
                      style: GoogleFonts.lato(color: Colors.grey))),
            ],
          ),
          Container(
            height: 5,
            width: 5,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Container(
            height: 40,
            width: 70,
            child: TextButton(onPressed: null, child: Text('Apply', style: GoogleFonts.lato(color: Colors.white),)),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     SizedBox(
          //       height: 10,
          //     ),
          //     Container(
          //         child: Text(this.firm,
          //             style: GoogleFonts.lato(color: Colors.grey))),
          //     Container(
          //         child: Text(this.location,
          //             style: GoogleFonts.lato(color: Colors.grey))),
          //     SizedBox(
          //       height: 10,
          //     ),
          //   ],
          // )
        ]),
      ),
    );
  }
}
