import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
                          labelText: 'Nama',
                          border: OutlineInputBorder(),
                        ),
                        validator: Validators.compose([
                          Validators.required("Nama tidak boleh kosong"),
                          Validators.minLength(3, "Nama minimal 3 karakter"),
                          Validators.maxLength(20, "Nama maksimal 20 karakter"),
                        ]),
                        onChanged: (value) => controller.name.value = value,
                      ),
                      SizedBox(height: 20.h),
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
                            Validators.minLength(6, "Password minimal 6 karakter"),
                            Validators.maxLength(20, "Password maksimal 20 karakter"),
                          ]),
                          onChanged: (value) => controller.password.value = value,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Obx(
                        () => ElevatedButton(
                          onPressed: controller.submitted.isTrue ? null : () => controller.register(),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(Get.width, 60.h),
                          ),
                          child: Text('Daftar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.h),
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Text(
                    'Sudah punya akun?',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
