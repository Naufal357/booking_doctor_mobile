import 'package:get/get.dart';

import 'package:booking_doctor_mobile/app/modules/admin-category-add/bindings/admin_category_add_binding.dart';
import 'package:booking_doctor_mobile/app/modules/admin-category-add/views/admin_category_add_view.dart';
import 'package:booking_doctor_mobile/app/modules/admin-category-edit/bindings/admin_category_edit_binding.dart';
import 'package:booking_doctor_mobile/app/modules/admin-category-edit/views/admin_category_edit_view.dart';
import 'package:booking_doctor_mobile/app/modules/admin-category/bindings/admin_category_binding.dart';
import 'package:booking_doctor_mobile/app/modules/admin-category/views/admin_category_view.dart';
import 'package:booking_doctor_mobile/app/modules/admin-doctor-add/bindings/admin_doctor_add_binding.dart';
import 'package:booking_doctor_mobile/app/modules/admin-doctor-add/views/admin_doctor_add_view.dart';
import 'package:booking_doctor_mobile/app/modules/admin-doctor-edit/bindings/admin_doctor_edit_binding.dart';
import 'package:booking_doctor_mobile/app/modules/admin-doctor-edit/views/admin_doctor_edit_view.dart';
import 'package:booking_doctor_mobile/app/modules/admin-doctor/bindings/admin_doctor_binding.dart';
import 'package:booking_doctor_mobile/app/modules/admin-doctor/views/admin_doctor_view.dart';
import 'package:booking_doctor_mobile/app/modules/admin-home/bindings/admin_home_binding.dart';
import 'package:booking_doctor_mobile/app/modules/admin-home/views/admin_home_view.dart';
import 'package:booking_doctor_mobile/app/modules/admin-order-detail/bindings/admin_order_detail_binding.dart';
import 'package:booking_doctor_mobile/app/modules/admin-order-detail/views/admin_order_detail_view.dart';
import 'package:booking_doctor_mobile/app/modules/admin-order/bindings/admin_order_binding.dart';
import 'package:booking_doctor_mobile/app/modules/admin-order/views/admin_order_view.dart';
import 'package:booking_doctor_mobile/app/modules/admin-queue-edit/bindings/admin_queue_edit_binding.dart';
import 'package:booking_doctor_mobile/app/modules/admin-queue-edit/views/admin_queue_edit_view.dart';
import 'package:booking_doctor_mobile/app/modules/admin-queue/bindings/admin_queue_binding.dart';
import 'package:booking_doctor_mobile/app/modules/admin-queue/views/admin_queue_view.dart';
import 'package:booking_doctor_mobile/app/modules/admin-user-edit/bindings/admin_user_edit_binding.dart';
import 'package:booking_doctor_mobile/app/modules/admin-user-edit/views/admin_user_edit_view.dart';
import 'package:booking_doctor_mobile/app/modules/admin-user/bindings/admin_user_binding.dart';
import 'package:booking_doctor_mobile/app/modules/admin-user/views/admin_user_view.dart';
import 'package:booking_doctor_mobile/app/modules/category/bindings/category_binding.dart';
import 'package:booking_doctor_mobile/app/modules/category/views/category_view.dart';
import 'package:booking_doctor_mobile/app/modules/doctor/bindings/doctor_binding.dart';
import 'package:booking_doctor_mobile/app/modules/doctor/views/doctor_view.dart';
import 'package:booking_doctor_mobile/app/modules/home/bindings/home_binding.dart';
import 'package:booking_doctor_mobile/app/modules/home/views/home_tab_view.dart';
import 'package:booking_doctor_mobile/app/modules/login/bindings/login_binding.dart';
import 'package:booking_doctor_mobile/app/modules/login/views/login_view.dart';
import 'package:booking_doctor_mobile/app/modules/order-history/bindings/order_history_binding.dart';
import 'package:booking_doctor_mobile/app/modules/order-history/views/order_history_view.dart';
import 'package:booking_doctor_mobile/app/modules/order/bindings/order_binding.dart';
import 'package:booking_doctor_mobile/app/modules/order/views/order_view.dart';
import 'package:booking_doctor_mobile/app/modules/profile-edit/bindings/profile_edit_binding.dart';
import 'package:booking_doctor_mobile/app/modules/profile-edit/views/profile_edit_view.dart';
import 'package:booking_doctor_mobile/app/modules/register/bindings/register_binding.dart';
import 'package:booking_doctor_mobile/app/modules/register/views/register_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeTabView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_HOME,
      page: () => AdminHomeView(),
      binding: AdminHomeBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_CATEGORY,
      page: () => AdminCategoryView(),
      binding: AdminCategoryBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_CATEGORY_ADD,
      page: () => AdminCategoryAddView(),
      binding: AdminCategoryAddBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_CATEGORY_EDIT,
      page: () => AdminCategoryEditView(),
      binding: AdminCategoryEditBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_DOCTOR,
      page: () => AdminDoctorView(),
      binding: AdminDoctorBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_DOCTOR_ADD,
      page: () => AdminDoctorAddView(),
      binding: AdminDoctorAddBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_DOCTOR_EDIT,
      page: () => AdminDoctorEditView(),
      binding: AdminDoctorEditBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_USER,
      page: () => AdminUserView(),
      binding: AdminUserBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_USER_EDIT,
      page: () => AdminUserEditView(),
      binding: AdminUserEditBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_ORDER,
      page: () => AdminOrderView(),
      binding: AdminOrderBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_ORDER_DETAIL,
      page: () => AdminOrderDetailView(),
      binding: AdminOrderDetailBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_QUEUE,
      page: () => AdminQueueView(),
      binding: AdminQueueBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_QUEUE_EDIT,
      page: () => AdminQueueEditView(),
      binding: AdminQueueEditBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.DOCTOR,
      page: () => DoctorView(),
      binding: DoctorBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_EDIT,
      page: () => ProfileEditView(),
      binding: ProfileEditBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_HISTORY,
      page: () => OrderHistoryView(),
      binding: OrderHistoryBinding(),
    ),
  ];
}
