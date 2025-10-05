import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/model/emp_end_model.dart';
import '../../data/repository/emp_end_repository.dart';
import 'emp_end_controller.dart';

class EmpEndSearchReportController extends GetxController {
  final EmpEndRepository _repository;

  EmpEndSearchReportController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpEndReportModel> empEnds = <EmpEndReportModel>[].obs;

  get length => empEnds.length;

  final TextEditingController name = TextEditingController();

  Future<void> report() async {
    isLoading(true);
    messageError("");
    final data = await _repository.report(name: name.text);
    data.fold((l) => messageError(l.eerMessage), (r) => empEnds(r));
    isLoading(false);
  }

  void clearControllers() {
    name.clear();
    report();
  }
}
