import 'package:Byday_Job_Africa/home.dart';
import 'package:Byday_Job_Africa/hompage.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart' as path;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  final dir = await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.openBox("bydayjobafrica");
  runApp(const MyApp());
}

Map<int, Color> color = {
  50: Color.fromARGB(255, 192, 128, 0),
  100: Color.fromARGB(255, 192, 128, 0),
  200: Color.fromARGB(255, 192, 128, 0),
  300: Color.fromARGB(255, 192, 128, 0),
  400: Color.fromARGB(255, 192, 128, 0),
  500: Color.fromARGB(255, 192, 128, 0),
  600: Color.fromARGB(255, 192, 128, 0),
  700: Color.fromARGB(255, 192, 128, 0),
  800: Color.fromARGB(255, 192, 128, 0),
  900: Color.fromARGB(255, 192, 128, 0),
};

MaterialColor colorCustom = MaterialColor(0xff4c4c4c, color);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget ?pageChecher(){
  var box =  Hive.box('bydayjobafrica');
    // var firstTime = box.get("firstTime");
    var islogin =  box.get("islog");
    var isfirstime =  box.get("firstrun");

   try{
      if(isfirstime == null){
          return Home();

          
        }
        else{

        return Homepage();
        }
   }catch (e) {
     print (e);
   }
  
  
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByDay Job Africa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: colorCustom,
          scaffoldBackgroundColor: const Color(0xFFc07f00)),
      home: AnimatedSplashScreen(
          duration: 3000,
          splash: Image.asset(
            'assets/images/logo.png',
            width: double.infinity,
            height: 500,
          ),
          nextScreen: pageChecher()!,
          splashTransition: SplashTransition.scaleTransition,
          // pageTransitionType: pageTransitionTy
          backgroundColor: Colors.black),
    );
  }
}


