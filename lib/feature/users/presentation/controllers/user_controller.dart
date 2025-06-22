import 'dart:developer';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/constants/app_routes.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/core/widgets/base_screen.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/screen_permission.dart';
import '../../data/model/user_model.dart';
import '../../data/repository/user_repository.dart';

class UserController extends GetxController {
  final UserRepository _repository;

  UserController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  final TextEditingController id = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController empName = TextEditingController();

  RxList<UserDtoModel> users = <UserDtoModel>[].obs;

  RxString userName = ''.obs;
  List<String> usersName = [''];

  RxBool canEnter = false.obs;
  RxBool canSave = false.obs;
  RxBool canEdit = false.obs;
  RxBool canDelete = false.obs;

  void onChangeUserName(String? value) {
    userName.value = value ?? '';
    for (var e in users) {
      if (e.empName == userName.value) {
        id.text = e.id.getValue();
        name.text = e.name.getValue();
        pass.text = e.pass.getValue();
        empName.text = e.empName.getValue();
        findAllByUserId(e.id ?? 0);
        canEnter.value = false;
        canSave.value = false;
        canEdit.value = false;
        canDelete.value = false;
      }
    }
  }

  RxList<ScreenPermission> permissions = <ScreenPermission>[
    // الإعداد والتجهيز
    // ScreenPermission(group: "الإعداد والتجهيز", screenName: "شكل البرنامج"),
    ScreenPermission(group: "الإعداد والتجهيز", screenName: "المستخدمين"),
    // ScreenPermission(group: "الإعداد والتجهيز", screenName: "شاشة المراقبة"),
    // ScreenPermission(group: "الإعداد والتجهيز", screenName: "عمل نسخة إحتياطية"),
    // ScreenPermission(group: "الإعداد والتجهيز", screenName: "إسترجاع نسخة إحتياطية"),
    // ScreenPermission(group: "الإعداد والتجهيز", screenName: "اخلاء النظام"),
    // ScreenPermission(group: "الإعداد والتجهيز", screenName: "ترحيل البيانات القديمة"),
    // ScreenPermission(group: "الإعداد والتجهيز", screenName: "بطاقات العيد"),

    // الترميز
    ScreenPermission(group: "الترميز", screenName: "بيانات البلدية"),
    ScreenPermission(group: "الترميز", screenName: "أنواع الوظائف"),
    ScreenPermission(group: "الترميز", screenName: "بدل الانتداب"),
    ScreenPermission(group: "الترميز", screenName: "انواع الجنسيات"),
    ScreenPermission(group: "الترميز", screenName: "أنواع المخالفات"),
    ScreenPermission(group: "الترميز", screenName: "أنواع الأقسام"),
    ScreenPermission(group: "الترميز", screenName: "سلم درجات الموظفين"),
    ScreenPermission(group: "الترميز", screenName: "سلم درجات العمال"),
    ScreenPermission(
        group: "الترميز", screenName: "تصنيف الدول حسب فئات البدل"),

    // الموظفين / العاملين
    ScreenPermission(
        group: "الموظفين / العاملين", screenName: "بيانات الوظائف الأساسية"),
    ScreenPermission(
        group: "الموظفين / العاملين", screenName: "بيانات الإنتداب"),
    ScreenPermission(
        group: "الموظفين / العاملين", screenName: "بيانات خارح دوام"),
    ScreenPermission(
        group: "الموظفين / العاملين", screenName: "بيانات الحسميات"),
    ScreenPermission(
        group: "الموظفين / العاملين", screenName: "بيانات المخالفات"),
    ScreenPermission(
        group: "الموظفين / العاملين", screenName: "بيانات الإجازات"),
    ScreenPermission(
        group: "الموظفين / العاملين", screenName: "بيان دورة موظف"),
    ScreenPermission(group: "الموظفين / العاملين", screenName: "طلب كشف طبي"),
    ScreenPermission(group: "الموظفين / العاملين", screenName: "قرار مباشرة"),
    ScreenPermission(group: "الموظفين / العاملين", screenName: "إقرار موظف"),
    ScreenPermission(group: "الموظفين / العاملين", screenName: "ترقية موظف"),
    ScreenPermission(group: "الموظفين / العاملين", screenName: "إنهاء خدمة"),
    ScreenPermission(group: "الموظفين / العاملين", screenName: "قرار تعيين"),
    ScreenPermission(group: "الموظفين / العاملين", screenName: "العلاوات"),
    ScreenPermission(
        group: "الموظفين / العاملين", screenName: "إقرار استلام جواز سفر"),
    ScreenPermission(group: "الموظفين / العاملين", screenName: "تفويض"),
    ScreenPermission(
        group: "الموظفين / العاملين", screenName: "بيانات الموظفين"),
    ScreenPermission(
        group: "الموظفين / العاملين", screenName: "بيان خدمات موظف"),
    ScreenPermission(
        group: "الموظفين / العاملين", screenName: "طباعة بيان خدمات موظف"),
    // 📥 الطلبات
    // ScreenPermission(group: "الطلبات", screenName: "طلبات الإجازة"),
    // ScreenPermission(group: "الطلبات", screenName: "متابعة طلبات الاجازة"),
    // ScreenPermission(group: "الطلبات", screenName: "ترحيل رصيد الأجازات"),

    // البحث و الإستعلام
    ScreenPermission(
        group: "البحث و الإستعلام", screenName: "الإستعلام عن موظف"),
    ScreenPermission(
        group: "البحث و الإستعلام", screenName: "الإستعلام عن إنتداب"),
    ScreenPermission(
        group: "البحث و الإستعلام", screenName: "الإستعلام عن خارح دوام"),
    ScreenPermission(
        group: "البحث و الإستعلام", screenName: "الإستعلام عن حسميات"),
    ScreenPermission(
        group: "البحث و الإستعلام", screenName: "الإستعلام عن مخالفات"),
    ScreenPermission(
        group: "البحث و الإستعلام", screenName: "الإستعلام عن إجازة"),
    ScreenPermission(
        group: "البحث و الإستعلام", screenName: "الإستعلام عن الدورات"),
    ScreenPermission(
        group: "البحث و الإستعلام", screenName: "الإستعلام عن كشف طبي"),
    ScreenPermission(
        group: "البحث و الإستعلام", screenName: "الإستعلام عن مباشرة"),
    ScreenPermission(
        group: "البحث و الإستعلام", screenName: "الاستعلام عن إقرار"),
    ScreenPermission(
        group: "البحث و الإستعلام", screenName: "الاستعلام عن ترقية"),
    ScreenPermission(
        group: "البحث و الإستعلام", screenName: "الاستعلام عن إنهاء خدمة"),
    ScreenPermission(
        group: "البحث و الإستعلام", screenName: "الاستعلام عن قرار تعيين"),
    ScreenPermission(
        group: "البحث و الإستعلام", screenName: "الاستعلام عن علاوة"),
    ScreenPermission(
        group: "البحث و الإستعلام", screenName: "الاستعلام عن إقرار جواز سفر"),
    ScreenPermission(
        group: "البحث و الإستعلام", screenName: "الاستعلام عن تفويض"),

    // التقارير و الطباعة
    ScreenPermission(group: "التقارير و الطباعة", screenName: "مسير الرواتب"),
    // ScreenPermission(group: "التقارير", screenName: "تقرير الإنتدابات"),
    // ScreenPermission(group: "التقارير", screenName: "تقرير خارح دوام"),
    // ScreenPermission(group: "التقارير", screenName: "تقرير الحسميات"),
    // ScreenPermission(group: "التقارير", screenName: "تقرير المخالفات"),
    // ScreenPermission(group: "التقارير", screenName: "تقرير الإجازات"),
    // ScreenPermission(group: "التقارير", screenName: "تقرير الكشف الطبي"),
    // ScreenPermission(group: "التقارير", screenName: "تقرير المباشرة"),
    // ScreenPermission(group: "التقارير", screenName: "تقرير بيانات الموظفين"),
    // ScreenPermission(group: "التقارير", screenName: "تقرير تفصيلي للموظف"),
    // ScreenPermission(group: "التقارير", screenName: "التقرير الإحصائي لمستخدم"),
    // ScreenPermission(group: "التقارير", screenName: "تقرير التفويض"),
    // ScreenPermission(group: "التقارير", screenName: "تقرير إنهاء الخدمة"),
    // ScreenPermission(group: "التقارير", screenName: "تقرير الإقرار"),
  ].obs;
  RxList<ScreenPermission> loginUserPermissions = <ScreenPermission>[].obs;

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.findAllUsers();
    data.fold((l) => messageError(l.eerMessage), (r) {
      usersName = [''];
      for (var e in r) {
        usersName.add(e.empName ?? "");
      }
      users.value = r;
    });
    isLoading(false);
    if (messageError.isEmpty) {
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  Future<void> getNext() async {
    final data = await _repository.getNext();
    data.fold((l) => messageError(l.eerMessage), (r) {
      id.text = r.getValue();
    });
  }

  Future<void> findAllByUserId(int id, {bool login = false}) async {
    isLoading(true);
    messageError("");
    final data = await _repository.findAllById(id);
    data.fold((l) => messageError(l.eerMessage), (r) {
      if (login) {
        for (var e in r) {
          loginUserPermissions.add(
            ScreenPermission(
              group: "",
              screenName: e.key?.menus ?? "",
              enter: true,
              save: (e.save ?? 0) == 1,
              edit: (e.edit ?? 0) == 1,
              delete: (e.del ?? 0) == 1,
            ),
          );
        }
        return;
      }

      // for users page
      for (var p in permissions) {
        p.canEnter.value = false;
        p.canSave.value = false;
        p.canEdit.value = false;
        p.canDelete.value = false;
      }
      for (var e in r) {
        for (var p in permissions) {
          if (e.key?.menus == p.screenName) {
            p.canEnter.value = true;
            p.canSave.value = (e.save ?? 0) == 1;
            p.canEdit.value = (e.edit ?? 0) == 1;
            p.canDelete.value = (e.del ?? 0) == 1;
            break;
          }
        }
      }
    });
    isLoading(false);
    if (messageError.isEmpty) {
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  Future<void> save() async {
    if (!checkPermission(Get.find<BaseController>().page.value, save: true)) {
      alertDialog(
        title: 'تنبيه',
        middleText: "       ليس لديك صلاحية الإضافة       ",
        withoutButton: true,
        onPressedConfirm: () {
          Get.back();
        },
      );
      return;
    }

    if (id.text == "" ||
        name.text == "" ||
        empName.text == "" ||
        pass.text == "") {
      customSnackBar(
          title: 'خطأ', message: "يرجى إعادة المحاولة لاحقا", isDone: false);
      return;
    }
    isLoading(true);
    messageError("");

    List<UserModel> permUser = [];
    for (var element in permissions) {
      if (element.canEnter.value) {
        permUser.add(
          UserModel(
            key: KeyModel(
              id: int.parse(id.text),
              menus: element.screenName,
            ),
            name: name.text,
            pass: pass.text,
            empName: empName.text,
            save: element.canSave.value ? 1 : 0,
            edit: element.canEdit.value ? 1 : 0,
            del: element.canDelete.value ? 1 : 0,
          ),
        );
      }
    }

    final data = await _repository.saveAllForUserId(permUser);
    data.fold((l) => messageError(l.eerMessage), (r) => fillControllers(r));
    isLoading(false);
    if (messageError.isEmpty) {
      userName.value = '';
      await getNext();
      name.clear();
      pass.clear();
      empName.clear();
      await findAll();
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  Future<void> delete() async {
    if (id.text == "") {
      customSnackBar(
          title: 'خطأ',
          message: "يرجى اختيار مستخدم وإعادة المحاولة لاحقا",
          isDone: false);
      return;
    }

    isLoading(true);
    messageError("");
    final data = await _repository.deleteAllByUserId(int.parse(id.text));
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      userName.value = '';
      await getNext();
      name.clear();
      pass.clear();
      empName.clear();
      findAll();
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  void confirmDelete() async {
    if (!checkPermission(Get.find<BaseController>().page.value, delete: true)) {
      alertDialog(
        title: 'تنبيه',
        middleText: "       ليس لديك صلاحية الحذف       ",
        withoutButton: true,
        onPressedConfirm: () {
          Get.back();
        },
      );
      return;
    }
    await alertDialog(
      title: 'تحذير',
      middleText: "هل تريد حذف المستخدم بالفعل",
      onPressedConfirm: () {
        Get.back();
        delete();
      },
    );
  }

  void fillControllers(List<UserModel> list) {}

  clearControllers() async {}

  onSaveAll(bool val) {
    canSave(val);
    for (var element in permissions) {
      element.canSave.value = val;
    }
  }

  onEnterAll(bool val) {
    canEnter(val);
    for (var element in permissions) {
      element.canEnter.value = val;
    }
  }

  onEditAll(bool val) {
    canEdit(val);
    for (var element in permissions) {
      element.canEdit.value = val;
    }
  }

  onDeleteAll(bool val) {
    canDelete(val);
    for (var element in permissions) {
      element.canDelete.value = val;
    }
  }

  login() async {
    // for admin
    if (name.text.trim() == "administrator" &&
        pass.text.trim() == "advancedtech1433") {
      for (var e in permissions) {
        loginUserPermissions.add(
          ScreenPermission(
            group: "",
            screenName: e.screenName,
            enter: true,
            save: true,
            edit: true,
            delete: true,
          ),
        );
      }
      Get.offNamed(AppRoutes.home);
      name.clear();
      pass.clear();
      return;
    }

    // for users
    for (var e in users) {
      if (name.text.trim() == e.name && pass.text.trim() == e.pass) {
        await findAllByUserId(e.id ?? 00, login: true);
        Get.offNamed(AppRoutes.home);
        name.clear();
        pass.clear();
        return;
      }
    }
    await alertDialog(
      title: 'تنبيه',
      middleText:
          "      المستخدم الذي تريد الدخول به غير موجود, من فضلك تأكد من الاسم و كلمة المرور      ",
      withoutButton: true,
      onPressedConfirm: () {
        Get.back();
      },
    );
  }

  bool checkPermission(
    String pageName, {
    bool enter = false,
    bool save = false,
    bool update = false,
    bool delete = false,
  }) {
    log("pageName: $pageName");
    for (var e in loginUserPermissions) {
      if (e.screenName == pageName) {
        if (enter && e.canEnter.value) return true;
        if (save && e.canSave.value) return true;
        if (update && e.canEdit.value) return true;
        if (delete && e.canDelete.value) return true;
      }
    }
    return false;
  }
}
