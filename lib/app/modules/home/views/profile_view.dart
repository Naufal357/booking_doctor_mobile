import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:booking_doctor_mobile/app/modules/home/controllers/home_controller.dart';

class ProfileView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // field for photo
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 40.h,
            ),
            child: Center(
              child: Column(
                children: [
                  // Photo, name, and email
                  CircleAvatar(
                    radius: 45.w,
                    child: Icon(Icons.person, size: 50.w),
                  ),
                  SizedBox(height: 20.h),
                  Obx(
                    () => Text(
                      controller.user.value?.name ?? "-",
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Obx(
                    () => Text(
                      controller.user.value?.email ?? "-",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                  ),

                  // ListTiles
                  SizedBox(height: 40.h),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Edit Profile'),
                    onTap: () => Get.toNamed('/profile/edit'),
                  ),
                  ListTile(
                    leading: Icon(Icons.history),
                    title: Text('Riwayat Pesanan'),
                    onTap: () => Get.toNamed('/order/history'),
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Keluar'),
                    onTap: () => controller.logout(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
