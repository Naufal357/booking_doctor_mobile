import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_doctor_mobile/app/data/models/user_model.dart';
import 'package:booking_doctor_mobile/app/modules/home/controllers/home_controller.dart';

import '../../../utils/snackbar.dart';

class ProfileEditController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final Rxn<UserModel> user = Rxn<UserModel>();
  final RxBool submitted = false.obs;
  final Rxn<DocumentReference> userRef = Rxn<DocumentReference>();

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  void fetchUser() async {
    final email = FirebaseAuth.instance.currentUser!.email;
    final snapshot =
        await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get();
    userRef.value = snapshot.docs[0].reference;

    user.value = UserModel.fromJson(snapshot.docs[0].data());
  }

  void submit() async {
    if (formKey.currentState!.validate()) {
      submitted.toggle();

      // update email
      try {
        await FirebaseAuth.instance.currentUser!.updateEmail(user.value!.email!);

        // update firestore
        await userRef.value!.update({
          'email': user.value!.email!,
          'name': user.value!.name!,
        });

        final homeController = Get.find<HomeController>();
        homeController.fetchUser();

        Get.back();
        SnackbarUtil.show('Success', 'Profile berhasil diperbarui');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          SnackbarUtil.show('Error', 'Email sudah digunakan');
        }

        if (e.code == 'invalid-email') {
          SnackbarUtil.show('Error', 'Email tidak valid');
        }

        if (e.code == 'requires-recent-login') {
          SnackbarUtil.show('Error', 'Silahkan login kembali');
        }
      } catch (e) {
        SnackbarUtil.show('Error', 'Terjadi kesalahan');
      } finally {
        submitted.toggle();
      }
    }
  }
}
