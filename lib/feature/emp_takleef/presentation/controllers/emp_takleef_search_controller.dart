import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/model/emp_takleef_model.dart';
import '../../data/repository/emp_takleef_repository.dart';
import 'emp_takleef_controller.dart';

class EmpTakleefSearchController extends GetxController {
  final EmpTakleefRepository _repository;

  EmpTakleefSearchController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpTakleefSearchModel> empTakleefs = <EmpTakleefSearchModel>[].obs;

  get length => empTakleefs.length;

  // search
  final TextEditingController name = TextEditingController();
  final TextEditingController cardId = TextEditingController();
  final TextEditingController place = TextEditingController();

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.search(
        name: name.text, cardId: cardId.text, place: place.text);
    data.fold((l) => messageError(l.eerMessage), (r) => empTakleefs(r));
    isLoading(false);
  }

  Future<void> findById(int id) async {
    isLoading(true);
    messageError("");
    final data = await _repository.findById(id);
    data.fold((l) => messageError(l.eerMessage),
        (r) => Get.find<EmpTakleefController>().fillControllers(r));
    isLoading(false);
  }

  clearControllers() {
    name.clear();
    cardId.clear();
    place.clear();
    findAll();
  }

//  حل مبدأي
  Future<int> getId() async {
    int max = 0;
    await findAll();
    for (EmpTakleefSearchModel m in empTakleefs) {
      if (m.id! > max) {
        max = m.id!;
      }
    }
    return max + 1;
  }
}
