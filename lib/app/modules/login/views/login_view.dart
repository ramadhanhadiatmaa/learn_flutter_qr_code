import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code/app/controllers/auth_controller.dart';
import 'package:qr_code/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController emailC = TextEditingController(
    text: "admin123@gmail.com",
  );

  final TextEditingController passC = TextEditingController(
    text: "admin123",
  );

  final AuthController authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            TextField(
              autocorrect: false,
              controller: emailC,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: "Email",
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Obx(
              () => TextField(
                autocorrect: false,
                controller: passC,
                obscureText: controller.isHidden.value,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.isHidden.toggle();
                    },
                    icon: Icon(
                      controller.isHidden.isFalse
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
                    controller.isLoading(true);
                    Map<String, dynamic> hasil =
                        await authC.login(emailC.text, passC.text);
                    controller.isLoading(false);

                    if (hasil["error"] == true) {
                      Get.snackbar("Error", hasil["message"]);
                    } else {
                      Get.offAllNamed(Routes.home);
                    }
                  } else {
                    Get.snackbar("Error", "Email dan password wajib diisi.");
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
                () =>
                    Text(controller.isLoading.isFalse ? 'LOGIN' : 'PROCESS...'),
              ),
            ),
          ],
        ));
  }
}
