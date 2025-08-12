import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personnel_management/feature/users/data/model/user_model.dart';
import 'package:personnel_management/feature/users/presentation/controllers/user_controller.dart';

import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/signature_model.dart';
import '../../data/repository/signature_repository.dart';

class SignatureController extends GetxController {
  final SignatureRepository _repository;

  SignatureController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  int id = 0;
  int userId = 0;
  final TextEditingController content = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController empName = TextEditingController();

  RxList<SignatureModel> signatures = <SignatureModel>[].obs;

  List<UserModel> users = [];
  List<String> usersEmpName = [];
  RxString selectedUser = "الكل".obs;

  onChangeUser(String? value) {
    if (value != null) {
      selectedUser(value);
      if (selectedUser.value == "الكل") {
        findAll();
      } else {
        findByUserId(
          users
              .where((element) => element.empName == selectedUser.value)
              .first
              .id,
        );
      }
    }
  }

  get length => signatures.length;

  Rx<Uint8List?> imageBytes = Rx(null);

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imageBytes.value = await image.readAsBytes();
      // Use the bytes to display the image
    }
  }

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.findAll();
    data.fold((l) => messageError(l.eerMessage), (r) {
      signatures.value = r;
    });
    isLoading(false);

    if (messageError.isEmpty) {
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  Future<void> findByUserId(userId) async {
    isLoading(true);
    messageError("");
    this.userId = userId;
    final data = await _repository.findAllByUserId(userId);
    data.fold((l) => messageError(l.eerMessage), (r) {
      signatures.value = r;
    });
    isLoading(false);

    if (messageError.isEmpty) {
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    // Convert bytes to a Blob, then a File (web-compatible)
    // final blob = html.Blob([imageBytes.value!]);
    // final html.File file = html.File([blob], 'signature.png');

    dio.MultipartFile file = dio.MultipartFile.fromBytes(imageBytes.value!,
        filename: 'signature.png');

    final data = await _repository.save(
      image: file,
      content: content.text,
      password: password.text,
      userId: userId,
    );
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);

    if (messageError.isEmpty) {
      Get.back();
      customSnackBar(title: 'تم', message: "تم إضافة التوقيع بنجاح");
      findByUserId(userId);
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
    log(messageError.value);
  }

  Future<void> deleteById(int id) async {
    isLoading(true);
    messageError("");
    final data = await _repository.delete(id);
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      findAll();
      customSnackBar(title: 'تم', message: 'تم الحذف بنجاح');
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  bool checkPassword(Uint8List image, String password) {
    if (signatures.where((p0) => p0.image == image).first.password ==
        password) {
      return true;
    }
    return false;
  }

  clearControllers() {
    imageBytes.value = null;
    content.clear();
    password.text = Get.find<UserController>().userPassword;
    empName.text = Get.find<UserController>().userEmpName;
  }

  fillControllerAdmin() {
    imageBytes.value = null;
    content.clear();
    password.text = users
            .where((element) => element.empName == selectedUser.value)
            .first
            .password ??
        "";
    empName.text = selectedUser.value;
  }
}
