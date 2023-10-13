import 'package:e_shop/screens/auth-ui/login-screen.dart';
import 'package:e_shop/utils/app-constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecondColor,
            title: Text(
              "Registrarte",
              style: TextStyle(color: AppConstant.appTextColor),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height / 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Bienvenido a la app",
                      style: TextStyle(
                          color: AppConstant.appSecondColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
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
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: "Usuario",
                              prefixIcon: Icon(Icons.person),
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
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Telefono",
                              prefixIcon: Icon(Icons.phone),
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
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                              hintText: "Direccion",
                              prefixIcon: Icon(Icons.home),
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
                        keyboardType: TextInputType.visiblePassword,
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
                        child: Text("REGISTRARSE",
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
                      Text("Ya tienes una cuenta?  ",
                          style: TextStyle(color: AppConstant.appSecondColor)),
                      GestureDetector(
                        onTap: () => Get.offAll(() => LoginScreen()),
                        child: Text("Logueate.",
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
