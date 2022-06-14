import 'package:get/get.dart';

import '../controllers/admin_queue_edit_controller.dart';

class AdminQueueEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminQueueEditController>(
      () => AdminQueueEditController(),
    );
  }
}
