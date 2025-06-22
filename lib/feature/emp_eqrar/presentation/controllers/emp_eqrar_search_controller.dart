import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/model/emp_eqrar_model.dart';
import '../../data/repository/emp_eqrar_repository.dart';
import 'emp_eqrar_controller.dart';

class EmpEqrarSearchController extends GetxController {
  final EmpEqrarRepository _repository;

  EmpEqrarSearchController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpEqrarSearchModel> empEqrars = <EmpEqrarSearchModel>[].obs;

  get length => empEqrars.length;

  final TextEditingController name = TextEditingController();

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.search(name: name.text);
    data.fold((l) => messageError(l.eerMessage), (r) => empEqrars(r));
    isLoading(false);
  }

  Future<void> findById(int id) async {
    isLoading(true);
    messageError("");
    final data = await _repository.findById(id);
    data.fold((l) => messageError(l.eerMessage),
        (r) => Get.find<EmpEqrarController>().fillControllers(r));
    isLoading(false);
  }

  void clearControllers() {
    name.clear();
    findAll();
  }

  // حل مبدأي
  Future<int> getId() async {
    int max = 0;
    await findAll();
    for (EmpEqrarSearchModel m in empEqrars) {
      if (m.id! > max) {
        max = m.id!;
      }
    }
    return max + 1;
  }
}
