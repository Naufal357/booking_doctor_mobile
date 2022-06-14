import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../../data/models/category_model.dart';
import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pilih Kategori Dokter')),
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
            onTap: () => Get.toNamed('/doctor', arguments: snapshots[index].reference),
          );
        },
        onEmpty: Center(
          child: Text('Kategori Dokter masih kosong'),
        ),
      ),
    );
  }
}
