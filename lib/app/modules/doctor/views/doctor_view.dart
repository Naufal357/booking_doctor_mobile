import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../../data/models/category_model.dart';
import '../../../data/models/doctor_model.dart';
import '../controllers/doctor_controller.dart';

class DoctorView extends GetView<DoctorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pilih Dokter')),
      body: PaginateFirestore(
        itemBuilderType: PaginateBuilderType.listView,
        isLive: true,
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 13.h,
        ),
        query: controller.getQuery,
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
                  onTap: () => Get.toNamed('/order', arguments: snapshots[index].reference),
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
