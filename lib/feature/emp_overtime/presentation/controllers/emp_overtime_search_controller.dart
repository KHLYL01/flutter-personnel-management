import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:personnel_management/feature/emp_overtime/presentation/controllers/emp_overtime_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/emp_overtime_model.dart';
import '../../data/repository/emp_overtime_repository.dart';

class EmpOvertimeSearchController extends GetxController {
  final EmpOvertimeRepository _repository;

  EmpOvertimeSearchController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpOvertimeSearchModel> empOvertimes = <EmpOvertimeSearchModel>[].obs;

  get length => empOvertimes.length;

  // search
  final TextEditingController name = TextEditingController();
  final TextEditingController cardId = TextEditingController();
  final TextEditingController place = TextEditingController();

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.search(
        name: name.text, cardId: cardId.text, place: place.text);
    data.fold((l) => messageError(l.eerMessage), (r) => empOvertimes(r));
    isLoading(false);
  }

  Future<void> findById(int id) async {
    isLoading(true);
    messageError("");
    final data = await _repository.findById(id);
    data.fold((l) => messageError(l.eerMessage),
        (r) => Get.find<EmpOvertimeController>().fillControllers(r));
    isLoading(false);
  }

  clearControllers() {
    name.clear();
    cardId.clear();
    place.clear();
  }

//  حل مبدأي
  Future<int> getId() async {
    int max = 0;
    await findAll();
    for (EmpOvertimeSearchModel m in empOvertimes) {
      if (m.id! > max) {
        max = m.id!;
      }
    }
    return max + 1;
  }
}
