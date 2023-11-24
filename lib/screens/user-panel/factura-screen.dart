import 'package:e_shop/controllers/busquedas-controller.dart';
import 'package:e_shop/models/factura-model.dart';
import 'package:e_shop/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FacturasScreeen extends StatefulWidget {
  // ProductoModel productoModel;
  String facturaId;
  FacturaModel facturaModel;
  FacturasScreeen(
      {super.key, required this.facturaModel, required this.facturaId});

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
                          child: encontrarNombrePorId(
                              widget.facturaModel.clienteId)
                          // RichText(
                          //   text: TextSpan(
                          //     style: DefaultTextStyle.of(context).style,
                          //     children: [
                          //       TextSpan(
                          //         text: "Enviar a: ",
                          //         style: TextStyle(fontWeight: FontWeight.bold),
                          //       ),
                          //       TextSpan(
                          //         text: encontrarDireccionPorId(
                          //                 widget.facturaModel.clienteId)
                          //             .toString(),
                          //       ),
                          //     ],
                          //   ),
                          // ),
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
                                  for (var producto
                                      in widget.facturaModel.productosCompra)
                                    TextSpan(
                                      text:
                                          '${producto['productoName']} x ${producto['cantidadProducto']} \n',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
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
                                text: widget.facturaId,
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
                          child: encontrarDireccionPorId(
                              widget.facturaModel.clienteId)
                          // RichText(
                          //   text: TextSpan(
                          //     style: DefaultTextStyle.of(context).style,
                          //     children: [
                          //       TextSpan(
                          //         text: "Enviar a: ",
                          //         style: TextStyle(fontWeight: FontWeight.bold),
                          //       ),
                          //       TextSpan(
                          //         text: encontrarDireccionPorId(
                          //                 widget.facturaModel.clienteId)
                          //             .toString(),
                          //       ),
                          //     ],
                          //   ),
                          // ),
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
                                text:
                                    widget.facturaModel.precioTotal.toString(),
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

  String formatoPersonalizado(String nombreColumna) {
    // Realiza aquí la manipulación o formato que desees
    return nombreColumna.replaceAll('productoName', ' ').toUpperCase();
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

//este esssssssss

  // FacturaModel facturaModel = FacturaModel(
  //     clienteId: widget.facturaModel.clienteId,
  //     productosCompra: widget.facturaModel.,
  //     precioTotal: precioTotal,
  //     createdAt: createdAt,
  //     updatedAt: updatedAt);

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
