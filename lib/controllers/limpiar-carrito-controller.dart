import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> eliminarProductos(String idCarrito) async {
  try {
    // Acceder a la colección "carritoOrdenes" dentro del documento del carrito
    CollectionReference carritoOrdenesCollection = FirebaseFirestore.instance
        .collection('carrito')
        .doc(idCarrito)
        .collection('carritoOrdenes');

    // Eliminar todos los documentos en la colección "carritoOrdenes"
    await carritoOrdenesCollection.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });

    print('Productos eliminados con éxito');
  } catch (e) {
    print('Error al eliminar productos: $e');
  }
}
