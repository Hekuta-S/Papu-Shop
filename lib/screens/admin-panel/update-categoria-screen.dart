import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_shop/controllers/add-categoria-controller.dart';
import 'package:e_shop/controllers/registro-controller.dart';
import 'package:e_shop/controllers/update-categoria-controller.dart';
import 'package:e_shop/models/categoria-model.dart';
import 'package:e_shop/utils/app-constant.dart';
import 'package:e_shop/widgets/buttom-borrar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../controllers/eliminar-archivo-firebase-controller.dart';
import 'admin-main-screen.dart';

class UpdateCategoriaScreen extends StatefulWidget {
  final CategoriasModel categoriasModel;
  const UpdateCategoriaScreen(this.categoriasModel, {super.key});

  @override
  State<UpdateCategoriaScreen> createState() => _UpdateCategoriaScreenState();
}

class _UpdateCategoriaScreenState extends State<UpdateCategoriaScreen> {
  final RegistroController registroController = Get.put(RegistroController());

  TextEditingController categoriaName = TextEditingController();
  TextEditingController categoriaImg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String image_conver = (widget.categoriasModel.categoriaImg);
    DeleteController deleteController = DeleteController();

    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecondColor,
            title: Text(
              "Actualizar Categoria",
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
                  CachedNetworkImage(
                    imageUrl: image_conver,
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
                  // SizedBox(
                  //   height: Get.height / 20,
                  // ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: categoriaName,
                          maxLength: 10,
                          cursorColor: AppConstant.appSecondColor,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: widget.categoriasModel.categoriaName,
                              prefixIcon: Icon(Icons.category),
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
                        child: TextField(
                          controller: categoriaImg,
                          maxLength: 100,
                          cursorColor: AppConstant.appSecondColor,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: "URL Imagen Caracteristica",
                              prefixIcon: Icon(Icons.image),
                              contentPadding:
                                  EdgeInsets.only(top: 2.0, left: 8.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                      )),
                  // SizedBox(
                  //   height: Get.height / 20,
                  // ),
                  Material(
                    child: Container(
                      width: Get.width / 2,
                      height: Get.height / 20,
                      decoration: BoxDecoration(
                          color: AppConstant.appSecondColor,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: TextButton(
                        child: Text("Actualizar",
                            style: TextStyle(color: AppConstant.appTextColor)),
                        onPressed: () async {
                          String name = categoriaName.text.trim();
                          String img = categoriaImg.text.trim();
                          if (name.isEmpty || img.isEmpty) {
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
                                "Error al editar la categoría.",
                                "La categoría ya existe.",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appSecondColor,
                                colorText: AppConstant.appTextColor,
                              );
                            } else {
                              UpdateCategoriaController
                                  updateCategoriaController =
                                  UpdateCategoriaController();
                              updateCategoriaController
                                  .addOrUpdateCategoriaMetodo(
                                      widget.categoriasModel.categoriaId,
                                      name,
                                      img);
                              Get.snackbar(
                                "Categoria Updateada Exitosamente.",
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
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: BotonBorrar(
                        onPressed: () {
                          AlertDialog alertDialog = AlertDialog(
                            backgroundColor:
                                const Color.fromARGB(255, 106, 107, 106),
                            title: Text(
                              '¿Estás seguro de que quieres borrar esta categoría?',
                              style: TextStyle(color: AppConstant.appTextColor),
                            ),
                            content: Text(
                              'Esta acción no se puede deshacer.',
                              style: TextStyle(color: AppConstant.appTextColor),
                            ),
                            actions: [
                              TextButton(
                                child: Text(
                                  'Cancelar',
                                  style: TextStyle(
                                      color: AppConstant.appSecondColor),
                                  selectionColor: AppConstant.appSecondColor,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Borrar',
                                    style: TextStyle(
                                        color: AppConstant.appSecondColor)),
                                onPressed: () {
                                  deleteController.borrarDocument("categorias",
                                      widget.categoriasModel.categoriaId);
                                  Get.snackbar(
                                    "Categoria Eliminada Exitosamente.",
                                    "             :D.",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: AppConstant.appSecondColor,
                                    colorText: AppConstant.appTextColor,
                                  );
                                  Get.offAll(() => AdminMainScreen());
                                },
                              ),
                            ],
                          );

                          showDialog(
                              context: context,
                              builder: (BuildContext context) => alertDialog);
                        },
                      ),
                    ),
                  ),

                  // SizedBox(
                  //   height: Get.height / 39,
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
