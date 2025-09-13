import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/constants/app_routes.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/core/widgets/base_screen.dart';
import 'package:personnel_management/feature/user_signature/presentation/controllers/signature_controller.dart';
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

  bool isAdmin = false;
  int userId = 0;
  String userEmpName = "";
  String userPassword = "";

  final TextEditingController id = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController empName = TextEditingController();

  RxList<UserModel> users = <UserModel>[].obs;

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
        username.text = e.username.getValue();
        password.text = e.password.getValue();
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
    ScreenPermission(group: "الترميز", screenName: "أنواع الإجازات"),

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
      Get.find<SignatureController>().users = users;
      Get.find<SignatureController>().usersEmpName
        ..clear()
        ..add("الكل");
      Get.find<SignatureController>()
          .usersEmpName
          .addAll(users.map((e) => e.empName).cast<String>().toList());
    });
    isLoading(false);
    if (messageError.isEmpty) {
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  Future<void> findAllByUserId(int id, {bool login = false}) async {
    UserModel? userModel;

    final data = await _repository.findById(id);
    data.fold((l) => messageError(l.eerMessage), (r) => userModel = r);

    if (userModel == null) {
      customSnackBar(
          title: 'خطأ', message: "المستخدم غير موجود", isDone: false);
      return;
    }

    if (login) {
      loginUserPermissions.clear();

      for (UserPermissionModel e in userModel?.userPermissions ?? []) {
        loginUserPermissions.add(
          ScreenPermission(
            group: "",
            screenName: e.permission ?? "",
            enter: true,
            save: e.save ?? false,
            edit: e.edit ?? false,
            delete: e.del ?? false,
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
    for (UserPermissionModel e in userModel?.userPermissions ?? []) {
      for (var p in permissions) {
        if (e.permission == p.screenName) {
          p.canEnter.value = true;
          p.canSave.value = e.save ?? false;
          p.canEdit.value = e.edit ?? false;
          p.canDelete.value = e.del ?? false;
          break;
        }
      }
    }
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

    if (username.text == "" || empName.text == "" || password.text == "") {
      customSnackBar(
          title: 'خطأ', message: "يرجى إعادة المحاولة لاحقا", isDone: false);
      return;
    }
    isLoading(true);
    messageError("");

    List<UserPermissionModel> userPermissions = [];

    for (var element in permissions) {
      if (element.canEnter.value) {
        userPermissions.add(
          UserPermissionModel(
            permission: element.screenName,
            save: element.canSave.value,
            edit: element.canEdit.value,
            del: element.canDelete.value,
          ),
        );
      }
    }

    UserModel model = UserModel(
      id: id.text.isEmpty ? null : int.parse(id.text),
      username: username.text,
      password: password.text,
      empName: empName.text,
      userPermissions: userPermissions,
    );

    final data = await _repository.save(model);
    data.fold((l) => messageError(l.eerMessage),
        (r) => id.text = (r.id ?? 0).toString());
    isLoading(false);
    if (messageError.isEmpty) {
      await findAll();
      customSnackBar(title: 'تم', message: 'تمت العملية بنجاح');
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
    final data = await _repository.delete(int.parse(id.text));
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      userName.value = '';
      id.clear();
      username.clear();
      password.clear();
      empName.clear();
      findAll();
      customSnackBar(title: 'تم', message: 'تم الحذف بنجاح');
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
    isAdmin = false;
    // for admin
    if (username.text.trim() == "administrator" &&
        password.text.trim() == "advancedtech1433") {
      // if (username.text.trim() == "" && password.text.trim() == "") {
      isAdmin = true;
      Get.offNamed(AppRoutes.home);
      username.clear();
      password.clear();
      Get.find<SignatureController>().findAll();
      return;
    }

    // for users
    for (var e in users) {
      if (username.text.trim() == e.username &&
          password.text.trim() == e.password) {
        userId = e.id ?? 0;
        userEmpName = e.empName ?? "";
        userPassword = e.password ?? "";

        await findAllByUserId(e.id ?? 00, login: true);
        Get.offNamed(AppRoutes.home);
        username.clear();
        password.clear();
        Get.find<SignatureController>().findByUserId(userId);
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
    //for develop
    // return true;
    if (isAdmin) return true;
    if (pageName == "pdfViewer") return true;
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

  clearController() {
    id.clear();
    username.clear();
    password.clear();
    empName.clear();

    userName.value = '';

    canEnter.value = false;
    canSave.value = false;
    canEdit.value = false;
    canDelete.value = false;

    for (var p in permissions) {
      p.canEnter.value = false;
      p.canSave.value = false;
      p.canEdit.value = false;
      p.canDelete.value = false;
    }
  }
}
