import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/emp_kashf_tepy_model.dart';
import '../../data/repository/emp_kashf_tepy_repository.dart';
import 'emp_kashf_tepy_controller.dart';

class EmpKashfTepySearchController extends GetxController {
  final EmpKashfTepyRepository _repository;

  EmpKashfTepySearchController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpKashfTepySearchModel> empKashfTepys =
      <EmpKashfTepySearchModel>[].obs;

  final TextEditingController name = TextEditingController();
  final TextEditingController cardId = TextEditingController();

  final List<String> empTypeList = [
    "",
    "موظف",
    "مستخدم",
    "عامل بند أجور",
    "عامل أجنبي",
    "عامل نظافة - عقد"
  ];

  RxString empType = "".obs;

  void onChangedEmpType(String? value) {
    empType(value!);
  }

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.search(
      name: name.text,
      cardId: cardId.text,
      empType: empType.value,
    );
    data.fold((l) => messageError(l.eerMessage), (r) => empKashfTepys(r));
    isLoading(false);
  }

  Future<void> findById(int id) async {
    isLoading(true);
    messageError("");
    final data = await _repository.findById(id);
    data.fold((l) => messageError(l.eerMessage),
        (r) => Get.find<EmpKashfTepyController>().fillControllers(r));
    isLoading(false);
  }

  void clearControllers() {
    name.clear();
    cardId.clear();
    empType("");
  }

  // حل مبدأي
  Future<int> getId() async {
    int max = 0;
    await findAll();
    for (EmpKashfTepySearchModel m in empKashfTepys) {
      if (m.id! > max) {
        max = m.id!;
      }
    }
    return max + 1;
  }
}
