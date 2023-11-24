import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UpdateProductoController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateProductoMetodo(
    String productoId,
    String newProductoName,
    String newCategoriaId,
    String newCategoriaName,
    String newPrecioCompleto,
    String newPrecioVenta,
    List newProductoImg,
    String newDescripPro,
    bool newEnVenta,
  ) async {
    await _firestore.collection("productos").doc(productoId).update({
      "productoName": newProductoName,
      "categoriaId": newCategoriaId,
      "updateAt": DateTime.now(),
      "categoriaName": newCategoriaName,
      "enVenta": newEnVenta,
      "descripcionProducto": newDescripPro,
      "precioCompleto": newPrecioCompleto,
      "precioVenta": newPrecioVenta,
      "productoImg": newProductoImg,
    });
  }
}
