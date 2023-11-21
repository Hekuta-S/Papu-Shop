import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddCategoriaController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCategoriaMetodo(
    String categoriaName,
    String categoriaImg,
  ) async {
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
