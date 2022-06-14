import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_doctor_mobile/app/data/models/user_model.dart';
import 'package:booking_doctor_mobile/app/routes/app_pages.dart';

import '../views/home_view.dart';
import '../views/profile_view.dart';

class HomeController extends GetxController {
  late PageController pageController;
  final tabs = [HomeView(), ProfileView()];
  final Rxn<UserModel> user = Rxn<UserModel>();
  final RxnString userId = RxnString();
  final RxInt currentIndex = RxInt(0);

  User get currentUser => FirebaseAuth.instance.currentUser!;

  Stream<QuerySnapshot> get queryStream => FirebaseFirestore.instance
      .collection('orders')
      .where('userId', isEqualTo: FirebaseFirestore.instance.collection('users').doc(userId.value))
      .where('status', isEqualTo: 'pending')
      .snapshots();

  onChangeTab(int index) {
    pageController.jumpToPage(index);
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void fetchUser() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();

    userId.value = snapshot.docs[0].id;
    user.value = UserModel.fromJson(snapshot.docs[0].data());
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
