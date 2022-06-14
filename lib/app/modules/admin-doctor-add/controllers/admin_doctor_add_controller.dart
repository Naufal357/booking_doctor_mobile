import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:booking_doctor_mobile/app/data/models/category_dropdown.dart';
import 'package:booking_doctor_mobile/app/data/models/category_model.dart';
import 'package:booking_doctor_mobile/app/data/models/doctor_model.dart';
import 'package:booking_doctor_mobile/app/utils/snackbar.dart';
import 'package:uuid/uuid.dart';

class AdminDoctorAddController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final RxBool submitted = false.obs;

  final Rxn<XFile> photo = Rxn<XFile>();
  final RxString name = ''.obs;
  final RxString category = ''.obs;

  final RxList<CategoryDropdown> categoryIds = <CategoryDropdown>[].obs;

  void fetchCategories() async {
    final snapshot = await FirebaseFirestore.instance.collection('categories').get();
    categoryIds.value = snapshot.docs
        .map((doc) => CategoryDropdown(category: CategoryModel.fromJson(doc.data()), id: doc.id))
        .toList();
  }

  void submit() async {
    if (formKey.currentState!.validate()) {
      if (photo.value == null) {
        SnackbarUtil.show('Error', 'Foto belum dipilih');
        return;
      }

      submitted.toggle();
      formKey.currentState!.save();

      // upload image to firebase storage
      final imageUrl = await uploadImage(photo.value!);

      final DoctorModel data = DoctorModel(
        name: name.value,
        category: FirebaseFirestore.instance.collection('categories').doc(category.value),
        photoUrl: imageUrl,
        createdAt: Timestamp.now(),
      );

      createDoctor(data);

      Get.back();
    }
  }

  void createDoctor(DoctorModel data) async {
    try {
      await FirebaseFirestore.instance.collection('doctors').add(data.toJson());
    } catch (_) {}
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
