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

class DetallesProductosScreeen extends StatefulWidget {
  ProductoModel productoModel;
  DetallesProductosScreeen({super.key, required this.productoModel});

  @override
  State<DetallesProductosScreeen> createState() =>
      _DetallesProductosScreeenState();
}

class _DetallesProductosScreeenState extends State<DetallesProductosScreeen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text("Detalles del Producto"),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: Get.height / 60),
            CarouselSlider(
              items: widget.productoModel.productoImg
                  .map(
                    (urlImagenes) => ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: urlImagenes,
                        fit: BoxFit.cover,
                        width: Get.width - 10,
                        placeholder: (context, url) => ColoredBox(
                          color: Colors.white,
                          child: Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, Error) => Icon(Icons.error),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                aspectRatio: 2.5,
                viewportFraction: 1,
              ),
            ),
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
                              Text(
                                widget.productoModel.productoName,
                              ),
                              Icon(Icons.favorite_outline)
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              widget.productoModel.enVenta == true &&
                                      widget.productoModel.precioVenta != ''
                                  ? Text(
                                      "Pesos: " +
                                          widget.productoModel.precioVenta,
                                    )
                                  : Text(
                                      "Pesos: " +
                                          widget.productoModel.precioCompleto,
                                    ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Categoria: " + widget.productoModel.categoriaName,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.productoModel.descripcionProducto,
                          )),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              child: Container(
                                width: Get.width / 3.0,
                                height: Get.height / 20,
                                decoration: BoxDecoration(
                                    color: AppConstant.appSecondColor,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: TextButton(
                                  child: Text("WhatsApp",
                                      style: TextStyle(
                                          color: AppConstant.appTextColor)),
                                  onPressed: () {
                                    // Get.to(() => LoginScreen());
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2.0,
                            ),
                            Material(
                              child: Container(
                                width: Get.width / 3.0,
                                height: Get.height / 20,
                                decoration: BoxDecoration(
                                    color: AppConstant.appSecondColor,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: TextButton(
                                  child: Text("Agregar al carrito",
                                      style: TextStyle(
                                          color: AppConstant.appTextColor)),
                                  onPressed: () async {
                                    await comprobarExistenciaProducto(
                                        uId: user!.uid);
                                    // Get.to(() => LoginScreen());
                                  },
                                ),
                              ),
                            ),
                          ],
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

  Future<void> comprobarExistenciaProducto({
    required String uId,
    int incrementoPrecio = 1,
  }) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('carrito')
        .doc(uId)
        .collection('carritoOrdenes')
        .doc(widget.productoModel.productoId.toString());

    DocumentSnapshot snapshot = await documentReference.get();

    if (snapshot.exists) {
      int cantidadActual = snapshot['precioProducto'];
      int actualizarCantidad = cantidadActual + incrementoPrecio;
      double totalPrecio = double.parse(widget.productoModel.precioCompleto) *
          actualizarCantidad;
      await documentReference.update({
        'precioProducto': actualizarCantidad,
        'precioTotalProducto': totalPrecio,
      });
      print("producto existe");
    } else {
      await FirebaseFirestore.instance.collection('carrito').doc(uId).set(
        {
          'uId': uId,
          'createAt': DateTime.now(),
        },
      );

      CarritoModel carritoModel = CarritoModel(
          produntoId: widget.productoModel.productoId,
          categoriaId: widget.productoModel.categoriaId,
          productoName: widget.productoModel.productoName,
          categoriaName: widget.productoModel.categoriaName,
          precioVenta: widget.productoModel.precioVenta,
          precioCompleto: widget.productoModel.precioCompleto,
          productoImagen: widget.productoModel.productoImg,
          enVenta: widget.productoModel.enVenta,
          productoDescripcion: widget.productoModel.descripcionProducto,
          createdAt: widget.productoModel.createdAt,
          updtatedAt: widget.productoModel.updatedAt,
          cantidadProducto: 1,
          precioTotalProducto:
              double.parse(widget.productoModel.precioCompleto));
      await documentReference.set(carritoModel.toMap());
      print("producto added");
    }
  }
}
