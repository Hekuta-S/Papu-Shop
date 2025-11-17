import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/models/usuario_model.dart';
import 'package:e_shop/screens/user-panel/main-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleInicioSesionController extends GetxController {
//  final GoogleSignIn googleSignIn = GoogleSignIn();

//   final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> inicioSesionConGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final FirebaseAuth _auth = FirebaseAuth.instance;
      // ignore: unused_local_variable
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        EasyLoading.show(status: "Por favor espere...");
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        final User? user = userCredential.user;

        if (user != null) {
          UsuarioModel usuarioModel = UsuarioModel(
            uId: user.uid,
            username: user.displayName.toString(),
            email: user.email.toString(),
            phone: user.phoneNumber.toString(),
            userImg: user.photoURL.toString(),
            userDeviceToken: '',
            country: '',
            userAddress: '',
            street: '',
            isAdmin: false,
            isActive: true,
            createdOn: DateTime.now(),
            city: '',
          );
          await FirebaseFirestore.instance
              .collection('usuarios')
              .doc(user.uid)
              .set(usuarioModel.toMap());
          EasyLoading.dismiss();
          Get.offAll(() => const MainScreen());
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      print("error $e");
    }
  }
}
