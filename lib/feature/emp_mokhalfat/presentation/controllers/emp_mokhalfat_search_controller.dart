import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:personnel_management/feature/emp_mokhalfat/presentation/controllers/emp_mokhalfat_controller.dart';
import '../../data/model/emp_mokhalfat_model.dart';
import '../../data/repository/emp_mokhalfat_repository.dart';

class EmpMokhalfatSearchController extends GetxController {
  final EmpMokhalfatRepository _repository;

  EmpMokhalfatSearchController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpMokhalfatSearchModel> empMokhalfats =
      <EmpMokhalfatSearchModel>[].obs;

  get length => empMokhalfats.length;

  final TextEditingController name = TextEditingController();
  final TextEditingController cardId = TextEditingController();

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.search(name: name.text, cardId: cardId.text);
    data.fold((l) => messageError(l.eerMessage), (r) => empMokhalfats(r));
    isLoading(false);
  }

  Future<void> findById(int id) async {
    isLoading(true);
    messageError("");
    final data = await _repository.findById(id);
    data.fold((l) => messageError(l.eerMessage),
        (r) => Get.find<EmpMokhalfatController>().fillControllers(r));
    isLoading(false);
  }

  void clearControllers() {
    name.clear();
    cardId.clear();
    findAll();
  }

//  حل مبدأي
  Future<int> getId() async {
    int max = 0;
    await findAll();
    for (EmpMokhalfatSearchModel m in empMokhalfats) {
      if (m.id! > max) {
        max = m.id!;
      }
    }
    return max + 1;
  }
}
