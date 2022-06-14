import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/snackbar.dart';

class AdminQueueController extends GetxController {
  final query =
      FirebaseFirestore.instance.collection('orders').where('status', isEqualTo: 'pending').orderBy('number');

  void resetCounter() async {
    Get.defaultDialog(
      title: 'Reset Nomer Antrian',
      middleText: 'Apakah anda yakin ingin mereset nomer antrian?',
      textConfirm: 'Ya',
      onConfirm: () async {
        // update the counter
        await FirebaseFirestore.instance.collection('options').doc('1').update({'counter': 1});
        Get.back();

        SnackbarUtil.show(
          'Berhasil',
          'Nomer antrian telah direset'
        );
      },
      textCancel: 'Tidak',
    );
  }
}
