import 'package:get/get.dart';

import '../../data/model/emp_holiday_type_model.dart';

class EmpHolidayTypeController extends GetxController {
  List<EmpHolidayTypeModel> empHolidaysType = [
    EmpHolidayTypeModel(id: 0, name: "إعتيادية سنوى"),
    EmpHolidayTypeModel(id: 1, name: "إضطرارية"),
    EmpHolidayTypeModel(id: 2, name: "إستثنائية"),
    EmpHolidayTypeModel(id: 3, name: "تعويض"),
    EmpHolidayTypeModel(id: 4, name: "مرضية"),
    EmpHolidayTypeModel(id: 5, name: "مرافق"),
    EmpHolidayTypeModel(id: 6, name: "اعتيادية مفرقة"),
    EmpHolidayTypeModel(id: 7, name: "امومة (وضع)"),
    EmpHolidayTypeModel(id: 9, name: "إعتيادى مرحل"),
    EmpHolidayTypeModel(id: 10, name: "إعتيادى قديم"),
    EmpHolidayTypeModel(id: 11, name: "إجازة الأبوة"),
    EmpHolidayTypeModel(id: 12, name: "إجازة الوفاة"),
    EmpHolidayTypeModel(id: 13, name: "إجازة الوضع"),
    EmpHolidayTypeModel(id: 14, name: "إجازة الامتحانات"),
    EmpHolidayTypeModel(id: 15, name: "الإجازة الخطيرة"),
    EmpHolidayTypeModel(id: 16, name: "وقوع الكارثة"),
  ];

  // final EmpHolidayTypeRepository _repository;

  // EmpHolidayTypeController(this._repository);

  // RxString messageError = "".obs;
  // RxBool isLoading = false.obs;

  // RxList<EmpHolidayTypeModel> empHolidaysType = <EmpHolidayTypeModel>[].obs;

  // get length => empHolidaysType.length;

  // TextEditingController id = TextEditingController();
  // TextEditingController name = TextEditingController();

  // Future<void> findAll() async {
  //   clearControllers();
  //   isLoading(true);
  //   messageError("");
  //   final data = await _repository.findAll();
  //   data.fold((l) => messageError(l.eerMessage), (r) {
  //     empHolidaysType(r);
  //     id.text = getId().toString();
  //   });
  //   isLoading(false);
  // }
  //
  // Future<void> save() async {
  //   isLoading(true);
  //   messageError("");
  //   final data = await _repository.save(
  //     EmpHolidayTypeModel(
  //       id: int.parse(id.text),
  //       name: name.text,
  //     ),
  //   );
  //   data.fold((l) => messageError(l.eerMessage), (r) => r);
  //   isLoading(false);
  //   if (messageError.isEmpty) {
  //     findAll();
  //     return;
  //   }
  //   customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  // }
  //
  // Future<void> delete(int id) async {
  //   isLoading(true);
  //   messageError("");
  //   final data = await _repository.delete(id);
  //   data.fold((l) => messageError(l.eerMessage), (r) => r);
  //   isLoading(false);
  //   if (messageError.isEmpty) {
  //     findAll();
  //     return;
  //   }
  //   customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  // }
  //
  // @override
  // void onInit() {
  //   findAll();
  //   super.onInit();
  // }
  //
  // void clearControllers() {
  //   id.text = getId().toString();
  //   name.clear();
  // }
  //
  // void confirmDelete(int id, {bool withGoBack = true}) async {
  //   await alertDialog(
  //     title: 'تحذير',
  //     middleText: "هل تريد حذف الإجازة بالفعل",
  //     onPressedConfirm: () {
  //       if (withGoBack) {
  //         Get.back();
  //       }
  //       delete(id);
  //     },
  //   );
  // }
  //
  // // // حل مبدأي
  // int getId() {
  //   int max = 0;
  //   for (EmpHolidayTypeModel m in empHolidaysType) {
  //     if (m.id! > max) {
  //       max = m.id!;
  //     }
  //   }
  //   return max + 1;
  // }
  //
  // void fillControllers(Map<String, PlutoCell> cells) {
  //   id.text = cells['id']!.value.toString();
  //   name.text = cells['name']!.value.toString();
  // }
}
