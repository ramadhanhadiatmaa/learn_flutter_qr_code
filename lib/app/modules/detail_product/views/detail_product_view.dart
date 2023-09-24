import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code/app/data/models/product_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/detail_product_controller.dart';

class DetailProductView extends GetView<DetailProductController> {
  DetailProductView({Key? key}) : super(key: key);

  final ProductModel product = Get.arguments;

  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    codeC.text = product.code;
    nameC.text = product.name;
    qtyC.text = "${product.quantity}";

    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Product'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(
            20,
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: QrImageView(
                    data: product.productId,
                    version: QrVersions.auto,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: false,
              controller: codeC,
              keyboardType: TextInputType.number,
              maxLength: 10,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: "Product Code",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: false,
              controller: nameC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: "Product Name",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: false,
              controller: qtyC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: "Quantity",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.isLoadingUpdate.isFalse) {
                  if (nameC.text.isNotEmpty && qtyC.text.isNotEmpty) {
                    controller.isLoadingUpdate(true);
                    Map<String, dynamic> hasil = await controller.editProduct({
                      "id": product.productId,
                      "name": nameC.text,
                      "quantity": int.tryParse(qtyC.text) ?? 0,
                    });
                    controller.isLoadingUpdate(false);

                    Get.snackbar(
                      hasil["error"] == true ? "Error" : "Success",
                      hasil["message"],
                      duration: const Duration(
                        seconds: 2,
                      ),
                    );
                  } else {
                    Get.snackbar(
                      "Error",
                      "Data tidak boleh kosong",
                      duration: const Duration(
                        seconds: 2,
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              child: Obx(
                () => Text(controller.isLoadingUpdate.isFalse
                    ? 'UPDATE PRODUCT'
                    : 'PROCESS...'),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.defaultDialog(
                    title: "Delete Product",
                    middleText: "Are you sure to delete this product?",
                    actions: [
                      OutlinedButton(
                        onPressed: () => Get.back(),
                        child: const Text("CANCEL"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          controller.isLoadingDelete(true);
                          Map<String, dynamic> hasil =
                              await controller.deleteProduct(product.productId);
                          controller.isLoadingDelete(false);

                          Get.back();
                          Get.back();

                          Get.snackbar(
                            hasil["error"] == true ? "Error" : "Success",
                            hasil["message"],
                            duration: const Duration(
                              seconds: 2,
                            ),
                          );
                        },
                        child: Obx(
                          () => controller.isLoadingDelete.isFalse
                              ? const Text("DELETE")
                              : Container(
                                  padding: const EdgeInsets.all(2),
                                  height: 15,
                                  width: 15,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 1,
                                  ),
                                ),
                        ),
                      ),
                    ]);
              },
              child: Text(
                "Delete Product",
                style: TextStyle(
                  color: Colors.red.shade900,
                ),
              ),
            ),
          ],
        ));
  }
}
