import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:booking_doctor_mobile/app/data/models/doctor_model.dart';
import 'package:booking_doctor_mobile/app/data/models/order_model.dart';
import 'package:booking_doctor_mobile/app/data/models/user_model.dart';

import '../controllers/admin_order_controller.dart';

class AdminOrderView extends GetView<AdminOrderController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pesanan'),
        
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
          final OrderModel data = OrderModel.fromJson(snapshots[index].data() as Map<String, dynamic>);

          return FutureBuilder(
            future: data.userId!.get(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }

              final docSnapshot = snapshot.data as DocumentSnapshot;
              final user = docSnapshot.data() != null
                  ? UserModel.fromJson(docSnapshot.data() as Map<String, dynamic>)
                  : null;

              return FutureBuilder(
                future: data.doctorId!.get(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  }

                  final docSnapshot = snapshot.data as DocumentSnapshot;
                  final doctor = docSnapshot.data() != null
                      ? DoctorModel.fromJson(docSnapshot.data() as Map<String, dynamic>)
                      : null;

                  return ListTile(
                    title: Text(user?.name ?? '-'),
                    subtitle: Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Dokter: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(14),
                            ),
                            children: [
                              TextSpan(
                                text: doctor?.name ?? '-',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(text: ' • ${data.status!.toUpperCase()}'),
                            ],
                          ),
                        ),
                        Spacer(),
                        Text(data.createdAt!.toDate().toString().split(' ')[0]),
                      ],
                    ),
                    onTap: () => Get.toNamed('/admin/orders/detail', arguments: snapshots[index].id),
                  );
                },
              );
            },
          );
        },
        onEmpty: Center(
          child: Text('Data Pesanan masih kosong'),
        ),
      ),
    );
  }
}
