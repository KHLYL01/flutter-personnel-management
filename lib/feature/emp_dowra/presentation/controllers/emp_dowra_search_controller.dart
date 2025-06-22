import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:personnel_management/feature/emp_dowra/presentation/controllers/emp_dowra_controller.dart';
import '../../data/model/emp_dowra_model.dart';
import '../../data/repository/emp_dowra_repository.dart';

class EmpDowraSearchController extends GetxController {
  final EmpDowraRepository _repository;

  EmpDowraSearchController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpDowraSearchModel> empDowras = <EmpDowraSearchModel>[].obs;

  get length => empDowras.length;

  final TextEditingController name = TextEditingController();
  final TextEditingController cardId = TextEditingController();

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.search(name: name.text, cardId: cardId.text);
    data.fold((l) => messageError(l.eerMessage), (r) => empDowras(r));
    isLoading(false);
  }

  Future<void> findById(int id) async {
    isLoading(true);
    messageError("");
    final data = await _repository.findById(id);
    data.fold((l) => messageError(l.eerMessage),
        (r) => Get.find<EmpDowraController>().fillControllers(r));
    isLoading(false);
  }

  void clearControllers() {
    name.clear();
    cardId.clear();
    findAll();
  }

  // حل مبدأي
  Future<int> getId() async {
    int max = 0;
    await findAll();
    for (EmpDowraSearchModel m in empDowras) {
      if (m.dowraId! > max) {
        max = m.dowraId!;
      }
    }
    return max + 1;
  }
}
