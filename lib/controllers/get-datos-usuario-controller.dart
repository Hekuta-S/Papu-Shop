import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GetDatosUserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Object?>>> getUserData(String uId) async {
    final QuerySnapshot userDatos = await _firestore
        .collection('usuarios')
        .where('uId', isEqualTo: uId)
        .get();

    return userDatos.docs;
  }
}
