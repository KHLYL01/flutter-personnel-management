import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/passport_model.dart';
import '../../data/repository/passport_repository.dart';

class PassportController extends GetxController {
  final PassportRepository _repository;

  PassportController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<PassportSearchModel> empTarqeas = <PassportSearchModel>[].obs;

  final TextEditingController name = TextEditingController();
  final TextEditingController passportNumber = TextEditingController();

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.search(
        name: name.text, passportNumber: passportNumber.text);
    data.fold((l) => messageError(l.eerMessage), (r) => empTarqeas(r));
    isLoading(false);
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    // TODO add text field
    final data = await _repository.save(
      PassportModel(
          // id: int.parse(id.text),
          // name: name.text,
          ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      findAll();
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
      findAll();
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  void clearControllers() {
    name.clear();
    passportNumber.clear();
  }

  @override
  void onInit() {
    // findAll();
    super.onInit();
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

  // حل مبدأي
  // int getId() {
  //   int max = 0;
  //   for (PassportModel m in empTarqeas) {
  //     if (m.id! > max) {
  //       max = m.id!;
  //     }
  //   }
  //   return max + 1;
  // }

  void fillControllers(Map<String, PlutoCell> cells) {
    // id.text = cells['id']!.value.toString();
    // name.text = cells['name']!.value.toString();
  }
}
