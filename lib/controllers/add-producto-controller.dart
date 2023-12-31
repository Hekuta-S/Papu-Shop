import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddProductoController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProductoMetodo(
    String productoName,
    String categoriaId,
    String categoriaName,
    String precioCompleto,
    String precioVenta,
    List productoImg,
    String descripPro,
    bool enVenta,
  ) async {
    DocumentReference docRef = await _firestore.collection("productos").add({
      "productoName": productoName,
      "categoriaId": categoriaId,
      "createAt": DateTime.now(),
      "updateAt": DateTime.now(),
      "categoriaName": categoriaName,
      "enVenta": enVenta,
      "descripcionProducto": descripPro,
      "precioCompleto": precioCompleto,
      "precioVenta": precioVenta,
      "productoImg": productoImg,
    });
    String productoId = docRef.id;
    await docRef.update({"productoId": productoId});
  }

  Future<bool> checkProductoExistencia(String productoName) async {
    // Consultar la colección de productos para verificar si ya existe
    QuerySnapshot querySnapshot = await _firestore
        .collection("productos")
        .where("productoName", isEqualTo: productoName)
        .get();

    // Si hay documentos en la consulta, significa que el producto ya existe
    return querySnapshot.docs.isNotEmpty;
  }
}
