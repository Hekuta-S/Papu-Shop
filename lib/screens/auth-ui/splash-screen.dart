import 'dart:async';

import 'package:e_shop/controllers/get-datos-usuario-controller.dart';
import 'package:e_shop/screens/admin-panel/admin-main-screen.dart';
import 'package:e_shop/screens/auth-ui/welcome-screen.dart';
import 'package:e_shop/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../user-panel/main-screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      loggding(context);
    });
  }

  Future<void> loggding(BuildContext context) async {
    if (user != null) {
      final GetDatosUserController getDatosUserController =
          Get.put(GetDatosUserController());
      var datosUser = await getDatosUserController.getUserData(user!.uid);

      if (datosUser[0]['isAdmin'] == true) {
        Get.offAll(() => AdminMainScreen());
      } else {
        Get.offAll(() => MainScreen());
      }
    } else {
      Get.to(() => WelcomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppConstant.appSecondColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondColor,
        elevation: 0,
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(
            child: Container(
              width: Get.width,
              alignment: Alignment.center,
              child: Lottie.asset('assets/images/wolf_Main.json'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20.0),
            width: Get.width,
            alignment: Alignment.center,
            child: Text(
              AppConstant.appPoweredBy,
              style: TextStyle(
                  color: AppConstant.appTextColor,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      )),
    );
  }
}
