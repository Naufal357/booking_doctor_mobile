import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_doctor_mobile/app/data/models/user_model.dart';

import '../../../utils/snackbar.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool submitted = false.obs;
  final RxBool showPassword = false.obs;

  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxString password = ''.obs;

  void register() async {
    if (formKey.currentState!.validate()) {
      submitted.toggle();

      // do registration with firebase auth
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email.value, password: password.value);

        if (credential.user != null) {
          // update user displayName
          await FirebaseAuth.instance.currentUser!.updateDisplayName(name.value);

          // create model data
          final data = UserModel(
            name: name.value,
            email: email.value,
            role: 'user',
            createdAt: Timestamp.now(),
          );

          // save user to firestore users document
          CollectionReference users = FirebaseFirestore.instance.collection('users');
          await users.doc(credential.user!.uid).set(data.toJson());

          // navigate to home
          Get.offAllNamed('/home');
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          SnackbarUtil.show('Error', 'Password terlalu lemah');
        } else if (e.code == 'email-already-in-use') {
          SnackbarUtil.show('Error', 'Email sudah digunakan');
        } else if (e.code == 'invalid-email') {
          SnackbarUtil.show('Error', 'Email tidak valid');
        } else {
          SnackbarUtil.show('Error', 'Terjadi kesalahan');
        }
      } catch (_) {
        SnackbarUtil.show('Error', 'Terjadi kesalahan');
      } finally {
        submitted.toggle();
      }
    }
  }
}
