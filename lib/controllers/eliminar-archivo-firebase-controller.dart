import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> borrarDocument(String collectionName, String documentId) async {
    try {
      final existingDocument =
          await _firestore.collection(collectionName).doc(documentId).get();

      if (existingDocument.exists) {
        await _firestore.collection(collectionName).doc(documentId).delete();
        print(
            "Documento con ID $documentId eliminado de $collectionName exitosamente.");
      } else {
        print(
            "El documento con ID $documentId no existe en $collectionName. No se puede eliminar.");
      }
    } catch (error) {
      print("Error al eliminar el documento: $error");
    }
  }
}
