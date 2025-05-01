import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:personnel_management/feature/tafweed/presentation/controllers/tafweed_search_controller.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/tafweed_model.dart';
import '../../data/repository/tafweed_repository.dart';

class TafweedController extends GetxController {
  final TafweedRepository _repository;

  TafweedController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  // for add

  final TextEditingController id = TextEditingController();
  final TextEditingController empId = TextEditingController();
  final TextEditingController empName = TextEditingController();
  final TextEditingController subject = TextEditingController();
  final TextEditingController note = TextEditingController();
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();

  RxString selectedDay = 'الأحد'.obs;

  final List<String> dayList = [
    'الأحد',
    'الأثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
  ];

  void onChangedDay(String? value) {
    selectedDay(value!);
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      TafweedModel(
        id: id.text != ""
            ? int.parse(id.text)
            : await Get.find<TafweedSearchController>().getId(),
        day: selectedDay.value,
        empId: empId.text == "" ? null : int.parse(empId.text),
        endDate: endDate.text,
        note: note.text,
        startDate: startDate.text,
        subject: subject.text,
        // computerName: ,
        // computerUser: ,
        // inputDate: ,
        // programUser: ,
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => fillControllers(r));
    isLoading(false);
    if (messageError.isEmpty) {
      Get.find<TafweedSearchController>().findAll();
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
      Get.find<TafweedSearchController>().findAll();
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  void clearControllers() {
    id.clear();
    empId.clear();
    empName.clear();
    subject.clear();
    selectedDay("الأحد");
    note.clear();
    startDate.clear();
    endDate.clear();
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

  void fillControllers(TafweedModel model) {
    id.text = model.id.toString();
    empId.text = model.empId.toString();
    subject.text = model.subject!;
    // selectedDay(model.day);
    startDate.text = model.startDate!;
    endDate.text = model.endDate!;
    note.text = model.note!;
  }
}
