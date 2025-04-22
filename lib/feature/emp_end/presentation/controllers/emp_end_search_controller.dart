import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/emp_end_model.dart';
import '../../data/repository/emp_end_repository.dart';
import 'emp_end_controller.dart';

class EmpEndSearchController extends GetxController {
  final EmpEndRepository _repository;

  EmpEndSearchController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpEndSearchModel> empEnds = <EmpEndSearchModel>[].obs;

  final TextEditingController name = TextEditingController();

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.search(name: name.text);
    data.fold((l) => messageError(l.eerMessage), (r) => empEnds(r));
    isLoading(false);
  }

  Future<void> findById(int id) async {
    isLoading(true);
    messageError("");
    final data = await _repository.findById(id);
    data.fold((l) => messageError(l.eerMessage),
        (r) => Get.find<EmpEndController>().fillControllers(r));
    isLoading(false);
  }

  void clearControllers() {
    name.clear();
  }

  // حل مبدأي
  Future<int> getId() async {
    int max = 0;
    await findAll();
    for (EmpEndSearchModel m in empEnds) {
      if (m.id! > max) {
        max = m.id!;
      }
    }
    return max + 1;
  }
}
