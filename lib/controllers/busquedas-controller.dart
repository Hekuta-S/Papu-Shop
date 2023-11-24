import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ...

Future<List<Map<String, dynamic>>> obtenerDatosCarritos(String userId) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('carrito')
        .doc(userId)
        .collection('carritoOrdenes')
        .get();

    List<Map<String, dynamic>> listaDatos = [];

    querySnapshot.docs.forEach((documento) {
      Map<String, dynamic> datos = {
        'productoName': documento['productoName'],
        'cantidadProducto': documento['cantidadProducto'],
      };

      listaDatos.add(datos);
    });

    return listaDatos;
  } catch (e) {
    print('Error al obtener datos del carrito: $e');

    return [];
  }
}

Widget encontrarNombrePorId(String userId) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('usuarios')
          .doc(userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String ciudad = '';
          if (snapshot.data == null ||
              snapshot.data!.data()!['username'] == null) {
            ciudad = 'Sin Nombre';
          } else {
            ciudad = snapshot.data!.data()!['username'];
          }
          return RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: "Facturado a: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ciudad,
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: "Facturado a: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'Ha ocurrido un error',
                ),
              ],
            ),
          );
        } else {
          return Text('');
        }
      });
}

Widget encontrarDireccionPorId(String userId) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('usuarios')
          .doc(userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String ciudad = '';
          if (snapshot.data == null || snapshot.data!.data()!['city'] == null) {
            ciudad = 'Sin ciudad';
          } else {
            ciudad = snapshot.data!.data()!['city'];
          }
          return RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: "Enviar a: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ciudad,
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: "Enviar a: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'Ha ocurrido un error',
                ),
              ],
            ),
          );
        } else {
          return Text('');
        }
      });

  // try {

  //   DocumentSnapshot userDocument = await FirebaseFirestore.instance
  //       .collection('usuarios')
  //       .doc(userId)
  //       .get();

  //   // Verificar si el documento existe
  //   if (userDocument.exists) {
  //     // Obtener el valor del campo 'username'
  //     String? direccion = userDocument['city'];
  //     return TextSpan(text: direccion);
  //   } else {
  //     // El documento no existe
  //     print('No se encontró el usuario con ID: $userId');
  //     return TextSpan();
  //   }
  // } catch (e) {
  //   // Manejar el error según tus necesidades
  //   print('Error al buscar el usuario: $e');
  //   return null;
  // }
}
