import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/controllers/registro-controller.dart';
import 'package:e_shop/controllers/update-producto-controller.dart';
import 'package:e_shop/models/producto-model.dart';
import 'package:e_shop/screens/admin-panel/admin-main-screen.dart';
import 'package:e_shop/utils/app-constant.dart';
import 'package:e_shop/widgets/boton-switch.dart';
import 'package:e_shop/widgets/text-field-base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../controllers/eliminar-archivo-firebase-controller.dart';
import '../../widgets/buttom-borrar.dart';

class UpdateProductoScreen extends StatefulWidget {
  final ProductoModel productoModel;
  const UpdateProductoScreen(this.productoModel, {super.key});

  @override
  State<UpdateProductoScreen> createState() => _UpdateProductoScreenState();
}

class _UpdateProductoScreenState extends State<UpdateProductoScreen> {
  String categoriaid = "0";
  String categorianame = "0";
  String seleccionDrDw = "0";
  String selectedCategoriaName = '';
  bool estadoI = false;
  bool swch = false;
  String nuevovalor = "0";
  final RegistroController registroController = Get.put(RegistroController());
  TextEditingController nameProduct = TextEditingController();
  TextEditingController descripcionProduct = TextEditingController();
  TextEditingController precioCompleto = TextEditingController();
  TextEditingController precioVenta = TextEditingController();
  TextEditingController url = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DeleteController deleteController = DeleteController();
    swch = widget.productoModel.enVenta;
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecondColor,
            title: Text(
              "Añadir Producto",
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
                    imageUrl: widget.productoModel.productoImg[0],
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Elige las caracteristicas del producto",
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
                          controller: nameProduct,
                          maxLength: 50,
                          cursorColor: AppConstant.appSecondColor,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: widget.productoModel.productoName,
                              prefixIcon: Icon(Icons.gif_box),
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
                          controller: precioCompleto,
                          cursorColor: AppConstant.appSecondColor,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: widget.productoModel.precioCompleto,
                              prefixIcon: Icon(Icons.price_change_outlined),
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
                          controller: precioVenta,
                          cursorColor: AppConstant.appSecondColor,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: widget.productoModel.precioVenta,
                              prefixIcon: Icon(Icons.price_change),
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
                          controller: descripcionProduct,
                          maxLength: 100,
                          cursorColor: AppConstant.appSecondColor,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintText:
                                  widget.productoModel.descripcionProducto,
                              prefixIcon: Icon(Icons.telegram),
                              contentPadding:
                                  EdgeInsets.only(top: 2.0, left: 8.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                      )),
                  ReusableTextField(
                      controller: url,
                      maxlength: 500,
                      hintText: "Ingrese Url de la imagen",
                      prefixIcon: Icons.card_travel,
                      keyboardType: TextInputType.text),
                  // SizedBox(
                  //   height: Get.height / 20,
                  // ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('categorias')
                          .snapshots(),
                      builder: (context, snapshot) {
                        List<DropdownMenuItem> categoriasname = [];
                        if (!snapshot.hasData) {
                          const CircularProgressIndicator();
                        } else {
                          final categorias =
                              snapshot.data?.docs.reversed.toList();
                          categoriasname.add(
                            const DropdownMenuItem(
                              value: "0",
                              child: Text(
                                "Selecciona una Categoria",
                                style:
                                    TextStyle(color: AppConstant.appMainColor),
                              ),
                            ),
                          );
                          for (var catego in snapshot.data!.docs.reversed) {
                            String categoriaName = catego["categoriaName"];
                            categoriasname.add(
                              DropdownMenuItem(
                                value: catego.id,
                                child: Text(
                                  categoriaName,
                                  style: TextStyle(
                                      color: AppConstant.appMainColor),
                                ),
                              ),
                            );
                            if (catego.id == seleccionDrDw) {
                              selectedCategoriaName = categorianame;
                            }
                          }
                        }
                        return DropdownButton(
                          items: categoriasname,
                          onChanged: (categoriaValor) {
                            setState(() {
                              seleccionDrDw = categoriaValor;
                              selectedCategoriaName = (categoriasname
                                      .firstWhere((item) =>
                                          item.value == categoriaValor)
                                      .child as Text)
                                  .data!;
                            });

                            categoriaid = categoriaValor;
                            print(selectedCategoriaName);
                            print(categoriaid);
                            categorianame = selectedCategoriaName;
                          },
                          value: seleccionDrDw,
                          isExpanded: false,
                          icon: Icon(Icons.arrow_drop_down,
                              color: AppConstant.appMainColor),
                          underline: Container(
                              height: 2, color: AppConstant.appSecondColor),
                          style: TextStyle(color: Colors.white),
                        );
                      }),
                  SizedBox(
                    height: Get.height / 20,
                  ),

                  BotonSwitchNaranja(
                    estadoInicial: widget.productoModel.enVenta,
                    onCambioEstado: (nuevoValor) {
                      print("Nuevo valor: $nuevoValor");
                      if (swch = nuevoValor == 'true') ;
                      print(swch);
                    },
                  ),
                  SizedBox(
                    height: Get.height / 40,
                  ),
                  Material(
                    child: Container(
                      width: Get.width / 2,
                      height: Get.height / 20,
                      decoration: BoxDecoration(
                          color: AppConstant.appSecondColor,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: TextButton(
                        child: Text("Actualizar Producto",
                            style: TextStyle(color: AppConstant.appTextColor)),
                        onPressed: () async {
                          String name = nameProduct.text.trim();
                          String pCompleto = precioCompleto.text.trim();
                          String pVenta = precioVenta.text.trim();
                          String descrip = descripcionProduct.text.trim();
                          List<String> urll = [
                            url.text.trim()
                          ]; // String descrip = descripcionProduct.text.trim();

                          if (name.isEmpty ||
                              pCompleto.isEmpty ||
                              pVenta.isEmpty ||
                              descrip.isEmpty) {
                            Get.snackbar(
                              "Error",
                              "Por favor ingresa todos los datos",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecondColor,
                              colorText: AppConstant.appTextColor,
                            );
                          } else if (pCompleto.length < 3) {
                            Get.snackbar(
                              "Error",
                              "El numero debe tener mas 3 caracteres",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecondColor,
                              colorText: AppConstant.appTextColor,
                            );
                          } else if (name.length < 3) {
                            Get.snackbar(
                              "Error",
                              "El nombre debe tener mas de 10 caracteres",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecondColor,
                              colorText: AppConstant.appTextColor,
                            );
                          } else if (pVenta.length < 3) {
                            Get.snackbar(
                              "Error",
                              "El numero debe tener mas 3 caracteres",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecondColor,
                              colorText: AppConstant.appTextColor,
                            );
                          } else if (descrip.length < 10) {
                            Get.snackbar(
                              "Error",
                              "la descrtipcion debe tener mas de 10 caracteres",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecondColor,
                              colorText: AppConstant.appTextColor,
                            );
                          } else {
                            UpdateProductoController updateProductoController =
                                UpdateProductoController();
                            updateProductoController.updateProductoMetodo(
                                widget.productoModel.productoId,
                                name,
                                categoriaid,
                                selectedCategoriaName,
                                pCompleto,
                                pVenta,
                                urll,
                                descrip,
                                swch);
                            Get.snackbar(
                              "Producto Updateado Exitosamente.",
                              "             :D.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecondColor,
                              colorText: AppConstant.appTextColor,
                            );
                            Get.offAll(() => AdminMainScreen());
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
                              '¿Estás seguro de que quieres borrar este Producto?',
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
                                  deleteController.borrarDocument("productos",
                                      widget.productoModel.productoId);
                                  Get.snackbar(
                                    "Producto Eliminado Exitosamente.",
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
                ],
              ),
            ),
          ));
    });
  }
}
