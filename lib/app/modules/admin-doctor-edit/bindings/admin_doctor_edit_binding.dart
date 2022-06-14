import 'package:get/get.dart';

import '../controllers/admin_doctor_edit_controller.dart';

class AdminDoctorEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminDoctorEditController>(
      () => AdminDoctorEditController(),
    );
  }
}
