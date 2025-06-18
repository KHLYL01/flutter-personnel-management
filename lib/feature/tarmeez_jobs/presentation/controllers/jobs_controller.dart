import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/jobs_model.dart';
import '../../data/repository/jobs_repository.dart';

class JobsController extends GetxController {
  final JobsRepository _repository;

  JobsController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<JobsModel> jobs = <JobsModel>[].obs;

  get length => jobs.length;

  final TextEditingController id = TextEditingController();
  final TextEditingController name = TextEditingController();

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.findAll();
    data.fold((l) => messageError(l.eerMessage), (r) => jobs(r));
    isLoading(false);
  }

  Future<void> findJobs() async {
    isLoading(true);
    messageError("");
    log(id.text);
    final data = await _repository.findJobs(
      id: id.text == "" ? null : int.parse(id.text),
      name: name.text,
    );
    data.fold((l) => messageError(l.eerMessage), (r) => jobs(r));
    isLoading(false);
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      JobsModel(
        id: int.parse(id.text),
        name: name.text,
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      findAll();
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  Future<void> delete(int id) async {
    isLoading(true);
    messageError("");
    final data = await _repository.delete(id);
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      findAll();
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  void clearControllers() {
    id.text = getId().toString();
    name.clear();
  }

  @override
  void onInit() async {
    await findAll();
    id.text = getId().toString();
    super.onInit();
  }

  void confirmDelete(int id, {bool withGoBack = true}) async {
    await alertDialog(
      title: 'تحذير',
      middleText: "هل تريد حذف الوظيفة بالفعل",
      onPressedConfirm: () {
        if (withGoBack) {
          Get.back();
        }
        delete(id);
      },
    );
  }

  // حل مبدأي
  int getId() {
    int max = 0;
    for (JobsModel m in jobs) {
      if (m.id! > max) {
        max = m.id!;
      }
    }
    return max + 1;
  }

  void fillControllers(Map<String, PlutoCell> cells) {
    id.text = cells['id']!.value.toString();
    name.text = cells['name']!.value.toString();
  }

  void clearControllersForSearch() {
    id.clear();
    name.clear();
  }
}
