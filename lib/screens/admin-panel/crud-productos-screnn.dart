import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/screens/admin-panel/add-producto-screen.dart';
import 'package:e_shop/screens/admin-panel/update-producto-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../../models/producto-model.dart';
import '../../utils/app-constant.dart';
import '../../widgets/buttom-add.dart';

class CrudProductosScreen extends StatefulWidget {
  const CrudProductosScreen({super.key});

  @override
  State<CrudProductosScreen> createState() => _CrudProductosScreenState();
}

class _CrudProductosScreenState extends State<CrudProductosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          "Todas Las Productos en Descuento",
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
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  childAspectRatio: 1.19),
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
                      onTap: () =>
                          Get.to(() => UpdateProductoScreen(productoModel)),
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
                          ),
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
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BotonAdd(
            onPressed: () {
              Get.to(() => AddProductoScreen());
            },
          ),
        ),
      ),
    );
  }
}
