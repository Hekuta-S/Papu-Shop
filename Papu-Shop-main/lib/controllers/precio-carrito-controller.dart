import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProductoPresionController extends GetxController {
  RxDouble totalPrecio = 0.0.obs;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    fetchProductosPrecio();
    super.onInit();
  }

  void fetchProductosPrecio() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('carrito')
        .doc(user!.uid)
        .collection('carritoOrdenes')
        .get();

    double sum = 0.0;

    for (final doc in snapshot.docs) {
      final data = doc.data();

      if (data != null && data.containsKey('precioTotalProducto')) {
        sum += (data['precioTotalProducto'] as num).toDouble();
      }
    }

    totalPrecio.value = sum;
  }
}
