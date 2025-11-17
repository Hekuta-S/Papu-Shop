// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/models/categoria-model.dart';
import 'package:e_shop/screens/user-panel/single-categoria-productos-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

class CategoriaWidget extends StatelessWidget {
  const CategoriaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
          return Container(
            height: Get.height / 5.5,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
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
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                          child: FillImageCard(
                            borderRadius: 20.0,
                            width: Get.width / 4.0,
                            heightImage: Get.height / 12,
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
            ),
          );
        }
        return Container();
      },
    );
  }
}
