// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_shop/controllers/add-producto-controller.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:get/get.dart';

// // Importa tu controlador

// // Crea un mock de FirebaseFirestore
// class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

// void main() {
//   group('AddProductoController', () {
//     late AddProductoController addProductoController;
//     late MockFirebaseFirestore mockFirestore;

//     setUp(() {
//       mockFirestore = MockFirebaseFirestore();
//       addProductoController = AddProductoController();
//       // Reemplaza la instancia de FirebaseFirestore con el mock
//       addProductoController._firestore = mockFirestore;
//     });

//     test('addProductoMetodo agrega un producto correctamente', () async {
//       // Configura el mock para simular una operación exitosa de agregar un documento
//       when(mockFirestore.collection("productos").add(any))
//           .thenAnswer((_) async => DocumentReference(FakeFirestoreInstance(), []));

//       // Llama a la función que quieres probar
//       await addProductoController.addProductoMetodo(
//         "Producto1",
//         "Categoria1",
//         "CategoriaName1",
//         "Completo",
//         "Venta",
//         ["imagen1"],
//         "Descripción",
//         true,
//       );

//       // Verifica que la función haya interactuado correctamente con el Firestore
//       verify(mockFirestore.collection("productos").add(any)).called(1);
//     });

//     test('checkProductoExistencia retorna true para un producto existente', () async {
//       // Configura el mock para simular la existencia de un documento
//       when(mockFirestore.collection("productos").where("productoName", isEqualTo: "Producto1").get())
//           .thenAnswer((_) async => QuerySnapshot(FakeFirestoreInstance(), []));

//       // Llama a la función que quieres probar
//       bool existe = await addProductoController.checkProductoExistencia("Producto1");

//       // Verifica que la función haya interactuado correctamente con el Firestore
//       verify(mockFirestore.collection("productos").where("productoName", isEqualTo: "Producto1").get()).called(1);

//       // Verifica que la función haya devuelto el resultado esperado
//       expect(existe, isTrue);
//     });

//     test('checkProductoExistencia retorna false para un producto no existente', () async {
//       // Configura el mock para simular la no existencia de un documento
//       when(mockFirestore.collection("productos").where("productoName", isEqualTo: "Producto2").get())
//           .thenAnswer((_) async => QuerySnapshot(FakeFirestoreInstance(), [DocumentSnapshot(FakeFirestoreInstance(), 'documentId')]));

//       // Llama a la función que quieres probar
//       bool existe = await addProductoController.checkProductoExistencia("Producto2");

//       // Verifica que la función haya interactuado correctamente con el Firestore
//       verify(mockFirestore.collection("productos").where("productoName", isEqualTo: "Producto2").get()).called(1);

//       // Verifica que la función haya devuelto el resultado esperado
//       expect(existe, isFalse);
//     });
//   });
// }

// // Clase utilitaria para simular un objeto Firestore falso
// class FakeFirestoreInstance extends Fake implements FirebaseFirestore {}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/controllers/add-categoria-controller.dart';
import 'package:e_shop/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

// prueba() {
//   return true;
// }

void main() {
  //Eliminando la categoria con datos correctos
  test("prueba eliminar categoria", () {
    var fakeDeletedController = FakeDeleteController();
    var resultado =
        fakeDeletedController.borrarDocument("categorias", "1234sfasjakj");

    expect(true, resultado);
  });

  test("prueba eliminar categoria con parametro vacio ", () {
    var fakeDeletedController = FakeDeleteController();
    var resultado = fakeDeletedController.borrarDocument("categorias", '');

    expect(false, resultado);
  });

  test("prueba add categoria con parametro vacio", () {
    var fakeAddcategoria = FakeAddCategoriaController();
    var resultado =
        fakeAddcategoria.addCategoriaMetodo("Animes Tools", '', true);

    expect(false, resultado);
  });
  test("prueba add categoria cuando nombre no cumple parametros", () {
    var fakeAddcategoria = FakeAddCategoriaController();
    var resultado = fakeAddcategoria.addCategoriaMetodo(
        "cate", 'BINGdfsjd45465456sadjsafjhiimg=0', false);

    expect(false, resultado);
  });

  test("prueba integracion add producto cuando nombre no cumple validaciones",
      () {
    var fakeAddProductoController = FakeAddProductoController();
    var resultado = fakeAddProductoController.addProductoMetodo(
        "camisa",
        "Gdfsjd45465456sa",
        "Gorros de lana",
        "10000",
        "5000",
        "BINGdfsjd45465456sadjsafjhiimg=0",
        "Muy comodo y sirve mucho para el frio",
        true,
        false);

    expect(false, resultado);
  });
}

class FakeAddCategoriaController {
  bool addCategoriaMetodo(
      String categoriaName, String categoriaImg, bool categoriaExists) {
    // Verificar si el nombre de la categoría ya existe

    if (categoriaExists == true) {
      //si el nombre de la categoria existe, no se puede agregar

      return false;
    } else if (categoriaName == "" ||
        categoriaName.length < 10 ||
        categoriaName.length > 30 ||
        categoriaImg == "") {
      // Si la categoría no existe, y cumple con las validaciones, agregarla
      return false;
    }
    return true;
  }
}

class FakeDeleteController {
  bool borrarDocument(String collectionName, String documentId) {
    try {
      if (collectionName != null && documentId != null && documentId != '') {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}

class FakeAddProductoController {
  bool addProductoMetodo(
    String productoName,
    String categoriaId,
    String categoriaName,
    String precioCompleto,
    String precioVenta,
    String productoImg,
    String descripPro,
    bool enVenta,
    bool exist,
  ) {
    if (productoName.length < 10 ||
        productoName.length > 30 ||
        categoriaId == "0" ||
        categoriaName == "" ||
        precioCompleto.length < 4 ||
        precioVenta.length < 4 ||
        productoImg == "" ||
        descripPro.length < 10 ||
        descripPro.length > 100) {
      return false;
    } else if (exist == true) {
      return false;
    }
    return true;
  }
}
