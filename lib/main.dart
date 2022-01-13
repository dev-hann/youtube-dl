import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_dl/views/home_view.dart';

import 'controllers/controllers.dart';
void main() {
  runApp(const MyApp());
  initControllers();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Youtube-dl',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
    );
  }
}


