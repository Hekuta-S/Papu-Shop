import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../utils/app-constant.dart';

class AddCategoriaController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCategoriaMetodo(
    String categoriaName,
    String categoriaImg,
  ) async {
    // Verificar si el nombre de la categoría ya existe
    bool categoriaExists = await checkCategoriaExistencia(categoriaName);

    if (categoriaExists) {
      // Puedes manejar la lógica aquí si la categoría ya existe

      Get.snackbar(
        "Nombre de categoria ya existente.",
        "             :(.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appSecondColor,
        colorText: AppConstant.appTextColor,
      );
    } else {
      // Si la categoría no existe, agregarla
      DocumentReference docRef = await _firestore.collection("categorias").add({
        "categoriaName": categoriaName,
        "categoriaImg": categoriaImg,
        "createAt": DateTime.now(),
        "updateAt": DateTime.now(),
      });
      String categoriaId = docRef.id;
      await docRef.update({"categoriaId": categoriaId});
    }
  }

  Future<bool> checkCategoriaExistencia(String categoriaName) async {
    // Consultar la colección de categorías para verificar si ya existe
    QuerySnapshot querySnapshot = await _firestore
        .collection("categorias")
        .where("categoriaName", isEqualTo: categoriaName)
        .get();

    // Si hay documentos en la consulta, significa que la categoría ya existe
    return querySnapshot.docs.isNotEmpty;
  }
}
