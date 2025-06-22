import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/model/tafweed_model.dart';
import '../../data/repository/tafweed_repository.dart';
import 'tafweed_controller.dart';

class TafweedSearchController extends GetxController {
  final TafweedRepository _repository;

  TafweedSearchController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<TafweedSearchModel> tafweeds = <TafweedSearchModel>[].obs;

  get length => tafweeds.length;

  // for search
  final TextEditingController empId = TextEditingController();
  final TextEditingController empName = TextEditingController();

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.search(
        empId: empId.text == "" ? null : int.parse(empId.text));
    data.fold((l) => messageError(l.eerMessage), (r) => tafweeds(r));
    isLoading(false);
  }

  Future<void> findById(int id) async {
    isLoading(true);
    messageError("");
    final data = await _repository.findById(id);
    data.fold((l) => messageError(l.eerMessage), (r) {
      Get.find<TafweedController>().fillControllers(r);
    });
    isLoading(false);
  }

  void clearControllers() {
    empId.clear();
    empName.clear();
    findAll();
  }

  //  حل مبدأي
  Future<int> getId() async {
    int max = 0;
    await findAll();
    for (TafweedSearchModel m in tafweeds) {
      if (m.id! > max) {
        max = m.id!;
      }
    }
    return max + 1;
  }
}
