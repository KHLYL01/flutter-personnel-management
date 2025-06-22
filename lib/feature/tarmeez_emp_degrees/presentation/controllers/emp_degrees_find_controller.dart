import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/model/emp_degrees_model.dart';
import '../../data/repository/emp_degrees_repository.dart';

class EmpDegreesFindController extends GetxController {
  final EmpDegreesRepository _repository;

  EmpDegreesFindController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpDegreesModel> empDegreess = <EmpDegreesModel>[].obs;

  get length => empDegreess.length;

  final TextEditingController martaba = TextEditingController();
  final TextEditingController draga = TextEditingController();

  Future<void> findEmpDegrees() async {
    isLoading(true);
    messageError("");
    final data = await _repository.find(
      martaba: martaba.text != "" ? double.parse(martaba.text) : null,
      draga: draga.text != "" ? double.parse(draga.text) : null,
    );
    data.fold((l) => messageError(l.eerMessage), (r) => empDegreess(r));
    isLoading(false);
  }

  void clearControllers() {
    martaba.clear();
    draga.clear();
    findEmpDegrees();
  }
}
