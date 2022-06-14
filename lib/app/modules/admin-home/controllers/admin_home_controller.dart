import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AdminHomeController extends GetxController {
  void navigateToCategory() {
    Get.toNamed('/admin/categories');
  }

  void navigateToDoctor() {
    Get.toNamed('/admin/doctors');
  }

  void navigateToUser() {
    Get.toNamed('/admin/users');
  }

  void navigateToOrder() {
    Get.toNamed('/admin/orders');
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed('/login');
  }
}
