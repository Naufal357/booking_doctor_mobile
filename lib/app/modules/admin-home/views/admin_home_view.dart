import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/admin_home_controller.dart';

class AdminHomeView extends GetView<AdminHomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda Admin'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.sp,
          vertical: 24.sp,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat datang di Menu Admin',
                      style: TextStyle(
                        fontSize: 23.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ListTile(
                      title: Text('Data User'),
                      subtitle: Text('Lihat data user yang telah terdaftar'),
                      leading: Icon(Icons.people),
                      onTap: () {
                        Get.toNamed('/admin/users');
                      },
                      tileColor: Colors.grey.shade300,
                    ),
                    SizedBox(height: 10.h),
                    ListTile(
                      title: Text('Data Dokter'),
                      subtitle: Text('Lihat dan atur semua data dokter'),
                      leading: Icon(Icons.local_hospital),
                      onTap: () {
                        Get.toNamed('/admin/doctors');
                      },
                      tileColor: Colors.grey.shade300,
                    ),
                    SizedBox(height: 10.h),
                    ListTile(
                      title: Text('Data Kategori'),
                      subtitle: Text('Lihat dan atur semua kategori dokter'),
                      leading: Icon(Icons.category),
                      onTap: () {
                        Get.toNamed('/admin/categories');
                      },
                      tileColor: Colors.grey.shade300,
                    ),
                    SizedBox(height: 10.h),
                    ListTile(
                      title: Text('Data Semua Pesanan'),
                      subtitle: Text('Lihat riwayat pesanan pelanggan'),
                      leading: Icon(Icons.list),
                      onTap: () {
                        Get.toNamed('/admin/orders');
                      },
                      tileColor: Colors.grey.shade300,
                    ),
                    SizedBox(height: 10.h),
                    ListTile(
                      title: Text('Data Antrian'),
                      subtitle: Text('Lihat dan atur antrian pesanan'),
                      leading: Icon(Icons.queue),
                      onTap: () {
                        Get.toNamed('/admin/queues');
                      },
                      tileColor: Colors.grey.shade300,
                    ),
                  ],
                ),
              ),
            ),
            // logout button
            ElevatedButton(
              onPressed: () => controller.logout(),
              child: Text('Logout'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                  vertical: 15.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
