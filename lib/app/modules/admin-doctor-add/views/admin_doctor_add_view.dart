import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../controllers/admin_doctor_add_controller.dart';

class AdminDoctorAddView extends GetView<AdminDoctorAddController> {
  @override
  Widget build(BuildContext context) {
    controller.fetchCategories();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Tambah Dokter'),
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 24.h,
          ),
          child: Column(
            children: [
              // field for photo
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.w,
                  vertical: 40.h,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Obx(
                        () => CircleAvatar(
                          radius: 45.w,
                          backgroundImage: controller.photo.value != null
                              ? FileImage(File(controller.photo.value!.path))
                              : null,
                          child: controller.photo.value == null ? Icon(Icons.person, size: 50.w) : null,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      // button for upload photo
                      ElevatedButton(onPressed: () => controller.pickImage(), child: Text('Upload Foto')),
                    ],
                  ),
                ),
              ),

              // field for name
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nama Dokter',
                  border: OutlineInputBorder(),
                ),
                validator: Validators.compose([
                  Validators.required("Nama Dokter tidak boleh kosong"),
                  Validators.maxLength(30, "Nama Dokter maksimal 30 karakter"),
                ]),
                onChanged: (value) => controller.name.value = value,
              ),
              SizedBox(height: 20.h),

              // field for category
              DropdownButtonHideUnderline(
                child: Obx(
                  () => DropdownButtonFormField<String>(
                    value: '',
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        child: Text('Pilih Kategori'),
                        value: '',
                      ),
                      ...controller.categoryIds.map((category) {
                        return DropdownMenuItem(
                          child: Text(category.category!.name!),
                          value: category.id!,
                        );
                      }).toList(),
                    ],
                    onChanged: (value) => controller.category.value = value ?? '',
                    validator: Validators.compose([
                      Validators.required("Kategori tidak boleh kosong"),
                    ]),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // button for submit
              Obx(
                () => ElevatedButton(
                  onPressed: controller.submitted.isTrue ? null : () => controller.submit(),
                  child: Text('Tambah Dokter'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50.h),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
