import 'package:get/get.dart';

import '../controllers/admin_queue_controller.dart';

class AdminQueueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminQueueController>(
      () => AdminQueueController(),
    );
  }
}
