import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Byday_Job_Africa/hompage.dart';
import 'package:Byday_Job_Africa/subscribe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart';

class Apply extends StatefulWidget {
  String title;
  String pic;
  Apply({Key? key, required this.title, required this.pic}) : super(key: key);

  @override
  State<Apply> createState() => _ApplyState(title: title, pic: pic);
}

class _ApplyState extends State<Apply> {
  String title;
  String pic;
  bool _visible = true;
  var _image;


 String uploadEndPoint ='http://192.168.50.145/daybyday/upload.php';
  String? base64Image;
  File? tmpFile;
  String status = '';
  String errMessage = 'Error Uploading Image';
  var _name = TextEditingController();
  var _phone = TextEditingController();
  var _location = TextEditingController();
  var _age = TextEditingController();
  var _idcard = TextEditingController();
  

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
      tmpFile = _image;
      base64Image = base64Encode(_image.readAsBytesSync());
    });
  }



  setStatus(String message) {
    setState(() {
      status = message;
    });
  }


  upload(String fileName) {
  http.post(Uri.parse(uploadEndPoint), body: {
    "image": base64Image,
    "picname": fileName,
    "name": _name.text,
    "phone": _phone.text,
    "location": _location.text,
    "age": _age.text,
    "idcard": _idcard.text,
    'job': title,
    

  }).then((result) {
    setStatus(result.statusCode == 200 ? result.body : errMessage);
  }).catchError((error) {
    setStatus(error);
  });
}



startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile!.path.split('/').last;
    upload(fileName);
  }

  _ApplyState({required this.title, required this.pic});
  @override
  Widget build(BuildContext context) {
    var devicewith = MediaQuery.of(context).size.width;
    var deviceheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(children: [
            Positioned(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.1,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Color(0xFFc07f00),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(60),
                  child: Image.asset(
                    pic,
                  ),
                ),
              ),
            ),
            // Positioned(
            //   bottom: 2,
            //   left: 110,
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            //     child: Column(
            //       children: [
            //         Container(
            //           child: Text(
            //             "John Osei Kwame",
            //             style: GoogleFonts.lato(
            //                 color: Colors.white, fontWeight: FontWeight.bold),
            //           ),
            //         ),
            //         Container(
            //           child: Text(title,
            //               style: GoogleFonts.lato(
            //                 color: Colors.white,
            //               )),
            //         ),
            //         Row(
            //           children: [
            //             Container(
            //               child: Text("4.0",
            //                   style: GoogleFonts.lato(
            //                       color: Colors.white, fontSize: 10)),
            //             ),
            //             SizedBox(
            //               width: 5,
            //             ),
            //             Container(
            //               child: Text("God's Love Associates",
            //                   style: GoogleFonts.lato(
            //                       color: Colors.white, fontSize: 10)),
            //             )
            //           ],
            //         )
            //       ],
            //     ),
            //     decoration: BoxDecoration(
            //       color: Colors.black,
            //       boxShadow: <BoxShadow>[
            //         BoxShadow(
            //             offset: Offset(0, 5),
            //             color: Colors.black,
            //             blurRadius: 6),
            //       ],
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //   ),
            // ),
          ]),
          SizedBox(
            height: deviceheight * 0.00001,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     Column(
          //       children: [
          //         Container(
          //           child: Text("Experience",
          //               style: GoogleFonts.lato(
          //                 color: Colors.black,
          //                 fontSize: 15,
          //                 fontWeight: FontWeight.bold,
          //               )),
          //         ),
          //         Container(
          //           child: Text("7yrs+",
          //               style: GoogleFonts.lato(
          //                   color: Colors.red,
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 14)),
          //         ),
          //       ],
          //     ),
          //     SizedBox(
          //       width: 5,
          //     ),
          //     Column(
          //       children: [
          //         Container(
          //           child: Text("Cases Won",
          //               style: GoogleFonts.lato(
          //                 color: Colors.black,
          //                 fontSize: 15,
          //                 fontWeight: FontWeight.bold,
          //               )),
          //         ),
          //         Container(
          //           child: Text("200+",
          //               style: GoogleFonts.lato(
          //                   color: Colors.blue,
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 14)),
          //         ),
          //       ],
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => Subscribe()));
          //       },
          //       child: Container(
          //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //         decoration: BoxDecoration(
          //           color: Color(0xFFc07f00),
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Icon(
          //               Icons.call,
          //               color: Colors.white,
          //             ),
          //             SizedBox(
          //               width: 9,
          //             ),
          //             Text("Book Now",
          //                 style: GoogleFonts.lato(
          //                   color: Colors.white,
          //                   fontSize: 15,
          //                   fontWeight: FontWeight.bold,
          //                 ))
          //           ],
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          // SizedBox(
          //   height: 30,
          // ),
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
                        "${title}",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                    // // SizedBox(
                    // //   width: 20,
                    // // ),
                    // // Container(
                    // //   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    // //   child: Text(
                    // //     "available",
                    // //     style: GoogleFonts.lato(
                    // //       color: Colors.green,
                    // //       fontSize: 11,
                    // //     ),
                    // //   ),
                    //   // height: 20,
                    //   // width: ,
                    //   // width: 2,
                    //   decoration: BoxDecoration(
                    //     color: Color.fromARGB(255, 181, 248, 215),
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    // ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    "Kindly fill the forms below and submit, our team will reach out to you soon . .",
                    style: GoogleFonts.lato(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 5, vertical: 30),
          //   child: Text("Send Message"),
          // ),
          SizedBox(
            height: deviceheight * 0.04,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    offset: Offset(0, 0), color: Colors.black26, blurRadius: 5),
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Center(
              child: TextField(
                controller:_name,
                decoration:
                    InputDecoration(hintText: 'Name', border: InputBorder.none),
              ),
            ),
          ),

          SizedBox(
            height: deviceheight * 0.02,
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    offset: Offset(0, 0), color: Colors.black26, blurRadius: 5),
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Center(
              child: TextField(
                controller:_phone,
                decoration: InputDecoration(
                    hintText: 'Phone Number', border: InputBorder.none),
              ),
            ),
          ),

          SizedBox(
            height: deviceheight * 0.02,
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    offset: Offset(0, 0), color: Colors.black26, blurRadius: 5),
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Center(
              child: TextField(
                controller:_location,
                decoration: InputDecoration(
                    hintText: 'Location', border: InputBorder.none),
              ),
            ),
          ),

          SizedBox(
            height: deviceheight * 0.02,
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    offset: Offset(0, 0), color: Colors.black26, blurRadius: 5),
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Center(
              child: TextField(
                controller:_age,
                decoration:
                    InputDecoration(hintText: 'Age', border: InputBorder.none),
              ),
            ),
          ),

          SizedBox(
            height: deviceheight * 0.02,
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    offset: Offset(0, 0), color: Colors.black26, blurRadius: 5),
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Center(
              child: TextField(
                controller:_idcard,
                decoration: InputDecoration(
                    hintText: 'Ghana Card/Passport Number',
                    border: InputBorder.none),
              ),
            ),
          ),

          SizedBox(
            height: deviceheight * 0.03,
          ),

          GestureDetector(
            onTap: getImage,
            child: Container(
              height: deviceheight * 0.08,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      offset: Offset(0, 0),
                      color: Colors.black26,
                      blurRadius: 5),
                ],
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Center(
                  child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Upload Passport size picture",
                    style: GoogleFonts.lato(color: Colors.black, fontSize: 14),
                  )
                ],
              )),
            ),
          ),

          SizedBox(
            height: deviceheight * 0.02,
          ),

          Visibility(
            visible: _visible,
            child: Container(
              width: devicewith * 0.9,
              height: deviceheight * 0.4,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      offset: Offset(0, 0),
                      color: Colors.black26,
                      blurRadius: 5),
                ],
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Center(
                child: _image == null
                    ? Text('No image selected.')
                    : Image.file(
                        _image,
                        width: devicewith * 0.9,
                        height: deviceheight * 0.4,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),





          // status

          SizedBox(
            height: deviceheight * 0.02,
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    offset: Offset(0, 0), color: Colors.black26, blurRadius: 5),
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Center(
              child: Text(
              status,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
            ),
          ),

          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: ElevatedButton(
                style: ButtonStyle(
                    // padding: MaterialStateProperty.all(EdgeInsets.only(left: 30)),
                    fixedSize: MaterialStateProperty.all(Size(350, 50)),
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFFc07f00))),
                onPressed:startUpload,
                child: Text(
                  "Submit",
                  style: GoogleFonts.lato(color: Colors.white),
                )),
          )
        ],
      )),
    );
  }
}
