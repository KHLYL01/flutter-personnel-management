import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:personnel_management/feature/tarmeez_bladia_info/data/model/bladia_info_model.dart';
import 'package:personnel_management/feature/tarmeez_bladia_info/data/repository/bladia_info_repository.dart';
import '../../../../../core/functions/image_picker.dart';
import '../../../../core/functions/custom_snack_bar.dart';

class BladiaInfoController extends GetxController {
  final BladiaInfoRepository _repository;

  BladiaInfoController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  Rx<BladiaInfoModel> bladia = Rx(BladiaInfoModel());

  final TextEditingController name = TextEditingController();
  final TextEditingController boss = TextEditingController();
  final TextEditingController bossAssistant = TextEditingController();
  final TextEditingController edariaBoss = TextEditingController();
  final TextEditingController partBoss = TextEditingController();
  final TextEditingController part2Boss = TextEditingController();
  final TextEditingController maliaBoss = TextEditingController();
  final TextEditingController emp = TextEditingController();
  final TextEditingController empHelp = TextEditingController();
  final TextEditingController ma3esha = TextEditingController();
  final TextEditingController workStationBoss = TextEditingController();
  final TextEditingController ipan = TextEditingController();
  final TextEditingController datBegin = TextEditingController();
  final TextEditingController datEnd = TextEditingController();

  final TextEditingController amana = TextEditingController();

  var municipalitySymbol = ''.obs;

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.findAll();
    data.fold((l) => messageError(l.eerMessage), (r) => bladia(r));
    fillController();
    isLoading(false);
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      BladiaInfoModel(
        bladiaInfo: Bladia(
          id: 1,
          amana: amana.text,
          boss: boss.text,
          bossAssistant: bossAssistant.text,
          ipan: ipan.text,
          nameAr: name.text,
          datEnd: datEnd.text,
          datBegin: datBegin.text,
        ),
        empPartInfo: EmpPartInfo(
          id: 1,
          emp: emp.text,
          edariaBoss: edariaBoss.text,
          empHelp: empHelp.text,
          ma3esha: ma3esha.text == "" ? 0 : int.parse(ma3esha.text),
          maliaBoss: maliaBoss.text,
          part2Boss: part2Boss.text,
          partBoss: partBoss.text,
          workStationBoss: workStationBoss.text,
        ),
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    if (messageError.isEmpty) {
      customSnackBar(title: 'تم', message: 'تمت العملية بنجاح');
    }
    isLoading(false);
  }

  void pickImage() async {
    final picker = WebImagePicker();
    final image = await picker.pickImage();

    if (image != null) {
      municipalitySymbol.value = image;
    }
  }

  void fillController() {
    name.text = bladia.value.bladiaInfo?.nameAr ?? '';
    boss.text = bladia.value.bladiaInfo?.boss ?? '';
    ipan.text = bladia.value.bladiaInfo?.ipan ?? '';
    amana.text = bladia.value.bladiaInfo?.amana ?? '';
    datBegin.text = bladia.value.bladiaInfo?.datBegin ?? '';
    datEnd.text = bladia.value.bladiaInfo?.datEnd ?? '';

    workStationBoss.text = bladia.value.empPartInfo?.workStationBoss ?? '';
    bossAssistant.text = bladia.value.bladiaInfo?.bossAssistant ?? '';
    edariaBoss.text = bladia.value.empPartInfo?.edariaBoss ?? '';
    partBoss.text = bladia.value.empPartInfo?.partBoss ?? '';
    part2Boss.text = bladia.value.empPartInfo?.part2Boss ?? '';
    maliaBoss.text = bladia.value.empPartInfo?.maliaBoss ?? '';
    emp.text = bladia.value.empPartInfo?.emp ?? '';
    empHelp.text = bladia.value.empPartInfo?.empHelp ?? '';
    ma3esha.text = bladia.value.empPartInfo?.ma3esha.toString() ?? '';
  }

  @override
  void onInit() {
    findAll();
    super.onInit();
  }
}
