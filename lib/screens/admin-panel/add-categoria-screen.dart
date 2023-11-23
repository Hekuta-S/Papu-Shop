// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:e_shop/controllers/registro-controller.dart';
import 'package:e_shop/screens/admin-panel/admin-main-screen.dart';
import 'package:e_shop/screens/auth-ui/login-screen.dart';
import 'package:e_shop/utils/app-constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../controllers/add-categoria-controller.dart';

final _formkey = GlobalKey<FormState>();

class AddCategoriaScreen extends StatefulWidget {
  AddCategoriaScreen({super.key});

  @override
  State<AddCategoriaScreen> createState() => _AddCategoriaScreenState();
}

class _AddCategoriaScreenState extends State<AddCategoriaScreen> {
  File? image_to_subir;
  AddCategoriaController addCategoriaController = AddCategoriaController();
  final RegistroController registroController = Get.put(RegistroController());
  TextEditingController categoriaName = TextEditingController();
  TextEditingController categoriaImg = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecondColor,
            title: Text(
              "Guardar Categoria",
              style: TextStyle(color: AppConstant.appTextColor),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                children: [
                  // SizedBox(
                  //   height: Get.height / 20,
                  // ),

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
                  // SizedBox(
                  //   height: Get.height / 20,
                  // ),

                  // SizedBox(
                  //   height: Get.height / 20,
                  // ),

                  // Form(
                  //   key: _formkey,
                  //   child: ReusableTextField(
                  //     controller: categoriaName,
                  //     maxlength: 30,
                  //     hintText: "Nombre de Categoria",
                  //     prefixIcon: Icons.text_snippet,
                  //     keyboardType: TextInputType.name,
                  //   ),
                  // ),
                  Material(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: categoriaName,
                          maxLength: 30,
                          cursorColor:
                              Colors.blue, // Cambia esto según tus necesidades
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: "Nombre de Categoria",
                            prefixIcon: Icon(Icons.data_object),
                            contentPadding:
                                EdgeInsets.only(top: 2.0, left: 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (name) => name!.length < 10
                              ? 'Debe tener mas de 10 caracteres'
                              : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                    ),
                  ),

                  Material(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: categoriaImg,
                          maxLength: 300,
                          cursorColor:
                              Colors.blue, // Cambia esto según tus necesidades
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: "Ingrese Url de la imagen",
                            prefixIcon: Icon(Icons.image),
                            contentPadding:
                                EdgeInsets.only(top: 2.0, left: 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (name) => name!.length < 10
                              ? 'Debe tener mas de 20 caracteres'
                              : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                    ),
                  ),

                  // ReusableTextField(
                  //     controller: categoriaImg,
                  //     maxlength: 300,
                  //     hintText: "Ingrese Url de la imagen",
                  //     prefixIcon: Icons.image,
                  //     keyboardType: TextInputType.text),

                  // SizedBox(
                  //   height: Get.height / 20,
                  // ),
                  // Material(
                  //   child: Container(
                  //     width: Get.width / 2,
                  //     height: Get.height / 20,
                  //     decoration: BoxDecoration(
                  //         color: AppConstant.appSecondColor,
                  //         borderRadius: BorderRadius.circular(20.0)),
                  //     child: TextButton(
                  //         child: Text("Seleccionar Imagen",
                  //             style:
                  //                 TextStyle(color: AppConstant.appTextColor)),
                  //         onPressed: () async {
                  //           final imagen = await getImage();
                  //           setState(() {
                  //             image_to_subir = File(imagen!.path);

                  //             List<int> imgBytes =
                  //                 File(imagen!.path).readAsBytesSync();
                  //             img = base64Encode(imgBytes);
                  //           });
                  //         }),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: Get.height / 20,
                  // ),
                  Material(
                    child: Container(
                      width: Get.width / 4,
                      height: Get.height / 20,
                      decoration: BoxDecoration(
                          color: AppConstant.appSecondColor,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: TextButton(
                        child: Text("GUARDAR",
                            style: TextStyle(color: AppConstant.appTextColor)),
                        onPressed: () async {
                          // _formkey.currentState!.validate();
                          String name = categoriaName.text.trim();
                          String img = categoriaImg.text.trim();
                          if (name.isEmpty) {
                            Get.snackbar(
                              "Error",
                              "Por favor ingresa todos los datos",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecondColor,
                              colorText: AppConstant.appTextColor,
                            );
                          } else if (name.length < 10) {
                            Get.snackbar(
                              "Error",
                              "El nombre de la categoría debe tener más de 10 caracteres",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecondColor,
                              colorText: AppConstant.appTextColor,
                            );
                          } else {
                            AddCategoriaController addCategoriaController =
                                AddCategoriaController();

                            bool categoriaExists = await addCategoriaController
                                .checkCategoriaExistencia(name);

                            if (categoriaExists) {
                              Get.snackbar(
                                "Error al guardar la categoría.",
                                "La categoría ya existe.",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appSecondColor,
                                colorText: AppConstant.appTextColor,
                              );
                            } else {
                              addCategoriaController.addCategoriaMetodo(
                                  name, img);
                              Get.snackbar(
                                "Categoria Guardada Exitosamente.",
                                "             :D.",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appSecondColor,
                                colorText: AppConstant.appTextColor,
                              );
                              Get.offAll(() => AdminMainScreen());
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: Get.height / 39,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Ya tienes tu cateogira ideal?  ",
                          style: TextStyle(color: AppConstant.appSecondColor)),
                      GestureDetector(
                        onTap: () => Get.offAll(() => LoginScreen()),
                        child: Text("Crea un producto.",
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
