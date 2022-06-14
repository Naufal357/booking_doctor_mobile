import 'package:get/get.dart';

import '../controllers/admin_doctor_controller.dart';

class AdminDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminDoctorController>(
      () => AdminDoctorController(),
    );
  }
}
