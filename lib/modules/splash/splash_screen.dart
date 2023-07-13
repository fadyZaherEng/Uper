import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uper_app/layout/home_screen.dart';
import 'package:uper_app/modules/login/login_screen.dart';
import 'package:uper_app/shared/network/local/cashe_helper.dart';

class SplashScreen extends StatefulWidget {
String? name;

SplashScreen(this.name);

  @override
  State<SplashScreen> createState() => _SplashScreenState(name);
}

class _SplashScreenState extends State<SplashScreen> {
  String? name;

  _SplashScreenState(this.name);
  @override
  void initState() {
    Timer(const Duration(seconds: 3), (){
      if(name=='home') {
        Navigator.push(context,MaterialPageRoute(
          builder:(context)=>const HomeScreen()
      ) );
      }
      else
        {
          Navigator.push(context,MaterialPageRoute(
              builder:(context)=>LogInScreen()
          ) );
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
            child:CircleAvatar(
              radius: 130,
              backgroundImage:SharedHelper.get(key: "mode")!=null&&SharedHelper.get(key: "mode")=="dark"? const AssetImage('assets/images/4.jpg'):const AssetImage('assets/images/2.jpg'),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
        ),
      ),
    );
  }
}
