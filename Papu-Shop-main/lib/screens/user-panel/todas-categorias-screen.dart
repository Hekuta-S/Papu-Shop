import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/screens/user-panel/single-categoria-productos-screen.dart';
import 'package:e_shop/utils/app-constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../../models/categoria-model.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AlCcategoriesScreenState();
}

class _AlCcategoriesScreenState extends State<AllCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          "Categorias",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('categorias').get(),
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
              child: Text("No se ha encontrado ninguna categoria!!"),
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
                CategoriasModel categoriasModel = CategoriasModel(
                  categoriaId: snapshot.data!.docs[index]['categoriaId'],
                  categoriaImg: snapshot.data!.docs[index]['categoriaImg'],
                  categoriaName: snapshot.data!.docs[index]['categoriaName'],
                  createAt: snapshot.data!.docs[index]['createAt'],
                  updateAt: snapshot.data!.docs[index]['updateAt'],
                  img: File(''),
                );

                return Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => SingleCategoriaProductosScreen(
                          categoriaId: categoriasModel.categoriaId)),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          child: FillImageCard(
                            borderRadius: 20.0,
                            width: Get.width / 2.3,
                            heightImage: Get.height / 10,
                            imageProvider: CachedNetworkImageProvider(
                              categoriasModel.categoriaImg,
                            ),
                            title: Center(
                              child: Text(
                                categoriasModel.categoriaName,
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

            //  Container(
            //   height: Get.height / 5.5,
            //   child: ListView.builder(
            //     itemCount: snapshot.data!.docs.length,
            //     shrinkWrap: true,
            //     scrollDirection: Axis.horizontal,

            //   ),
            // );
          }
          return Container();
        },
      ),
    );
  }
}
