import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  @override
  Widget build(BuildContext context) {
    controller.fetchData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Dokter'),
      ),
      body: Obx(
        () => controller.doctor.value == null
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 24.h,
                ),
                child: Form(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // field for photo
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.w,
                            vertical: 40.h,
                          ),
                          child: Center(
                            child: CircleAvatar(
                              radius: 45.w,
                              backgroundImage: CachedNetworkImageProvider(
                                controller.doctor.value?.photoUrl ??
                                    "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // field for doctor name
                        TextFormField(
                          initialValue: controller.doctor.value?.name ?? "-",
                          decoration: InputDecoration(
                            labelText: 'Nama Dokter',
                            border: OutlineInputBorder(),
                          ),
                          enabled: false,
                        ),
                        SizedBox(height: 20.h),

                        // field for doctor category
                        TextFormField(
                          initialValue: controller.category.value?.name ?? "-",
                          decoration: InputDecoration(
                            labelText: 'Kategori',
                            border: OutlineInputBorder(),
                          ),
                          enabled: false,
                        ),
                        SizedBox(height: 20.h),

                        // Order Button
                        ElevatedButton(
                          onPressed: () => controller.order(),
                          child: Text("Pesan Dokter"),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50.h),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
