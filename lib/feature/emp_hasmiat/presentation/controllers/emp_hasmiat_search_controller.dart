import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:personnel_management/feature/emp_hasmiat/presentation/controllers/emp_hasmiat_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/emp_hasmiat_model.dart';
import '../../data/repository/emp_hasmiat_repository.dart';

class EmpHasmiatSearchController extends GetxController {
  final EmpHasmiatRepository _repository;

  EmpHasmiatSearchController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpHasmiatSearchModel> empHasmiats = <EmpHasmiatSearchModel>[].obs;

  get length => empHasmiats.length;

  final TextEditingController name = TextEditingController();
  final TextEditingController cardId = TextEditingController();

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.search(name: name.text, cardId: cardId.text);
    data.fold((l) => messageError(l.eerMessage), (r) => empHasmiats(r));
    isLoading(false);
  }

  Future<void> findById(int id) async {
    isLoading(true);
    messageError("");
    final data = await _repository.findById(id);
    data.fold((l) => messageError(l.eerMessage),
        (r) => Get.find<EmpHasmiatController>().fillControllers(r));
    isLoading(false);
  }

  void clearControllers() {
    name.clear();
    cardId.clear();
  }

//  حل مبدأي
  Future<int> getId() async {
    int max = 0;
    await findAll();
    for (EmpHasmiatSearchModel m in empHasmiats) {
      if (m.id! > max) {
        max = m.id!;
      }
    }
    return max + 1;
  }
}
