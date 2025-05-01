import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/feature/passport/presentation/controllers/passport_search_controller.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/passport_model.dart';
import '../../data/repository/passport_repository.dart';

class PassportController extends GetxController {
  final PassportRepository _repository;

  PassportController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  final TextEditingController id = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController documentNumber = TextEditingController();
  final TextEditingController exportFrom = TextEditingController();
  final TextEditingController nationalId = TextEditingController();
  final TextEditingController nationalName = TextEditingController();
  final TextEditingController owner = TextEditingController();
  final TextEditingController witness = TextEditingController();

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      PassportModel(
        id: id.text != ""
            ? int.parse(id.text)
            : await Get.find<PassportSearchController>().getId(),
        date: date.text,
        name: name.text,
        documentNumber: documentNumber.text,
        exportFrom: exportFrom.text,
        nationalId: int.parse(nationalId.text),
        owner: owner.text,
        witness: witness.text,
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => fillControllers(r));
    isLoading(false);
    if (messageError.isEmpty) {
      Get.find<PassportSearchController>().findAll();
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  Future<void> delete(int id) async {
    isLoading(true);
    messageError("");
    final data = await _repository.delete(id);
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      Get.find<PassportSearchController>().findAll();
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  void clearControllers() {
    id.clear();
    date.clear();
    name.clear();
    documentNumber.clear();
    exportFrom.clear();
    nationalId.clear();
    nationalName.clear();
    owner.clear();
    witness.clear();
  }

  void confirmDelete(int id, {bool withGoBack = true}) async {
    await alertDialog(
      title: 'تحذير',
      middleText: "هل تريد حذف الوظيفة بالفعل",
      onPressedConfirm: () {
        if (withGoBack) {
          Get.back();
        }
        delete(id);
      },
    );
  }

  void fillControllers(PassportModel r) {
    id.text = r.id.toString();
    date.text = r.date.toString();
    name.text = r.name.toString();
    documentNumber.text = r.documentNumber.toString();
    exportFrom.text = r.exportFrom.toString();
    nationalId.text = r.nationalId.toString();
    owner.text = r.owner.toString();
    witness.text = r.witness.toString();
  }
}
