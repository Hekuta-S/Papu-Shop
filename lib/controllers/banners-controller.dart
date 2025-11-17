import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class bannerController extends GetxController {
  RxList<String> bannerUrls = RxList<String>([]);
  @override
  void onInit() {
    super.onInit();
    fetchBannersUrls();
  }

  Future<void> fetchBannersUrls() async {
    try {
      QuerySnapshot bannerSnapshot =
          await FirebaseFirestore.instance.collection('banners').get();

      if (bannerSnapshot.docs.isNotEmpty) {
        bannerUrls.value = bannerSnapshot.docs
            .map((doc) => doc['urlImagenes'] as String)
            .toList();
      }
    } catch (e) {
      print("error: $e");
    }
  }
}
