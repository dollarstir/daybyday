import 'package:flutter/material.dart';

class CategoryModel extends StatelessWidget {
  // final String image;
  final String title;
  final String image;

  const CategoryModel({
    // required Key key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var devicewidth = MediaQuery.of(context).size.width;
    var deviceheight = MediaQuery.of(context).size.height;
    return Container(
      height: 60,
      width: devicewidth * 0.5,
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(offset: Offset(0, 0), color: Colors.black26, blurRadius: 5),
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: 40,
          width: 60,
          child:Image.asset(this.image),
          decoration: BoxDecoration(
              color: Color(0xff999999),
              borderRadius: BorderRadius.circular(10)),
        ),
        Container(
          width: 100,
          child: Text(this.title),
        ),
      ]),
    );
  }
}
