import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/utils/helper_method.dart';
import 'package:personnel_management/feature/users/presentation/controllers/user_controller.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/actions_model.dart';
import '../../data/repository/actions_repository.dart';

class ActionsController extends GetxController {
  final ActionsRepository _repository;

  // myStatic1.UsersAction("حفظ انتداب باسم " + txtTask.Text + " جهة الانتداب " + txtPlace.Text + " المدة " + txtPeriod.Text + " تاريخ بداية الانتداب " + myStatic1.hd(datBegin));
  // myStatic1.UsersAction("تعديل انتداب باسم " + txtTask.Text + " جهة الانتداب " + txtPlace.Text + " المدة " + txtPeriod.Text + " تاريخ بداية الانتداب " + myStatic1.hd(datBegin));
  // myStatic1.UsersAction("حذف انتداب باسم " + txtTask.Text + " جهة الانتداب " + txtPlace.Text + " المدة " + txtPeriod.Text + " تاريخ بداية الانتداب " + myStatic1.hd(datBegin));
  // myStatic1.UsersAction("تعديل حسمية برقم قرار " + txtQrarID.Text + " تاريخ القرار " + myStatic.hd(datQrar) + " تاريخ بداية الحسم " + myStatic.hd(datBegin) + " تاريخ نهاية الحسم " + myStatic.hd(datEnd));
  // myStatic1.UsersAction("حفظ حسمية برقم قرار " + txtQrarID.Text + " تاريخ القرار " + myStatic.hd(datQrar) + " تاريخ بداية الحسم " + myStatic.hd(datBegin) + " تاريخ نهاية الحسم " + myStatic.hd(datEnd));
  // myStatic1.UsersAction("حذف حسمية برقم قرار " + txtQrarID.Text + " تاريخ القرار " + myStatic.hd(datQrar) + " تاريخ بداية الحسم " + myStatic.hd(datBegin) + " تاريخ نهاية الحسم " + myStatic.hd(datEnd));
  // myStatic1.UsersAction("حفظ إجازة بإسم " + txtEmpName.Text + " نوع الإجازة " + txtHolidayID.Text + " المدة " + txtPeriod.Text + " تاريخ بداية الإجازة " + myStatic.hd(datBegin));
  // myStatic1.UsersAction("تعديل إجازة بإسم " + txtEmpName.Text + " نوع الإجازة " + txtHolidayID.Text + " المدة " + txtPeriod.Text + " تاريخ بداية الإجازة " + myStatic.hd(datBegin));
  // myStatic1.UsersAction("حذف إجازة بإسم " + txtEmpName.Text + " نوع الإجازة " + txtHolidayName.Text + " المدة " + txtPeriod.Text + " تاريخ بداية الإجازة " + myStatic.hd(datBegin));
  // myStatic1.UsersAction("حفظ كشف طبي بإسم " + txtEmpName.Text + " بتاريخ " + myStatic.hd(datTalab) + " اسم الوحدة " + txtWehdaName.Text);
  // myStatic1.UsersAction("تعديل كشف طبي بإسم " + txtEmpName.Text + " بتاريخ " + myStatic.hd(datTalab) + " اسم الوحدة " + txtWehdaName.Text);
  // myStatic1.UsersAction("حذف كشف طبي بإسم " + txtEmpName.Text + " بتاريخ " + myStatic.hd(datTalab) + " اسم الوحدة " + txtWehdaName.Text);
  // myStatic1.UsersAction("تعديل خارج الدوام بإسم " + txtTask.Text + " القسم " + txtPlace.Text + " المدة " + txtPeriod.Text + " معدل الساعات " + txtHoursAvg.Text + " تاريخ البداية " + myStatic.hd(datBegin) + " تاريخ النهاية " + myStatic.hd(datEnd));
  // myStatic1.UsersAction("حفظ خارج الدوام بإسم " + txtTask.Text + " القسم " + txtPlace.Text + " المدة " + txtPeriod.Text + " معدل الساعات " + txtHoursAvg.Text + " تاريخ البداية " + myStatic.hd(datBegin) + " تاريخ النهاية " + myStatic.hd(datEnd));
  // myStatic1.UsersAction("حذف خارج الدوام بإسم " + txtTask.Text + " القسم " + txtPlace.Text + " المدة " + txtPeriod.Text + " معدل الساعات " + txtHoursAvg.Text + " تاريخ البداية " + myStatic.hd(datBegin) + " تاريخ النهاية " + myStatic.hd(datEnd));
  // myStatic1.UsersAction("حفظ مباشرة بإسم " + txtEmpName.Text + " مدة الإجازة " + txtPeriod.Text + " تاريخ بداية الإجازة " + myStatic.hd(datHolidayBegin) + " تاريخ مباشرة العمل " + myStatic.hd(datHolidayEnd));
  // myStatic1.UsersAction("تعديل مباشرة بإسم " + txtEmpName.Text + " مدة الإجازة " + txtPeriod.Text + " تاريخ بداية الإجازة " + myStatic.hd(datHolidayBegin) + " تاريخ مباشرة العمل " + myStatic.hd(datHolidayEnd));
  // myStatic1.UsersAction("حذف مباشرة بإسم " + txtEmpName.Text + " مدة الإجازة " + txtPeriod.Text + " تاريخ بداية الإجازة " + myStatic.hd(datHolidayBegin) + " تاريخ مباشرة العمل " + myStatic.hd(datHolidayEnd));
  // myStatic1.UsersAction("حفظ خارج الدوام بإسم " + txtTask.Text + " القسم " + txtPlace.Text + " المدة " + txtPeriod.Text + " معدل الساعات " + txtHoursAvg.Text + " تاريخ البداية " + myStatic1.hd(datBegin) + " تاريخ النهاية " + myStatic1.hd(datEnd));
  // myStatic1.UsersAction("تعديل خارج الدوام بإسم " + txtTask.Text + " القسم " + txtPlace.Text + " المدة " + txtPeriod.Text + " معدل الساعات " + txtHoursAvg.Text + " تاريخ البداية " + myStatic1.hd(datBegin) + " تاريخ النهاية " + myStatic1.hd(datEnd));
  // myStatic1.UsersAction("حذف خارج الدوام بإسم " + txtTask.Text + " القسم " + txtPlace.Text + " المدة " + txtPeriod.Text + " معدل الساعات " + txtHoursAvg.Text + " تاريخ البداية " + myStatic1.hd(datBegin) + " تاريخ النهاية " + myStatic1.hd(datEnd));
  // myStatic1.UsersAction("حفظ موظف باسم " + txtName.Text + " القسم " + txtPArtName.Text + " المسمى الوظيفي " + txtJobName.Text + " نوع الوظيفة " + cmType.SelectedItem.ToString());

