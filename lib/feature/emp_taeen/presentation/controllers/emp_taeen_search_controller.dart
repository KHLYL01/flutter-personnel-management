import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:personnel_management/feature/emp_taeen/presentation/controllers/emp_taeen_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/emp_taeen_model.dart';
import '../../data/repository/emp_taeen_repository.dart';

class EmpTaeenSearchController extends GetxController {
  final EmpTaeenRepository _repository;

  EmpTaeenSearchController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpTaeenSearchModel> empTaeens = <EmpTaeenSearchModel>[].obs;

  final TextEditingController name = TextEditingController();

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.search(name: name.text);
    data.fold((l) => messageError(l.eerMessage), (r) => empTaeens(r));
    isLoading(false);
  }

  Future<void> findById(int id) async {
    isLoading(true);
    messageError("");
    final data = await _repository.findById(id);
    data.fold((l) => messageError(l.eerMessage),
        (r) => Get.find<EmpTaeenController>().fillControllers(r));
    isLoading(false);
  }

  void clearControllers() {
    name.clear();
  }

  // حل مبدأي
  Future<int> getId() async {
    int max = 0;
    await findAll();
    for (EmpTaeenSearchModel m in empTaeens) {
      if (m.id! > max) {
        max = m.id!;
      }
    }
    return max + 1;
  }
}
