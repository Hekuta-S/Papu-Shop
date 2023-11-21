import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/models/producto-model.dart';
import 'package:e_shop/screens/user-panel/detalles-producto-screen.dart';
import 'package:e_shop/utils/app-constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

class VentasFlashWidget extends StatelessWidget {
  const VentasFlashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('productos')
          .where('enVenta', isEqualTo: true)
          .get(),
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
            height: Get.height / 5.5,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];
                ProductoModel productoModel = ProductoModel(
                    productoId: productData['productoId'],
                    categoriaId: productData['categoriaId'],
                    productoName: productData['productoName'],
                    categoriaName: productData['categoriaName'],
                    precioVenta: productData['precioVenta'],
                    precioCompleto: productData['precioCompleto'],
                    productoImg: productData['productoImg'],
                    enVenta: productData['enVenta'],
                    descripcionProducto: productData['descripcionProducto'],
                    createdAt: productData['createAt'],
                    updatedAt: productData['updateAt']);
                //CategoriasModel categoriasModel = CategoriasModel(
                //categoriaId: snapshot.data!.docs[index]['categoriaId'],
                //categoriaImg: snapshot.data!.docs[index]['categoriaImg'],
                //categoriaName: snapshot.data!.docs[index]['categoriaName'],
                //createAt: snapshot.data!.docs[index]['createAt'],
                //  updateAt: snapshot.data!.docs[index]['updateAt'],
                //  );

                return Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => DetallesProductosScreeen(
                          productoModel: productoModel)),
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                          child: FillImageCard(
                            borderRadius: 20.0,
                            width: Get.width / 3.5,
                            heightImage: Get.height / 12,
                            imageProvider: CachedNetworkImageProvider(
                              productoModel.productoImg[0],
                            ),
                            title: Center(
                              child: Text(
                                productoModel.productoName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                            footer: Row(children: [
                              Text(
                                "Rs ${productoModel.precioVenta}",
                                style: TextStyle(fontSize: 12.0),
                              ),
                              SizedBox(
                                width: 2.0,
                              ),
                              Text(
                                "${productoModel.precioCompleto}",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: AppConstant.appSecondColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
