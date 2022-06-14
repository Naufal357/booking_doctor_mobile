import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:booking_doctor_mobile/app/data/models/doctor_model.dart';
import 'package:booking_doctor_mobile/app/modules/home/controllers/home_controller.dart';

import '../../../data/models/order_model.dart';

class HomeView extends GetView {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 25.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
              ),
              children: [
                TextSpan(
                  text: 'Selamat datang, ',
                ),
                TextSpan(
                  text: controller.user.value!.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: Center(
                child: StreamBuilder<QuerySnapshot>(
              stream: controller.queryStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isNotEmpty) {
                    snapshot.data!.docs[0].data();
                    final orderData =
                        OrderModel.fromJson(snapshot.data!.docs[0].data() as Map<String, dynamic>);
                    final numberQueue = orderData.number;

                    return FutureBuilder(
                      future: orderData.doctorId!.get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final doctorData = snapshot.data as DocumentSnapshot;
                          final doctorModel = DoctorModel.fromJson(doctorData.data() as Map<String, dynamic>);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(color: Colors.grey.shade600, fontSize: 16.sp),
                                  children: [
                                    TextSpan(
                                      text: "Anda telah memesan ",
                                    ),
                                    TextSpan(
                                      text: doctorModel.name,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: " dengan nomer antrian berikut",
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                numberQueue.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                "Silahkan menunggu konfirmasi dari admin",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade600),
                              ),
                            ],
                          );
                        }

                        return Container();
                      },
                    );
                  }
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                return _EmptyQueueState();
              },
            )),
          ),
        ],
      ),
    );
  }
}

class _EmptyQueueState extends StatelessWidget {
  const _EmptyQueueState({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Anda belum memesan dokter apapun, silahkan memesan dokter terlebih dahulu.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade600),
        ),
        SizedBox(height: 20.h),
        ElevatedButton(
          onPressed: () => Get.toNamed('/category'),
          child: Text("Pesan Dokter"),
        ),
      ],
    );
  }
}
