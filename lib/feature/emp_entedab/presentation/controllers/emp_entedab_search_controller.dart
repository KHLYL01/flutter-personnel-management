import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/model/emp_entedab_model.dart';
import '../../data/repository/emp_entedab_repository.dart';
import 'emp_entedab_controller.dart';

class EmpEntedabSearchController extends GetxController {
  final EmpEntedabRepository _repository;

  EmpEntedabSearchController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpEntedabSearchModel> empEntedabs = <EmpEntedabSearchModel>[].obs;

  get length => empEntedabs.length;

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

  Future<void> findById(int id) async {
    isLoading(true);
    messageError("");
    final data = await _repository.findById(id);
    data.fold((l) => messageError(l.eerMessage),
        (r) => Get.find<EmpEntedabController>().fillControllers(r));
    isLoading(false);
  }

  void clearControllers() {
    employeeName.clear();
    cardId.clear();
    entedabPlace.clear();
    findAll();
  }

//  حل مبدأي
  Future<int> getId() async {
    int max = 0;
    await findAll();
    for (EmpEntedabSearchModel m in empEntedabs) {
      if (m.id! > max) {
        max = m.id!;
      }
    }
    return max + 1;
  }
}