  ActionsController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<ActionsModel> actions = <ActionsModel>[].obs;

  get length => actions.length;

  final TextEditingController id = TextEditingController();
  final TextEditingController action = TextEditingController();
  final TextEditingController fromDate =
      TextEditingController(text: nowHijriDate());
  final TextEditingController toDate =
      TextEditingController(text: nowHijriDate());

  RxBool all = true.obs;

  RxString type = "".obs;
  List<String> types = [
    "",
    "موظف",
    "انتداب",
    "تكليف",
    "إجازة",
    "كشف طبي",
    "مباشرة",
  ];

  RxString username = "".obs;
  List<String> usernames = [];

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.search(
      id: id.text.isNotEmpty ? int.parse(id.text) : null,
      username: username.value,
      type: type.value,
      action: action.text,
      all: all.value,
      fromDate: hijriToGreg(fromDate.text)
          .toIso8601String()
          .substring(0, 10)
          .replaceAll("/", "-"),
      toDate: hijriToGreg(toDate.text)
          .toIso8601String()
          .substring(0, 10)
          .replaceAll("/", "-"),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => actions(r));
    isLoading(false);
  }

  Future<void> save(String action) async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      ActionsModel(
        username: Get.find<UserController>().userEmpName,
        action: action,
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  clearControllers() {
    id.clear();
    type("");
    username.value = "";
    action.clear();
    all(true);
    fromDate.text = nowHijriDate();
    toDate.text = nowHijriDate();
  }

  void onChangeUsername(String? value) {
    username.value = value ?? "";
  }

  void onChangeType(String? value) {
    type.value = value ?? "";
  }
}
