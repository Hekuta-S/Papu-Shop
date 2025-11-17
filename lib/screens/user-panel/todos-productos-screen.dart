// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/models/producto-model.dart';
import 'package:e_shop/screens/user-panel/detalles-producto-screen.dart';
import 'package:e_shop/utils/app-constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

class AllProductosScreen extends StatelessWidget {
  const AllProductosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          "Todos los Productos",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('productos')
            .where('enVenta', isEqualTo: false)
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
            return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.80),
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
                  updatedAt: productData['updateAt'],
                );
                // CategoriasModel categoriasModel = CategoriasModel(
                //   categoriaId: snapshot.data!.docs[index]['categoriaId'],
                //   categoriaImg: snapshot.data!.docs[index]['categoriaImg'],
                //   categoriaName: snapshot.data!.docs[index]['categoriaName'],
                //   createAt: snapshot.data!.docs[index]['createAt'],
                //   updateAt: snapshot.data!.docs[index]['updateAt'],
                // );

                return Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => DetallesProductosScreeen(
                          productoModel: productoModel)),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          child: FillImageCard(
                              borderRadius: 20.0,
                              width: Get.width / 2.3,
                              heightImage: Get.height / 10,
                              imageProvider: CachedNetworkImageProvider(
                                productoModel.productoImg[0],
                              ),
                              title: Center(
                                child: Text(
                                  productoModel.productoName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              ),
                              footer: Center(
                                child: Text(
                                    "Pesos:  " + productoModel.precioCompleto),
                              )),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
