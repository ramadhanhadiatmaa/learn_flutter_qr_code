import 'package:get/get.dart';

class AddProductController extends GetxController {
  RxBool isLoading = false.obs;

  Future<Map<String, dynamic>> addProduct(Map<String, dynamic> data) async {
    try {
      return {
        "error": false,
        "message": "Berhasil menambah produk.",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Tidak dapat menambah produk.",
      };
    }
  }
}
