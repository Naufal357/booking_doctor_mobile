import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/admin_user_edit_controller.dart';

class AdminUserEditView extends GetView<AdminUserEditController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail User'),
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
                          labelText: 'Nama User',
                          border: OutlineInputBorder(),
                        ),
                        enabled: false,
                      ),
                      SizedBox(height: 20.h),
                      // field for description
                      TextFormField(
                        initialValue: controller.email.value,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        enabled: false,
                      ),
                      SizedBox(height: 16.h),
                      // button for delete
                      ElevatedButton(
                        onPressed: () => controller.delete(),
                        child: Text('Hapus User'),
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
