import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:booking_doctor_mobile/app/data/models/user_model.dart';

import '../controllers/admin_user_controller.dart';

class AdminUserView extends GetView<AdminUserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data User')),
      body: PaginateFirestore(
        itemBuilderType: PaginateBuilderType.listView,
        isLive: true,
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 13.h,
        ),
        query: controller.query,
        itemBuilder: (_, snapshots, index) {
          final UserModel data = UserModel.fromJson(snapshots[index].data() as Map<String, dynamic>);

          return ListTile(
            title: Text(data.name!),
            subtitle: Text(data.email!),
            onTap: () => Get.toNamed('/admin/users/edit', arguments: snapshots[index].id),
          );
        },
        onEmpty: Center(
          child: Text('Data User masih kosong'),
        ),
      ),
    );
  }
}
