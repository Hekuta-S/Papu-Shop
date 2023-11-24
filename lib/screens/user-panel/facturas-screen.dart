import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/controllers/add-factura-controller.dart';
import 'package:e_shop/models/factura-model.dart';
import 'package:e_shop/screens/user-panel/factura-screen.dart';
import 'package:e_shop/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Facturas2Screen extends StatefulWidget {
  const Facturas2Screen({super.key});

  @override
  State<Facturas2Screen> createState() => _Facturas2ScreenState();
}

class _Facturas2ScreenState extends State<Facturas2Screen> {
  FacturaController facturaController = FacturaController();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text("Facturas"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('facturas') // Cambiado a la colección 'facturas'
            .where('clienteId', isEqualTo: user!.uid) // Filtrado por clienteId
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
              child: Text("No se ha encontrado ninguna factura!!"),
            );
          }
          if (snapshot.data != null) {
            return Container(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final facturaData = snapshot.data!.docs[index];
                  FacturaModel facturaModel = FacturaModel(
                    clienteId: facturaData['clienteId'],
                    productosCompra: facturaData['productosCompra'],
                    precioTotal: facturaData['precioTotal'],
                    createdAt: facturaData['createdAt'],
                    updatedAt: facturaData['updatedAt'],
                  );
                  String facturaId = facturaData.id;
                  // Aquí puedes construir tu UI basada en la facturaModel
                  // Puedes acceder a los campos como facturaModel.clienteId, facturaModel.productosCompra, etc.

                  return GestureDetector(
                    onTap: () => Get.to(
                      () => FacturasScreeen(
                          facturaModel: facturaModel, facturaId: facturaId),
                    ),
                    child: Card(
                      elevation: 5,
                      color: AppConstant.appTextColor,
                      child: ListTile(
                        title: Text("Factura Id: " + facturaId),
                        subtitle:
                            Text("Precio Total: ${facturaModel.precioTotal}"),
                        // Otros campos de la factura según sea necesario
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Container(); // En caso de que ninguno de los casos anteriores sea válido
        },
      ),
    );
  }
}
