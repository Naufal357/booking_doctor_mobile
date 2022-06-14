import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:booking_doctor_mobile/app/data/models/category_model.dart';

import '../controllers/admin_category_controller.dart';

class AdminCategoryView extends GetView<AdminCategoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Kategori')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/admin/categories/add');
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
        query: controller.categoryQuery,
        itemBuilder: (_, snapshots, index) {
          final CategoryModel data = CategoryModel.fromJson(snapshots[index].data() as Map<String, dynamic>);

          return ListTile(
            title: Text(data.name!),
            subtitle: Text(
              data.description!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () => Get.toNamed('/admin/categories/edit', arguments: snapshots[index].id),
          );
        },
        onEmpty: Center(
          child: Text('Data Kategori masih kosong'),
        ),
      ),
    );
  }
}
