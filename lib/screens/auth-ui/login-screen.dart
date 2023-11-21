import 'package:e_shop/controllers/inicio-sesion-controller.dart';
import 'package:e_shop/screens/admin-panel/add-producto-screen.dart';
import 'package:e_shop/screens/admin-panel/admin-main-screen.dart';
import 'package:e_shop/screens/admin-panel/crud-categorias-screen.dart';
import 'package:e_shop/screens/auth-ui/recuperar-contrase%C3%B1a-screen.dart';
import 'package:e_shop/screens/auth-ui/register-screen.dart';
import 'package:e_shop/screens/user-panel/main-screen.dart';
import 'package:e_shop/utils/app-constant.dart';
import 'package:e_shop/widgets/text-field-base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/get-datos-usuario-controller.dart';
import '../admin-panel/add-categoria-screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final InicioController inicioController = Get.put(InicioController());
  final GetDatosUserController getDatosUserController =
      Get.put(GetDatosUserController());
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(
                          () => TextFormField(
                            controller: userPassword,
                            obscureText:
                                inicioController.isPasswordVisible.value,
                            cursorColor: AppConstant.appSecondColor,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                hintText: "Contraseña",
                                prefixIcon: Icon(Icons.password),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      inicioController.isPasswordVisible
                                          .toggle();
                                    },
                                    child:
                                        inicioController.isPasswordVisible.value
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility)),
                                contentPadding:
                                    EdgeInsets.only(top: 2.0, left: 8.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                          ),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => RecuperarCScreen());
                      },
                      child: Text(
                        "Olvidaste la contraseña?",
                        style: TextStyle(
                            color: AppConstant.appSecondColor,
                            fontWeight: FontWeight.bold),
                      ),
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
                        onPressed: () async {
                          String email = userEmail.text.trim();
                          String password = userPassword.text.trim();
                          if (email.isEmpty || password.isEmpty) {
                            Get.snackbar(
                              "Error",
                              "Por favor rellene todos los campos",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecondColor,
                              colorText: AppConstant.appTextColor,
                            );
                          } else {
                            UserCredential? userCredential =
                                await inicioController.iniciarMetodo(
                                    email, password);

                            var userDatos = await getDatosUserController
                                .getUserData(userCredential!.user!.uid);

                            if (userCredential != null) {
                              if (userCredential.user!.emailVerified) {
                                //
                                if (userDatos[0]['isAdmin'] == true) {
                                  Get.snackbar(
                                    "Excelente",
                                    "Admin logueado correctamente!",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: AppConstant.appSecondColor,
                                    colorText: AppConstant.appTextColor,
                                  );
                                  Get.offAll(() => AdminMainScreen());
                                } else {
                                  Get.offAll(() => MainScreen());
                                  Get.snackbar(
                                    "Excelente",
                                    "Usuario logueado correctamente!",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: AppConstant.appSecondColor,
                                    colorText: AppConstant.appTextColor,
                                  );
                                }
                              } else {
                                Get.snackbar(
                                  "Error",
                                  "Por favor verifique los datos",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: AppConstant.appSecondColor,
                                  colorText: AppConstant.appTextColor,
                                );
                              }
                            } else {
                              Get.snackbar(
                                "Error",
                                "Por favor intenta de nuevo",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appSecondColor,
                                colorText: AppConstant.appTextColor,
                              );
                            }
                          }
                        },
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
