import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/model/tafweed_model.dart';
import '../../data/repository/tafweed_repository.dart';

class TafweedSearchReportController extends GetxController {
  final TafweedRepository _repository;

  TafweedSearchReportController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<TafweedReportModel> tafweeds = <TafweedReportModel>[].obs;

  get length => tafweeds.length;

  RxBool all = false.obs;

  final TextEditingController empId = TextEditingController();
  final TextEditingController empName = TextEditingController();

  Future<void> search() async {
    isLoading(true);
    messageError("");
    final data = await _repository.report(
      empId: empId.text.isNotEmpty ? int.parse(empId.text) : null,
    );
    data.fold((l) => messageError(l.eerMessage), (r) => tafweeds(r));
    isLoading(false);
  }

  void clearControllers() {
    empId.clear();
    empName.clear();
    search();
  }
}
