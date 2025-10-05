import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/model/emp_eqrar_model.dart';
import '../../data/repository/emp_eqrar_repository.dart';

class EmpEqrarSearchReportController extends GetxController {
  final EmpEqrarRepository _repository;

  EmpEqrarSearchReportController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpEqrarReportModel> empEqrars = <EmpEqrarReportModel>[].obs;

  get length => empEqrars.length;

  final TextEditingController name = TextEditingController();

  Future<void> report() async {
    isLoading(true);
    messageError("");
    final data =
        await _repository.report(name: name.text.isNotEmpty ? name.text : null);
    data.fold((l) => messageError(l.eerMessage), (r) => empEqrars(r));
    isLoading(false);
  }

  void clearControllers() {
    name.clear();
    report();
  }
}
