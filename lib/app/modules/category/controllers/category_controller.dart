import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final categoryQuery = FirebaseFirestore.instance.collection('categories').orderBy('createdAt');
}
