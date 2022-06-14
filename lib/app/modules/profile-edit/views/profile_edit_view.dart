import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../controllers/profile_edit_controller.dart';

class ProfileEditView extends GetView<ProfileEditController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profil'),
      ),
      body: Obx(
        () => controller.user.value == null
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 24.h,
                ),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // field for name
                      TextFormField(
                        initialValue: controller.user.value?.name ?? "-",
                        decoration: InputDecoration(
                          labelText: 'Nama',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => controller.user.value?.name = value,
                        validator: Validators.compose([
                          Validators.required("Nama tidak boleh kosong"),
                          Validators.maxLength(30, "Nama maksimal 30 karakter"),
                        ]),
                      ),
                      SizedBox(height: 20.h),

                      // field for email
                      TextFormField(
                        initialValue: controller.user.value?.email ?? "-",
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => controller.user.value?.email = value,
                        validator: Validators.compose([
                          Validators.email("Email tidak valid"),
                          Validators.required("Email tidak boleh kosong"),
                        ]),
                      ),
                      SizedBox(height: 20.h),

                      // button for submit
                      Obx(
                        () => ElevatedButton(
                          onPressed: controller.submitted.isTrue ? null : () => controller.submit(),
                          child: Text('Edit'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50.h),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
