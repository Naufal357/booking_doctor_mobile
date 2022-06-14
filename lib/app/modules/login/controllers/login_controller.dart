import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:booking_doctor_mobile/app/data/models/user_model.dart';

import '../../../utils/snackbar.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool submitted = false.obs;
  final RxBool showPassword = false.obs;
  final RxBool loading = true.obs;

  final RxString email = ''.obs;
  final RxString password = ''.obs;

  @override
  void onReady() {
    super.onReady();
    validateIsLoggedin();
  }

  void validateIsLoggedin() async {
    // await FirebaseAuth.instance.signOut();

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final firestoreUser = (await FirebaseFirestore.instance.collection('users').doc(user.uid).get()).data();

      if (firestoreUser != null) {
        redirectToRoleScreen();
        return;
      }
    }

    loading.toggle();
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      submitted.toggle();

      // do login with firebase auth
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email.value, password: password.value);

        if (credential.user != null) {
          // check if user exist in firestore
          final user = await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).get();

          // if user exist then redirect to home
          if (user.exists) {
            redirectToRoleScreen();
          } else {
            SnackbarUtil.show('Error', 'User tidak ditemukan');
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          SnackbarUtil.show('Error', 'Password salah');
        } else if (e.code == 'user-not-found') {
          SnackbarUtil.show('Error', 'Email tidak terdaftar');
        } else if (e.code == 'user-disabled') {
          SnackbarUtil.show('Error', 'Akun anda telah dinonaktifkan');
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

  void redirectToRoleScreen() async {
    final user = FirebaseAuth.instance.currentUser;
    final userDoc = FirebaseFirestore.instance.collection('users').doc(user!.uid);

    final firestoreUser = UserModel.fromJson((await userDoc.get()).data()!);

    if (firestoreUser.role == 'admin') {
      Get.offAllNamed('/admin/home');
    } else {
      Get.offAllNamed('/home');
    }
  }
}
