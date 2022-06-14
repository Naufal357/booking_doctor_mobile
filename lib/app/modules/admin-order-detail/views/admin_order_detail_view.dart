import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/admin_order_detail_controller.dart';

class AdminOrderDetailView extends GetView<AdminOrderDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Order'),
      ),
      body: Obx(
        () => controller.order.value == null
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
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(text: 'Nomer Antrian: '),
                              TextSpan(
                                text: controller.order.value?.number.toString() ?? "-",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),

                        Text("Data Pemesan"),
                        SizedBox(height: 20.h),

                        // field for name
                        TextFormField(
                          initialValue: controller.user.value?.name ?? "-",
                          decoration: InputDecoration(
                            labelText: 'Nama',
                            border: OutlineInputBorder(),
                          ),
                          enabled: false,
                        ),
                        SizedBox(height: 20.h),

                        // field for email
                        TextFormField(
                          initialValue: controller.user.value?.email ?? "-",
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          enabled: false,
                        ),
                        SizedBox(height: 20.h),

                        SizedBox(height: 20.h),
                        Text("Data Dokter"),
                        SizedBox(height: 20.h),

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

                        // status
                        Text("Status"),
                        SizedBox(height: 20.h),
                        controller.order.value!.status == 'selesai'
                            ? _StatusSuccessWidget()
                            : _StatusFailWidget()
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class _StatusSuccessWidget extends StatelessWidget {
  const _StatusSuccessWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 40.w,
        vertical: 20.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.green,
      ),
      child: Center(child: Text("Selesai".capitalizeFirst!, style: TextStyle(color: Colors.white))),
    );
  }
}

class _StatusFailWidget extends StatelessWidget {
  const _StatusFailWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 40.w,
        vertical: 20.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.red,
      ),
      child: Center(child: Text("Batal".capitalizeFirst!, style: TextStyle(color: Colors.white))),
    );
  }
}
