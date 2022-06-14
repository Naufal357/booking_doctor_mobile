import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pesandokter/app/data/models/category_dropdown.dart';
import 'package:pesandokter/app/data/models/doctor_model.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/category_model.dart';

class AdminDoctorEditController extends GetxController {
  final String documentId = Get.arguments as String;
  final formKey = GlobalKey<FormState>();
  final RxBool loading = true.obs;
  final RxBool submitted = false.obs;

  final Rx<DoctorModel> data = DoctorModel().obs;
  final RxList<CategoryDropdown> categories = <CategoryDropdown>[].obs;
  final Rxn<XFile> photo = Rxn<XFile>();

  final RxString name = ''.obs;
  final RxString category = ''.obs;

  void submit() async {
    if (formKey.currentState!.validate()) {
      submitted.toggle();
      formKey.currentState!.save();

      if (photo.value != null) {
        final fileName = data.value.photoUrl!.split('/').last.split('?').first.replaceAll('images%2F', '');
        await FirebaseStorage.instance.ref().child('images/$fileName').delete();

        final imageUrl = await uploadImage(photo.value!);
        data.value.photoUrl = imageUrl;
      }

      data.value.name = name.value;
      data.value.category = FirebaseFirestore.instance.collection('categories').doc(category.value);

      updateDoctor(data.value);

      Get.back();
    }
  }

  void delete() async {
    Get.defaultDialog(
      title: 'Hapus Dokter',
      middleText: 'Apakah anda yakin ingin menghapus dokter ini?',
      textConfirm: 'Ya',
      onConfirm: () async {
        final fileName = data.value.photoUrl!.split('/').last.split('?').first.replaceAll('images%2F', '');

        // delete all orders where doctorId is this doctor
        await FirebaseFirestore.instance
            .collection('orders')
            .where('doctorId', isEqualTo: FirebaseFirestore.instance.collection('doctors').doc(documentId))
            .get()
            .then((snapshot) {
          for (var doc in snapshot.docs) {
            FirebaseFirestore.instance.collection('orders').doc(doc.id).delete();
          }
        });

        await Future.wait([
          FirebaseFirestore.instance.collection('doctors').doc(documentId).delete(),
          FirebaseStorage.instance.ref().child('images/$fileName').delete(),
        ]);

        Get.back();
        Get.back();
      },
      buttonColor: Colors.red,
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
      textCancel: 'Tidak',
    );
  }

  void updateDoctor(DoctorModel data) async {
    try {
      await FirebaseFirestore.instance.collection('doctors').doc(documentId).update(data.toJson());
    } catch (e) {
      log(e.toString());
    }
  }

  void fetchData() async {
    // get doctor data from firestore
    final snapshot = await FirebaseFirestore.instance.collection('doctors').doc(documentId).get();
    data.value = DoctorModel.fromJson(snapshot.data() as Map<String, dynamic>);

    // get all categories
    final snapshotCategories = await FirebaseFirestore.instance.collection('categories').get();
    final categoriesList = snapshotCategories.docs
        .map(
          (doc) => CategoryDropdown(
            category: CategoryModel.fromJson(doc.data()),
            id: doc.id,
          ),
        )
        .toList();
    categories.value = categoriesList;

    final currentCategory = data.value.category!.path.replaceAll('categories/', '');

    // set default value
    name.value = data.value.name!;
    if (categories.any((category) => category.id == currentCategory)) {
      category.value = currentCategory;
    }

    loading.toggle();
  }

  Future<String?> uploadImage(XFile image) async {
    final uuid = Uuid().v1();
    final imageExtension = image.path.split('.').last;
    final fileRef = FirebaseStorage.instance.ref().child('images/$uuid.$imageExtension');

    try {
      await fileRef.putFile(File(image.path));
      final url = await fileRef.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      log('Error uploading image: $e');
    } catch (_) {}

    return null;
  }

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      // crop image with ImageCropper
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
        ],
      );

      if (croppedFile != null) photo.value = XFile(croppedFile.path);
    } catch (e) {
      log(e.toString());
    }
  }
}
