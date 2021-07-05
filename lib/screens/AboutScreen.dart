import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('About'),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Made by',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 20.0,
                    color: Colors.orange),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'M.ABHISHEK',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 38.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5.0,
                    color: Colors.deepOrange),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
