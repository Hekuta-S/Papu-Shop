import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/models/carrito-model.dart';
import 'package:e_shop/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';

import '../../controllers/precio-carrito-controller.dart';

class CarritoScreen extends StatefulWidget {
  const CarritoScreen({super.key});

  @override
  State<CarritoScreen> createState() => _CarritoScreenState();
}

class _CarritoScreenState extends State<CarritoScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  double total = 0.0;
  final ProductoPresionController productoPresionController =
      Get.put(ProductoPresionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text("Carrito"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('carrito')
            .doc(user!.uid)
            .collection('carritoOrdenes')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: Get.height / 5,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No se ha encontrado ningun producto!!"),
            );
          }
          if (snapshot.data != null) {
            return Container(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final productData = snapshot.data!.docs[index];
                  CarritoModel carritoModel = CarritoModel(
                    produntoId: productData['produntoId'],
                    categoriaId: productData['categoriaId'],
                    productoName: productData['productoName'],
                    categoriaName: productData['categoriaName'],
                    precioVenta: productData['precioVenta'],
                    precioCompleto: productData['precioCompleto'],
                    productoImagen: productData['productoImagen'],
                    enVenta: productData['enVenta'],
                    productoDescripcion: productData['productoDescripcion'],
                    createdAt: productData['createAt'],
                    updtatedAt: productData['updtateAt'],
                    cantidadProducto: productData['cantidadProducto'],
                    precioTotalProducto: productData['precioTotalProducto'],
                  );

                  productoPresionController.fetchProductosPrecio();

                  // print(productoPresionController.totalPrecio.toDouble());
                  return SwipeActionCell(
                    key: ObjectKey(carritoModel.produntoId),
                    trailingActions: [
                      SwipeAction(
                          title: "Eliminar",
                          forceAlignmentToBoundary: true,
                          performsFirstActionWithFullSwipe: true,
                          onTap: (CompletionHandler handler) async {
                            print('borrado');
                            await FirebaseFirestore.instance
                                .collection('carrito')
                                .doc(user!.uid)
                                .collection('carritoOrdenes')
                                .doc(carritoModel.produntoId)
                                .delete();
                          })
                    ],
                    child: Card(
                      elevation: 5,
                      color: AppConstant.appTextColor,
                      child: ListTile(
                        leading: CircleAvatar(
                            backgroundColor: AppConstant.appMainColor,
                            backgroundImage: NetworkImage(
                                carritoModel.productoImagen[0].toString())),
                        title: Text(carritoModel.productoName),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(carritoModel.precioTotalProducto.toString()),
                            SizedBox(width: Get.width / 20 - 0),
                            GestureDetector(
                              onTap: () async {
                                if (carritoModel.cantidadProducto > 1) {
                                  FirebaseFirestore.instance
                                      .collection('carrito')
                                      .doc(user!.uid)
                                      .collection('carritoOrdenes')
                                      .doc(carritoModel.produntoId)
                                      .update({
                                    'cantidadProducto':
                                        carritoModel.cantidadProducto - 1,
                                    'precioTotalProducto': (double.parse(
                                            carritoModel.precioCompleto) *
                                        (carritoModel.cantidadProducto - 1))
                                  });
                                }
                              },
                              child: CircleAvatar(
                                radius: 14.0,
                                backgroundColor: AppConstant.appMainColor,
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                      color: AppConstant.appSecondColor),
                                ),
                              ),
                            ),
                            SizedBox(width: Get.width / 20 - 0),
                            GestureDetector(
                              onTap: () {
                                if (carritoModel.cantidadProducto > 0) {
                                  FirebaseFirestore.instance
                                      .collection('carrito')
                                      .doc(user!.uid)
                                      .collection('carritoOrdenes')
                                      .doc(carritoModel.produntoId)
                                      .update({
                                    'cantidadProducto':
                                        carritoModel.cantidadProducto + 1,
                                    'precioTotalProducto': double.parse(
                                            carritoModel.precioCompleto) +
                                        double.parse(
                                                carritoModel.precioCompleto) *
                                            (carritoModel.cantidadProducto)
                                  });
                                }
                              },
                              child: CircleAvatar(
                                radius: 14.0,
                                backgroundColor: AppConstant.appMainColor,
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                      color: AppConstant.appSecondColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return Container();
        },
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Text("Total :" +
                "${productoPresionController.totalPrecio.toDouble()}")),
            SizedBox(
              width: Get.width / 3.1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: Get.width / 3.0,
                height: Get.height / 20,
                decoration: BoxDecoration(
                    color: AppConstant.appSecondColor,
                    borderRadius: BorderRadius.circular(20.0)),
                child: TextButton(
                  child: Text("Comprar",
                      style: TextStyle(color: AppConstant.appTextColor)),
                  onPressed: () {
                    print(productoPresionController.totalPrecio.toDouble());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
