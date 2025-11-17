import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UpdateCategoriaController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addOrUpdateCategoriaMetodo(
    String categoriaId,
    String categoriaName,
    String categoriaImg,
  ) async {
    // Verificar si la categoría ya existe en la base de datos
    final existingCategoria =
        await _firestore.collection("categorias").doc(categoriaId).get();

    if (existingCategoria.exists) {
      await _firestore.collection("categorias").doc(categoriaId).update({
        "categoriaName": categoriaName,
        "categoriaImg": categoriaImg,
        "updateAt": DateTime.now(),
      });
    } else {
      await _firestore.collection("categorias").doc(categoriaId).set({
        "categoriaName": categoriaName,
        "categoriaImg": categoriaImg,
        "updateAt": DateTime.now(),
      });
    }
  }
}
