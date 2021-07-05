import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/TabController.dart';
import 'screens/HomeScreen.dart';

void main() async {
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        child: HomeScreen(),
        length: MyTabController().myTabs.length,
      ),
      theme: ThemeData(
        fontFamily: 'Raleway',
        primaryColor: Colors.orange[800],
        accentColor: Colors.orangeAccent,
      ),
    ),
  );
}
