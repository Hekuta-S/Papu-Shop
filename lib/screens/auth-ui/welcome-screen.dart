// ignore_for_file: file_names

import 'package:e_shop/screens/auth-ui/login-screen.dart';
import 'package:e_shop/utils/app-constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/inicio-sesio-google-controller.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final GoogleInicioSesionController _googleInicioSesionController =
      Get.put(GoogleInicioSesionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppConstant.appMainColor,
        title:
            Text("Welcome", style: TextStyle(color: AppConstant.appTextColor)),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 480,
              height: 400,
              child: Lottie.asset('assets/images/wolf_Main.json'),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                "Hola papu/ mamu",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: Get.height / 12,
            ),
            Material(
              child: Container(
                width: 300,
                height: Get.height / 20,
                decoration: BoxDecoration(
                    color: AppConstant.appSecondColor,
                    borderRadius: BorderRadius.circular(20.0)),
                child: TextButton.icon(
                  icon: Image.asset(
                    'assets/images/google_icon.png',
                    width: Get.width / 20,
                    height: Get.height / 20,
                  ),
                  label: Text("Inicia sesion con google",
                      style: TextStyle(color: AppConstant.appTextColor)),
                  onPressed: () {
                    _googleInicioSesionController.inicioSesionConGoogle();
                  },
                ),
              ),
            ),
            SizedBox(
              height: Get.height / 38,
            ),
            Material(
              child: Container(
                width: 300,
                height: Get.height / 20,
                decoration: BoxDecoration(
                    color: AppConstant.appSecondColor,
                    borderRadius: BorderRadius.circular(20.0)),
                child: TextButton.icon(
                  icon: Icon(
                    Icons.email,
                    color: AppConstant.appTextColor,
                  ),
                  label: Text("Inicia sesion con con Email",
                      style: TextStyle(color: AppConstant.appTextColor)),
                  onPressed: () {
                    Get.to(() => LoginScreen());
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
