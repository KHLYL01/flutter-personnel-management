import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/emp_entedab_model.dart';
import '../../data/repository/emp_entedab_repository.dart';

class EmpEntedabController extends GetxController {
  final EmpEntedabRepository _repository;

  EmpEntedabController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpEntedabSearchModel> empEntedabs = <EmpEntedabSearchModel>[].obs;

  final TextEditingController employeeName = TextEditingController();
  final TextEditingController cardId = TextEditingController();
  final TextEditingController entedabPlace = TextEditingController();

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.search(
      employeeName: employeeName.text,
      cardId: cardId.text,
      entedabPlace: entedabPlace.text,
    );
    data.fold((l) => messageError(l.eerMessage), (r) => empEntedabs(r));
    isLoading(false);
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    // TODO add text field
    final data = await _repository.save(
      EmpEntedabModel(
          // id: int.parse(id.text),
          // employeeName: employeeName.text,
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
    employeeName.clear();
    cardId.clear();
    entedabPlace.clear();
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
  //   for (EmpEntedabModel m in empEntedabs) {
  //     if (m.id! > max) {
  //       max = m.id!;
  //     }
  //   }
  //   return max + 1;
  // }

  void fillControllers(Map<String, PlutoCell> cells) {
    // id.text = cells['id']!.value.toString();
    // employeeName.text = cells['employeeName']!.value.toString();
  }
}
