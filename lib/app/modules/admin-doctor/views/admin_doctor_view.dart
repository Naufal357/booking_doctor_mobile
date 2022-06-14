import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:pesandokter/app/data/models/category_model.dart';
import 'package:pesandokter/app/data/models/doctor_model.dart';

import '../controllers/admin_doctor_controller.dart';

class AdminDoctorView extends GetView<AdminDoctorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Dokter')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/admin/doctors/add');
        },
        child: Icon(Icons.add),
      ),
      body: PaginateFirestore(
        itemBuilderType: PaginateBuilderType.listView,
        isLive: true,
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 13.h,
        ),
        query: controller.query,
        itemBuilder: (_, snapshots, index) {
          final DoctorModel data = DoctorModel.fromJson(snapshots[index].data() as Map<String, dynamic>);
          return FutureBuilder(
            future: data.category!.get(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                final docSnapshot = snapshot.data as DocumentSnapshot;
                final category = docSnapshot.data() != null
                    ? CategoryModel.fromJson(docSnapshot.data() as Map<String, dynamic>)
                    : null;

                return ListTile(
                  title: Text(data.name!),
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(data.photoUrl!),
                  ),
                  subtitle: Text(category?.name ?? '-'),
                  onTap: () => Get.toNamed('/admin/doctors/edit', arguments: snapshots[index].id),
                );
              }

              return Container();
            },
          );
        },
        onEmpty: Center(
          child: Text('Data Dokter masih kosong'),
        ),
      ),
    );
  }
}
