import 'package:get/get.dart';

import '../controllers/admin_category_add_controller.dart';

class AdminCategoryAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminCategoryAddController>(
      () => AdminCategoryAddController(),
    );
  }
}
