import 'package:e_shop/screens/auth-ui/register-screen.dart';
import 'package:e_shop/utils/app-constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/recuperar-contraseña-controller.dart';

class RecuperarCScreen extends StatefulWidget {
  const RecuperarCScreen({super.key});

  @override
  State<RecuperarCScreen> createState() => _RecuperarScreenState();
}

class _RecuperarScreenState extends State<RecuperarCScreen> {
  final RecuperarController recuperarController =
      Get.put(RecuperarController());

  TextEditingController userEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecondColor,
            title: Text(
              "Recuperar contraseña",
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
                          controller: userEmail,
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
                        child: Text("Enviar correo",
                            style: TextStyle(color: AppConstant.appTextColor)),
                        onPressed: () async {
                          String email = userEmail.text.trim();

                          if (email.isEmpty) {
                            Get.snackbar(
                              "Error",
                              "Por favor ingrese su correo",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecondColor,
                              colorText: AppConstant.appTextColor,
                            );
                          } else {
                            String email = userEmail.text.trim();
                            recuperarController.RecuperarContraMetodo(email);
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 39,
                  ),
                ],
              ),
            ),
          ));
    });
  }
}
