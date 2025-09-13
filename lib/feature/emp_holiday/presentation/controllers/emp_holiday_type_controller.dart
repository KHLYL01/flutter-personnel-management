import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/emp_holiday_type_model.dart';
import '../../data/repository/emp_holiday_type_repository.dart';

class EmpHolidayTypeController extends GetxController {
  final EmpHolidayTypeRepository _repository;

  EmpHolidayTypeController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpHolidayTypeModel> empHolidaysType = <EmpHolidayTypeModel>[].obs;

  get length => empHolidaysType.length;

  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();

  Future<void> findAll() async {
    clearControllers();
    isLoading(true);
    messageError("");
    final data = await _repository.findAll();
    data.fold((l) => messageError(l.eerMessage), (r) {
      empHolidaysType(r);
      id.text = getId().toString();
    });
    isLoading(false);
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpHolidayTypeModel(
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

  @override
  void onInit() {
    findAll();
    super.onInit();
  }

  void clearControllers() {
    id.text = getId().toString();
    name.clear();
  }

  void confirmDelete(int id, {bool withGoBack = true}) async {
    await alertDialog(
      title: 'تحذير',
      middleText: "هل تريد حذف الإجازة بالفعل",
      onPressedConfirm: () {
        if (withGoBack) {
          Get.back();
        }
        delete(id);
      },
    );
  }

  // // حل مبدأي
  int getId() {
    int max = 0;
    for (EmpHolidayTypeModel m in empHolidaysType) {
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
}
