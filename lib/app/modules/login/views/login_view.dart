import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.loading.isTrue ? CircularProgressIndicator() : _LoginForm(),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  final LoginController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FlutterLogo(size: 100),
          SizedBox(height: 40.h),
          Padding(
            padding: EdgeInsets.all(18.w),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: Validators.compose([
                      Validators.required("Email tidak boleh kosong"),
                      Validators.email("Email tidak valid"),
                    ]),
                    onChanged: (value) => controller.email.value = value,
                  ),
                  SizedBox(height: 20.h),
                  Obx(
                    () => TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.showPassword.value ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () => controller.showPassword.value = !controller.showPassword.value,
                        ),
                      ),
                      obscureText: controller.showPassword.isFalse,
                      validator: Validators.compose([
                        Validators.required("Password tidak boleh kosong"),
                      ]),
                      onChanged: (value) => controller.password.value = value,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Obx(
                    () => ElevatedButton(
                      onPressed: controller.submitted.isTrue ? null : () => controller.login(),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(Get.width, 60.h),
                      ),
                      child: Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.h),
            child: GestureDetector(
              onTap: () => Get.toNamed('/register'),
              child: Text(
                'Belum punya akun?',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
