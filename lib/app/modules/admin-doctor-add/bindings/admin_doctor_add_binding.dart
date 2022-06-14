import 'package:get/get.dart';

import '../controllers/admin_doctor_add_controller.dart';

class AdminDoctorAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminDoctorAddController>(
      () => AdminDoctorAddController(),
    );
  }
}
