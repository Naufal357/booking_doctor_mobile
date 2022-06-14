import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../controllers/admin_category_edit_controller.dart';

class AdminCategoryEditView extends GetView<AdminCategoryEditController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Kategori'),
      ),
      body: Obx(
        () => controller.loading.isTrue
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
                        initialValue: controller.name.value,
                        decoration: InputDecoration(
                          labelText: 'Nama Kategori',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => controller.name.value = value,
                        validator: Validators.compose([
                          Validators.required("Nama Kategori tidak boleh kosong"),
                          Validators.maxLength(30, "Nama Kategori maksimal 30 karakter"),
                        ]),
                      ),
                      SizedBox(height: 20.h),
                      // field for description
                      TextFormField(
                        initialValue: controller.description.value,
                        decoration: InputDecoration(
                          labelText: 'Deskripsi Kategori',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => controller.description.value = value,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        validator: Validators.compose([
                          Validators.required("Deskripsi tidak boleh kosong"),
                          Validators.maxLength(60, "Deskripsi maksimal 60 karakter"),
                        ]),
                      ),
                      SizedBox(height: 16.h),
                      // button for submit
                      Obx(
                        () => ElevatedButton(
                          onPressed: controller.submitted.isTrue ? null : () => controller.edit(),
                          child: Text('Edit Kategori'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50.h),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      // button for delete
                      ElevatedButton(
                        onPressed: () => controller.delete(),
                        child: Text('Hapus Kategori'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          minimumSize: Size(double.infinity, 50.h),
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
