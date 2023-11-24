import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/models/carrito-model.dart';
import 'package:e_shop/models/producto-model.dart';
import 'package:e_shop/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'carrito-screen.dart';

class FacturasScreeen extends StatefulWidget {
  // ProductoModel productoModel;
  FacturasScreeen({super.key});

  @override
  State<FacturasScreeen> createState() => _FacturasScreeenState();
}

class _FacturasScreeenState extends State<FacturasScreeen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          "Detalles de la factura",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: [
                                  TextSpan(
                                    text: "Facturar a: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: "nombre cliente",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: [
                                  TextSpan(
                                    text: "Productos: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: "lista de productos",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              TextSpan(
                                text: "Id de la factura: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: "factura id",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              TextSpan(
                                text: "Enviar a: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: "direccion",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              TextSpan(
                                text: "Precio total a pagar: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: "precio",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Future<void> comprobarExistenciaProducto({
  //   required String uId,
  //   int incrementoPrecio = 1,
  // }) async {
  //   final DocumentReference documentReference = FirebaseFirestore.instance
  //       .collection('carrito')
  //       .doc(uId)
  //       .collection('carritoOrdenes')
  //       .doc(widget.productoModel.productoId.toString());

  //   DocumentSnapshot snapshot = await documentReference.get();

  //   if (snapshot.exists) {
  //     int cantidadActual = snapshot['cantidadProducto'];
  //     int actualizarCantidad = cantidadActual + incrementoPrecio;
  //     double totalPrecio = double.parse(widget.productoModel.enVenta
  //             ? widget.productoModel.precioVenta
  //             : widget.productoModel.precioCompleto) *
  //         actualizarCantidad;
  //     await documentReference.update({
  //       'cantidadProducto': actualizarCantidad,
  //       'precioTotalProducto': totalPrecio,
  //     });
  //     print("producto existe");
  //   } else {
  //     await FirebaseFirestore.instance.collection('carrito').doc(uId).set(
  //       {
  //         'uId': uId,
  //         'createAt': DateTime.now(),
  //       },
  //     );

  //     CarritoModel carritoModel = CarritoModel(
  //         produntoId: widget.productoModel.productoId,
  //         categoriaId: widget.productoModel.categoriaId,
  //         productoName: widget.productoModel.productoName,
  //         categoriaName: widget.productoModel.categoriaName,
  //         precioVenta: widget.productoModel.precioVenta,
  //         precioCompleto: widget.productoModel.precioCompleto,
  //         productoImagen: widget.productoModel.productoImg,
  //         enVenta: widget.productoModel.enVenta,
  //         productoDescripcion: widget.productoModel.descripcionProducto,
  //         createdAt: DateTime.now(),
  //         updtatedAt: DateTime.now(),
  //         cantidadProducto: 1,
  //         precioTotalProducto: double.parse(widget.productoModel.enVenta
  //             ? widget.productoModel.precioVenta
  //             : widget.productoModel.precioCompleto));
  //     await documentReference.set(carritoModel.toMap());
  //     print("producto added");
  //   }
  // }
}
