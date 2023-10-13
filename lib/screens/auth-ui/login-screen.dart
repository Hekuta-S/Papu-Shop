import 'package:e_shop/screens/auth-ui/register-screen.dart';
import 'package:e_shop/utils/app-constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecondColor,
            title: Text(
              "Inicio de sesion",
              style: TextStyle(color: AppConstant.appTextColor),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                children: [
                  isKeyboardVisible
                      ? Text("bienvenido a la app")
                      : Column(
                          children: [
                            Lottie.asset('assets/images/wolf_Main.json')
                          ],
                        ),
                  SizedBox(
                    height: Get.height / 20,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          cursorColor: AppConstant.appSecondColor,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "Correo",
                              prefixIcon: Icon(Icons.email),
                              contentPadding:
                                  EdgeInsets.only(top: 2.0, left: 8.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        cursorColor: AppConstant.appSecondColor,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Contraseña",
                            prefixIcon: Icon(Icons.password),
                            suffixIcon: Icon(Icons.visibility_off),
                            contentPadding:
                                EdgeInsets.only(top: 2.0, left: 8.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Olvidaste la contraseña?",
                      style: TextStyle(
                          color: AppConstant.appSecondColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 20,
                  ),
                  Material(
                    child: Container(
                      width: Get.width / 2,
                      height: Get.height / 20,
                      decoration: BoxDecoration(
                          color: AppConstant.appSecondColor,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: TextButton(
                        child: Text("INICIAR SESION",
                            style: TextStyle(color: AppConstant.appTextColor)),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 39,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No tienes una cuenta?  ",
                          style: TextStyle(color: AppConstant.appSecondColor)),
                      GestureDetector(
                        onTap: () => Get.offAll(() => RegisterScreen()),
                        child: Text("Registrate.",
                            style: TextStyle(
                                color: AppConstant.appSecondColor,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ));
    });
  }
}
