import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../controllers/admin_doctor_edit_controller.dart';

class AdminDoctorEditView extends GetView<AdminDoctorEditController> {
  @override
  Widget build(BuildContext context) {
    controller.fetchData();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Edit Dokter'),
      ),
      body: Obx(
        () => controller.loading.isTrue
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Form(
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
                                  backgroundImage: controller.photo.value == null
                                      ? CachedNetworkImageProvider(controller.data.value.photoUrl!)
                                      : FileImage(File(controller.photo.value!.path)) as ImageProvider,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              // button for upload photo
                              ElevatedButton(
                                  onPressed: () => controller.pickImage(), child: Text('Upload Foto')),
                            ],
                          ),
                        ),
                      ),

                      // field for name
                      TextFormField(
                        initialValue: controller.data.value.name,
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
                            value: controller.category.value,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(),
                              border: OutlineInputBorder(),
                            ),
                            items: [
                              DropdownMenuItem(
                                child: Text('Pilih Kategori'),
                                value: '',
                              ),
                              ...controller.categories.map((category) {
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
                          child: Text('Edit Dokter'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50.h),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),

                      // Button for delete
                      ElevatedButton(
                        onPressed: () => controller.delete(),
                        child: Text('Hapus Dokter'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50.h),
                          primary: Colors.red,
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
