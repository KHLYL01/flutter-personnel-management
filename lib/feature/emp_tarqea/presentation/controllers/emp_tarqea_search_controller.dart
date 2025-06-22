import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/model/emp_tarqea_model.dart';
import '../../data/repository/emp_tarqea_repository.dart';
import 'emp_tarqea_controller.dart';

class EmpTarqeaSearchController extends GetxController {
  final EmpTarqeaRepository _repository;

  EmpTarqeaSearchController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpTarqeaSearchModel> empTarqeas = <EmpTarqeaSearchModel>[].obs;

  get length => empTarqeas.length;

  final TextEditingController name = TextEditingController();
  final TextEditingController qrarId = TextEditingController();

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.search(name: name.text, qrarId: qrarId.text);
    data.fold((l) => messageError(l.eerMessage), (r) => empTarqeas(r));
    isLoading(false);
  }

  Future<void> findById(int id) async {
    isLoading(true);
    messageError("");
    final data = await _repository.findById(id);
    data.fold((l) => messageError(l.eerMessage),
        (r) => Get.find<EmpTarqeaController>().fillControllers(r));
    isLoading(false);
  }

  void clearControllers() {
    name.clear();
    qrarId.clear();
    findAll();
  }

  // حل مبدأي
  Future<int> getId() async {
    int max = 0;
    await findAll();
    for (EmpTarqeaSearchModel m in empTarqeas) {
      if (m.id! > max) {
        max = m.id!;
      }
    }
    return max + 1;
  }
}
