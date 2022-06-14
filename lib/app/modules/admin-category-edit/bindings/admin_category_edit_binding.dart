import 'package:get/get.dart';

import '../controllers/admin_category_edit_controller.dart';

class AdminCategoryEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminCategoryEditController>(
      () => AdminCategoryEditController(),
    );
  }
}
