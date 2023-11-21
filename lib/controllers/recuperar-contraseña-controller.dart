import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/screens/auth-ui/login-screen.dart';
import 'package:e_shop/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class RecuperarController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isPasswordVisible = false.obs;

  Future<void> RecuperarContraMetodo(
    String userEmail,
  ) async {
    try {
      EasyLoading.show(status: "Por favor espere");

      await _auth.sendPasswordResetEmail(email: userEmail);
      Get.snackbar(
        "Correo enviado correctamente",
        "Enlace de recuperacion enviado a $userEmail",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appSecondColor,
        colorText: AppConstant.appTextColor,
      );

      Get.offAll(() => LoginScreen());
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      //Get.snackbar(
      //"Error",
      //"$e",
      //snackPosition: SnackPosition.BOTTOM,
      //backgroundColor: AppConstant.appSecondColor,
      // colorText: AppConstant.appTextColor,
      //);
    }
  }
}
