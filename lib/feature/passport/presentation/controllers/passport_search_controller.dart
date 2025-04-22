import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/model/passport_model.dart';
import '../../data/repository/passport_repository.dart';
import 'passport_controller.dart';

class PassportSearchController extends GetxController {
  final PassportRepository _repository;

  PassportSearchController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<PassportSearchModel> passports = <PassportSearchModel>[].obs;

  final TextEditingController name = TextEditingController();
  final TextEditingController passportNumber = TextEditingController();

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.search(
        name: name.text, passportNumber: passportNumber.text);
    data.fold((l) => messageError(l.eerMessage), (r) => passports(r));
    isLoading(false);
  }

  Future<void> findById(int id) async {
    isLoading(true);
    messageError("");
    final data = await _repository.findById(id);
    data.fold((l) => messageError(l.eerMessage),
        (r) => Get.find<PassportController>().fillControllers(r));
    isLoading(false);
  }

  void clearControllers() {
    name.clear();
    passportNumber.clear();
  }

  // حل مبدأي
  Future<int> getId() async {
    int max = 0;
    await findAll();
    for (PassportSearchModel m in passports) {
      if (m.id! > max) {
        max = m.id!;
      }
    }
    return max + 1;
  }
}
