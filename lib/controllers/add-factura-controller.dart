import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FacturaController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> agregarFactura({
    required String clienteId,
    required List<dynamic> productosCompra,
    required double precioTotal,
  }) async {
    try {
      DocumentReference docRef = await _firestore.collection("facturas").add({
        "clienteId": clienteId,
        "productosCompra": productosCompra,
        "precioTotal": precioTotal,
        "createdAt": DateTime.now(),
        "updatedAt": DateTime.now(),
      });

      String facturaId = docRef.id;
      await docRef.update({"facturaId": facturaId});
    } catch (e) {
      print('Error al agregar factura: $e');
      // Manejar el error según tus necesidades
    }
  }

  // Puedes agregar métodos adicionales según tus necesidades
}
