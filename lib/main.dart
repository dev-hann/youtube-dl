import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:youtube_dl/views/fragment_view.dart';
import 'const/color.dart';
import 'controllers/controllers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  runApp(const MyApp());

  initControllers();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Youtube-dl',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: DlBlackColor,
          scaffoldBackgroundColor: DlBlackColor,
          iconTheme: const IconThemeData(color: DlWhiteColor),
          textTheme: TextTheme(
            headline2: GoogleFonts.sunflower(fontSize: 32),
            headline3: GoogleFonts.sunflower(fontSize: 30),
            headline4: GoogleFonts.sunflower(fontSize: 28),
            headline5: GoogleFonts.sunflower(fontSize: 26),
            headline6: GoogleFonts.sunflower(fontSize: 24),
            bodyText1: GoogleFonts.sunflower(fontSize: 20),
            bodyText2: GoogleFonts.sunflower(fontSize: 16),
            subtitle1: GoogleFonts.sunflower(fontSize: 18),
          ).apply(
            bodyColor: DlWhiteColor,
            displayColor: DlWhiteColor,
          )),
      home: FragmentView(),
    );
  }
}
