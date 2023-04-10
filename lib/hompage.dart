import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Byday_Job_Africa/apply.dart';
import 'package:Byday_Job_Africa/categoryModel.dart';
import 'package:Byday_Job_Africa/lawyerCard.dart';
import 'package:Byday_Job_Africa/notification.dart';
import 'package:Byday_Job_Africa/profile.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './map.dart';
import 'package:Byday_Job_Africa/search.dart';
import 'package:Byday_Job_Africa/profile.dart';
import 'package:geolocator/geolocator.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int selectedIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void tapme(String title, String pic) {
    print(title);
    // passing data to another page

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Apply(title: title, pic: pic)));
  }

  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      SafeArea(
          child: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   padding: EdgeInsets.all(15),
            //   child: Text("Hello User"),
            // ),
            SizedBox(
              height: 30,
            ),
            
            Container(
              padding: EdgeInsets.only(left: 15, bottom: 15),
              child: Text("Let's help you Work Abroad",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
            // Container(
            //   width: double.infinity,
            //   height: 40,
            //   decoration: BoxDecoration(
            //       color: Color.fromARGB(255, 247, 247, 247), borderRadius: BorderRadius.circular(5)),
            //   child: Center(
            //     child: TextField(
            //       decoration: InputDecoration(
            //           prefixIcon: const Icon(Icons.search),
            //           suffixIcon: IconButton(
            //             icon: const Icon(Icons.clear),
            //             onPressed: () {
            //               /* Clear the search field */
            //             },
            //           ),
            //           hintText: 'Search...',
            //           border: InputBorder.none),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Text("Services",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.only(right: 15),
                  child: Text("See All",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      )),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    // onTap: () {
                    //   tapme("Work Abroad", "assets/images/workabroad.png");
                    // },
                    child: CategoryModel(
                      title: "Work Abroad",
                      image: "assets/images/workabroad.png",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      tapme("Passport", "assets/images/passport.png");
                    },
                    child: CategoryModel(
                      title: "Passport",
                      image: "assets/images/passport.png",
                    ),
                  ),


                  GestureDetector(
                    onTap: () {
                      tapme("Visa", "assets/images/visa.png");
                    },
                    child: CategoryModel(
                      title: "Visa",
                      image: "assets/images/visa.png",
                    ),
                  ),


                  GestureDetector(
                    onTap: () {
                      tapme("Parcel Delivery", "assets/images/parcel.png");
                    },
                    child: CategoryModel(
                      title: "Parcel Delivery",
                      image: "assets/images/parcel.png",
                    ),
                  ),


                  GestureDetector(
                    onTap: () {
                      tapme("Bank Statement", "assets/images/bank.png");
                    },
                    child: CategoryModel(
                      title: "Bank Statement",
                      image: "assets/images/bank.png",
                    ),
                  ),


                  GestureDetector(
                    onTap: () {
                      tapme("Bank Statement", "assets/images/bank.png");
                    },
                    child: CategoryModel(
                      title: "Bank Statement",
                      image: "assets/images/bank.png",
                    ),
                  ),


                  //  GestureDetector(
                  //   onTap: () {
                  //     tapme("Bank Statement", "assets/images/bank.png");
                  //   },
                  //   child: CategoryModel(
                  //     title: "Bank Statement",
                  //     image: "assets/images/bank.png",
                  //   ),
                  // ),


                  GestureDetector(
                    onTap: () {
                      tapme("Birth Cert", "assets/images/birthcert.png");
                    },
                    child: CategoryModel(
                      title: "Birth Cert",
                      image: "assets/images/birthcert.png",
                    ),
                  ),


                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Text("Top Jobs",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.only(right: 15),
                  child: Text("View All",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      )),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            LawyerCard(
              tap: () {
                tapme('Masons', 'assets/images/mason3.png');
              },
              title: "Masons",
              image: "assets/images/mason3.png",
              type: "available",
              rating: "4.5",
              firm: "Peneal Legal Consult",
              location: "Amasaman",
            ),
            LawyerCard(
              tap: () {
                tapme('Carpenters', 'assets/images/carpenter.png');
              },
              title: "Carpenters",
              image: "assets/images/carpenter.png",
              type: "available",
              rating: "4.5",
              firm: "Peneal Legal Consult",
              location: "Amasaman",
            ),
            LawyerCard(
              tap: () {
                tapme('Welders', 'assets/images/welders.png');
              },
              title: "Welders",
              image: "assets/images/welders.png",
              type: "available",
              rating: "4.5",
              firm: "Peneal Legal Consult",
              location: "Amasaman",
            ),
            LawyerCard(
              tap: () {
                tapme('Plumbers', 'assets/images/plumber.png');
              },
              title: "Plumbers",
              image: "assets/images/plumber.png",
              type: "available",
              rating: "4.5",
              firm: "Peneal Legal Consult",
              location: "Amasaman",
            ),
            LawyerCard(
              tap: () {
                tapme('House Helps', 'assets/images/househelp.png');
              },
              title: "House Helps",
              image: "assets/images/househelp.png",
              type: "available",
              rating: "4.5",
              firm: "Peneal Legal Consult",
              location: "Amasaman",
            ),
            LawyerCard(
              tap: () {
                tapme('Cleaners', 'assets/images/clean.png');
              },
              title: "Cleaners ",
              image: "assets/images/clean.png",
              type: "available",
              rating: "4.5",
              firm: "Peneal Legal Consult",
              location: "Amasaman",
            ),

            LawyerCard(
              tap: () {
                tapme('Construction', 'assets/images/construction.png');
              },
              title: "Construction",
              image: "assets/images/construction.png",
              type: "available",
              rating: "4.5",
              firm: "Peneal Legal Consult",
              location: "Amasaman",
            ),

            LawyerCard(
              tap: () {
                tapme('Labourers', 'assets/images/labor.png');
              },
              title: "Labourers",
              image: "assets/images/labor.png",
              type: "available",
              rating: "4.5",
              firm: "Peneal Legal Consult",
              location: "Amasaman",
            ),

            LawyerCard(
              tap: () {
                tapme('Secretaries', 'assets/images/secretary.png');
              },
              title: "Secretaries",
              image: "assets/images/secretary.png",
              type: "available",
              rating: "4.5",
              firm: "Peneal Legal Consult",
              location: "Amasaman",
            ),

            LawyerCard(
              tap: () {
                tapme('Shop Attendants', 'assets/images/shop.png');
              },
              title: "Shop Attendants",
              image: "assets/images/shop.png",
              type: "available",
              rating: "4.5",
              firm: "Peneal Legal Consult",
              location: "Amasaman",
            ),

            LawyerCard(
              tap: () {
                tapme(
                    'Manufacturing workers', 'assets/images/manufacturing.png');
              },
              title: "Manufacturing workers ",
              image: "assets/images/manufacturing.png",
              type: "available",
              rating: "4.5",
              firm: "Peneal Legal Consult",
              location: "Amasaman",
            ),

            LawyerCard(
              tap: () {
                tapme('Mechanics', 'assets/images/mechanic.png');
              },
              title: "Mechanics",
              image: "assets/images/mechanic.png",
              type: "available",
              rating: "4.5",
              firm: "Peneal Legal Consult",
              location: "Amasaman",
            ),

            LawyerCard(
              tap: () {
                tapme('Barbers', 'assets/images/barber.png');
              },
              title: "Barbers",
              image: "assets/images/barber.png",
              type: "available",
              rating: "4.5",
              firm: "Peneal Legal Consult",
              location: "Amasaman",
            ),

            LawyerCard(
              tap: () {
                tapme('Chefs', 'assets/images/chef.png');
              },
              title: "Chefs",
              image: "assets/images/chef.png",
              type: "available",
              rating: "4.5",
              firm: "Peneal Legal Consult",
              location: "Amasaman",
            ),

            LawyerCard(
              tap: () {
                tapme('Shoe makers', 'assets/images/shoe.png');
              },
              title: "Shoe makers",
              image: "assets/images/shoe.png",
              type: "available",
              rating: "4.5",
              firm: "Peneal Legal Consult",
              location: "Amasaman",
            ),
          ],
        ),
      )),
      Profile(
        title: "Welcome",
      ),
      // '5.631560,-0.144900','5.545230,-0.250080'
      MapScreen(
        // nearestOffice:LatLng(30.396770,-97.922780
        ),
    
    ];
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        // appBar: AppBar(
        //   elevation: 0,
        //   iconTheme: IconThemeData(color: Colors.black),
        //   backgroundColor: Color.fromARGB(255, 247, 247, 247),
        //   actions: [
        //     IconButton(
        //         onPressed: () {},
        //         icon: Icon(
        //           Icons.notifications,
        //           color: Colors.black,
        //         )),
        //     IconButton(
        //         onPressed: () {},
        //         icon: Icon(
        //           Icons.perm_contact_calendar,
        //           color: Colors.black,
        //         ))
        //   ],
        // ),
        // drawer: Drawer(
        //   child: ListView(
        //     physics: const BouncingScrollPhysics(),
        //     padding: EdgeInsets.zero,
        //     children: <Widget>[
        //       DrawerHeader(
        //           decoration: BoxDecoration(
        //               color: Colors.white,
        //               image: DecorationImage(
        //                   image: Image.asset("assets/images/logo.jpeg").image,
        //                   fit: BoxFit.cover)),
        //           child: const Opacity(
        //             opacity: 0.0,
        //             child: Text(
        //               "BYDAY JOB AFRICA",
        //               style: TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 20,
        //                 //color: Colors.blue,
        //               ),
        //             ),
        //           )),
        //       ListTile(
        //         title: const Text(
        //           "Home",
        //           style: TextStyle(fontWeight: FontWeight.w700),
        //         ),
        //         leading: const Icon(Icons.home, color: Colors.blueAccent),
        //         onTap: () {
        //           // print("home");
        //           Navigator.pop(context);
        //           // Navigator.push(context,
        //           //     MaterialPageRoute(builder: (context) => HomeScreen()));
        //         },
        //       ),
        //       ListTile(
        //           title: const Text(
        //             "Send Us a mail",
        //             style: TextStyle(fontWeight: FontWeight.w700),
        //           ),
        //           leading: const Icon(Icons.mail, color: Colors.blueAccent),
        //           onTap: () {
        //             // print("mail");
        //             // mail();
        //             Navigator.pop(context);
        //           }),
        //       // ListTile(
        //       //     title: Text("Send Us a message"),
        //       //     leading: Icon(Icons.message, color: Colors.blueAccent),
        //       //     onTap: () {
        //       //       print("message");
        //       //       Navigator.pop(context);
        //       //     }),

        //       ListTile(
        //           title: const Text(
        //             "Visit Us",
        //             style: TextStyle(fontWeight: FontWeight.w700),
        //           ),
        //           leading:
        //               const Icon(Icons.chat_bubble, color: Colors.blueAccent),
        //           onTap: () {
        //             // print("visit");
        //             // mail();
        //             Navigator.pop(context);
        //             const url = "http://www.stedap1.site.live";
        //             // launchUrl(url);
        //           }),
        //       ListTile(
        //           title: const Text(
        //             "Call Us",
        //             style: TextStyle(fontWeight: FontWeight.w700),
        //           ),
        //           leading: const Icon(Icons.call, color: Colors.blueAccent),
        //           onTap: () {
        //             // print("Call Made");
        //             // call();
        //             Navigator.pop(context);
        //           }),
        //       ListTile(
        //           title: const Text(
        //             "Close",
        //             style: TextStyle(fontWeight: FontWeight.w700),
        //           ),
        //           leading:
        //               const Icon(Icons.exit_to_app, color: Colors.blueAccent),
        //           onTap: () {
        //             // print("add people");
        //             Navigator.pop(context);
        //           })
        //     ],
        //   ),
        //   backgroundColor: Colors.white,
        // ),
        bottomNavigationBar: BottomNavigationBar(
          // selectedItemColor: Colors.black,
          // unselectedItemColor: Colors.green,
          backgroundColor: Colors.white, //Color(0xFF0731aa),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.home,
                color: Color(0xff999999),
              ),
              label: "Home",
            ),
            // // BottomNavigationBarItem(
            // //   icon: const Icon(
            // //     Icons.search,
            // //     color: Color(0xff999999),
            // //   ),
            // //   label: "Search",
            // // ),
            // BottomNavigationBarItem(
            //   icon: const Icon(
            //     Icons.calendar_month,
            //     color: Color(0xff999999),
            //   ),
            //   label: "Notifcation",
            // ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.person,
                color: Color(0xff999999),
              ),
              label: "Inter Connect",
            ),

            BottomNavigationBarItem(
              icon: const Icon(
                Icons.map,
                color: Color(0xff999999),
              ),
              label: "Map",
            ),
          ],
          currentIndex: selectedIndex,
          onTap: onTabTapped,
        ),
        body: screens[selectedIndex]);
  }
}
