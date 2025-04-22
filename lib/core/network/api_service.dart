import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../feature/emp_dowra/data/model/emp_dowra_model.dart';
import '../../feature/emp_end/data/model/emp_end_model.dart';
import '../../feature/emp_entedab/data/model/emp_entedab_model.dart';
import '../../feature/emp_eqrar/data/model/emp_eqrar_model.dart';
import '../../feature/emp_hasmiat/data/model/emp_hasmiat_model.dart';
import '../../feature/emp_holiday/data/model/emp_holiday_model.dart';
import '../../feature/emp_holiday/data/model/emp_holiday_type_model.dart';
import '../../feature/emp_kashf_tepy/data/model/emp_kashf_tepy_model.dart';
import '../../feature/emp_mobashra/data/model/emp_mobashra_model.dart';
import '../../feature/emp_mokhalfat/data/model/emp_mokhalfat_model.dart';
import '../../feature/emp_overtime/data/model/emp_overtime_model.dart';
import '../../feature/emp_taeen/data/model/emp_taeen_model.dart';
import '../../feature/emp_tarqea/data/model/emp_tarqea_model.dart';
import '../../feature/employee/data/model/employee_model.dart';
import '../../feature/passport/data/model/passport_model.dart';
import '../../feature/tafweed/data/model/tafweed_model.dart';
import '../../feature/tarmeez_badal/data/model/badal_model.dart';
import '../../feature/tarmeez_badal_countries/data/model/badal_countries_model.dart';
import '../../feature/tarmeez_dissent/data/model/dissent_model.dart';
import '../../feature/tarmeez_emp_degrees/data/model/emp_degrees_model.dart';
import '../../feature/tarmeez_emp_degrees_worker/data/model/emp_degrees_worker_model.dart';
import '../../feature/tarmeez_jobs/data/model/jobs_model.dart';
import '../../feature/tarmeez_nations/data/model/nations_model.dart';
import '../../feature/tarmeez_parts/data/model/parts_model.dart';
import 'api_constants.dart';
import '../../feature/tarmeez_bladia_info/data/model/bladia_info_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: baseURL)
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  //*
  //* Bladia api
  //*
  @GET(bladias)
  Future<HttpResponse<BladiaInfoModel>> findAllBladias();

  @POST(bladias)
  Future<HttpResponse<void>> saveBladia(
      @Body(nullToAbsent: true) BladiaInfoModel baladeaModel);

  //*
  //* Nations api
  //*
  @GET(nations)
  Future<HttpResponse<List<NationsModel>>> findAllNations();

  @GET("$nations/find")
  Future<HttpResponse<List<NationsModel>>> findNations(
    @Query("id") int? id,
    @Query("name") String? name,
  );

  @POST(nations)
  Future<HttpResponse<NationsModel>> saveNations(
      @Body(nullToAbsent: true) NationsModel nationsModel);

  @PUT("$nations/{id}")
  Future<HttpResponse<NationsModel>> updateNations(
      @Path("id") int id, @Body(nullToAbsent: true) NationsModel nationsModel);

  @DELETE("$nations/{id}")
  Future<HttpResponse<void>> deleteNations(@Path("id") int id);

  //*
  //* Parts api
  //*
  @GET(parts)
  Future<HttpResponse<List<PartsModel>>> findAllParts();

  @GET("$parts/find")
  Future<HttpResponse<List<PartsModel>>> findParts(
    @Query("id") int? id,
    @Query("name") String? name,
  );

  @POST(parts)
  Future<HttpResponse<PartsModel>> saveParts(
      @Body(nullToAbsent: true) PartsModel partsModel);

  @PUT("$parts/{id}")
  Future<HttpResponse<PartsModel>> updateParts(
      @Path("id") int id, @Body(nullToAbsent: true) PartsModel partsModel);

  @DELETE("$parts/{id}")
  Future<HttpResponse<void>> deleteParts(@Path("id") int id);

  //*
  //* Jobs api
  //*
  @GET(jobs)
  Future<HttpResponse<List<JobsModel>>> findAllJobs();

  @GET("$jobs/find")
  Future<HttpResponse<List<JobsModel>>> findJobs(
    @Query("id") int? id,
    @Query("name") String? name,
  );

  @POST(jobs)
  Future<HttpResponse<JobsModel>> saveJobs(
      @Body(nullToAbsent: true) JobsModel jobsModel);

  @PUT("$jobs/{id}")
  Future<HttpResponse<JobsModel>> updateJobs(
      @Path("id") int id, @Body(nullToAbsent: true) JobsModel jobsModel);

  @DELETE("$jobs/{id}")
  Future<HttpResponse<void>> deleteJobs(@Path("id") int id);

  //*
  //* Badal api
  //*
  @GET(badal)
  Future<HttpResponse<List<BadalModel>>> findAllBadal();

  @POST(badal)
  Future<HttpResponse<BadalModel>> saveBadal(
      @Body(nullToAbsent: true) BadalModel badalModel);

  @PUT("$badal/{id}")
  Future<HttpResponse<BadalModel>> updateBadal(
      @Path("id") int id, @Body(nullToAbsent: true) BadalModel badalModel);

  @DELETE("$badal/{id}")
  Future<HttpResponse<void>> deleteBadal(@Path("id") int id);

  //*
  //* Bladia Countries api
  //*
  @GET(badalCountries)
  Future<HttpResponse<List<BadalCountriesModel>>> findAllBadalCountries();

  @POST(badalCountries)
  Future<HttpResponse<BadalCountriesModel>> saveBadalCountries(
      @Body(nullToAbsent: true) BadalCountriesModel badalCountriesModel);

  @PUT("$badalCountries/{id}")
  Future<HttpResponse<BadalCountriesModel>> updateBadalCountries(
      @Path("id") int id,
      @Body(nullToAbsent: true) BadalCountriesModel badalCountriesModel);

  @DELETE("$badalCountries/{id}")
  Future<HttpResponse<void>> deleteBadalCountries(@Path("id") int id);

  //*
  //* Emp Degrees api
  //*
  @GET(empDegrees)
  Future<HttpResponse<List<EmpDegreesModel>>> findAllEmpDegrees();

  @GET("$empDegrees/find")
  Future<HttpResponse<List<EmpDegreesModel>>> findDegrees(
    @Query("martaba") double? martaba,
    @Query("draga") double? draga,
  );

  @POST(empDegrees)
  Future<HttpResponse<EmpDegreesModel>> saveEmpDegrees(
      @Body(nullToAbsent: true) EmpDegreesModel empDegreesModel);

  @PUT("$empDegrees/{id}")
  Future<HttpResponse<EmpDegreesModel>> updateEmpDegrees(@Path("id") int id,
      @Body(nullToAbsent: true) EmpDegreesModel empDegreesModel);

  @DELETE("$empDegrees/{id}")
  Future<HttpResponse<void>> deleteEmpDegrees(@Path("id") int id);

  //*
  //* Emp DegreesWorker api
  //*
  @GET(empDegreesWorker)
  Future<HttpResponse<List<EmpDegreesWorkerModel>>> findAllEmpDegreesWorker();

  @POST(empDegreesWorker)
  Future<HttpResponse<EmpDegreesWorkerModel>> saveEmpDegreesWorker(
      @Body(nullToAbsent: true) EmpDegreesWorkerModel empDegreesWorkerModel);

  @PUT("$empDegreesWorker/{id}")
  Future<HttpResponse<EmpDegreesWorkerModel>> updateEmpDegreesWorker(
      @Path("id") int id,
      @Body(nullToAbsent: true) EmpDegreesWorkerModel empDegreesWorkerModel);

  @DELETE("$empDegreesWorker/{id}")
  Future<HttpResponse<void>> deleteEmpDegreesWorker(@Path("id") int id);

  //*
  //* Dissent api
  //*
  @GET(dissents)
  Future<HttpResponse<List<DissentModel>>> findAllDissent();

  @POST(dissents)
  Future<HttpResponse<DissentModel>> saveDissent(
      @Body(nullToAbsent: true) DissentModel dissentModel);

  @PUT("$dissents/{id}")
  Future<HttpResponse<DissentModel>> updateDissent(
      @Path("id") int id, @Body(nullToAbsent: true) DissentModel dissentModel);

  @DELETE("$dissents/{id}")
  Future<HttpResponse<void>> deleteDissent(@Path("id") int id);

  //*
  //* Emp Dowra api
  //*
  @GET("$empDowra/search")
  Future<HttpResponse<List<EmpDowraSearchModel>>> searchEmpDowra(
    @Query("name") String? name,
    @Query("cardId") String? cardId,
  );

  @GET("$empDowra/{id}")
  Future<HttpResponse<EmpDowraModel>> findEmpDowraById(@Path("id") int id);

  @POST(empDowra)
  Future<HttpResponse<EmpDowraModel>> saveEmpDowra(
      @Body(nullToAbsent: true) EmpDowraModel dissentModel);

  @PUT("$empDowra/{id}")
  Future<HttpResponse<EmpDowraModel>> updateEmpDowra(
      @Path("id") int id, @Body(nullToAbsent: true) EmpDowraModel dissentModel);

  @DELETE("$empDowra/{id}")
  Future<HttpResponse<void>> deleteEmpDowra(@Path("id") int id);

  //*
  //* Emp End api
  //*
  @GET("$empEnd/search")
  Future<HttpResponse<List<EmpEndSearchModel>>> searchEmpEnd(
      @Query("name") String? name);

  @GET("$empEnd/{id}")
  Future<HttpResponse<EmpEndModel>> findEmpEndById(@Path("id") int id);

  @POST(empEnd)
  Future<HttpResponse<EmpEndModel>> saveEmpEnd(
      @Body(nullToAbsent: true) EmpEndModel dissentModel);

  @PUT("$empEnd/{id}")
  Future<HttpResponse<EmpEndModel>> updateEmpEnd(
      @Path("id") int id, @Body(nullToAbsent: true) EmpEndModel dissentModel);

  @DELETE("$empEnd/{id}")
  Future<HttpResponse<void>> deleteEmpEnd(@Path("id") int id);

  //*
  //* Emp Entedab api
  //*
  @GET("$empEntedab/search")
  Future<HttpResponse<List<EmpEntedabSearchModel>>> searchEmpEntedab(
    @Query("employeeName") String? employeeName,
    @Query("cardId") String? cardId,
    @Query("entedabPlace") String? entedabPlace,
  );

  @GET("$empEntedab/{id}")
  Future<HttpResponse<EmpEntedabModel>> findEmpEntedabById(@Path("id") int id);

  @POST(empEntedab)
  Future<HttpResponse<EmpEntedabModel>> saveEmpEntedab(
      @Body(nullToAbsent: true) EmpEntedabModel dissentModel);

  @PUT("$empEntedab/{id}")
  Future<HttpResponse<EmpEntedabModel>> updateEmpEntedab(@Path("id") int id,
      @Body(nullToAbsent: true) EmpEntedabModel dissentModel);

  @DELETE("$empEntedab/{id}")
  Future<HttpResponse<void>> deleteEmpEntedab(@Path("id") int id);

  //*
  //* Emp Hasmiat api
  //*
  @GET("$empHasmiat/search")
  Future<HttpResponse<List<EmpHasmiatSearchModel>>> searchEmpHasmiat(
    @Query("name") String? name,
    @Query("cardId") String? cardId,
  );

  @GET("$empHasmiat/{id}")
  Future<HttpResponse<EmpHasmiatModel>> findEmpHasmiatById(@Path("id") int id);

  @POST(empHasmiat)
  Future<HttpResponse<EmpHasmiatModel>> saveEmpHasmiat(
      @Body(nullToAbsent: true) EmpHasmiatModel dissentModel);

  @PUT("$empHasmiat/{id}")
  Future<HttpResponse<EmpHasmiatModel>> updateEmpHasmiat(@Path("id") int id,
      @Body(nullToAbsent: true) EmpHasmiatModel dissentModel);

  @DELETE("$empHasmiat/{id}")
  Future<HttpResponse<void>> deleteEmpHasmiat(@Path("id") int id);

  //*
  //* Emp Holiday api
  //*
  @GET("$empHoliday/search")
  Future<HttpResponse<List<EmpHolidaySearchModel>>> searchEmpHoliday(
    @Query("empId") int? empId,
    @Query("name") String? name,
    @Query("cardId") String? cardId,
    @Query("empType") String? empType,
    @Query("holidayType") int? holidayType,
  );

  @GET("$empHoliday/{id}")
  Future<HttpResponse<EmpHolidayModel>> findEmpHolidayById(@Path("id") int id);

  @POST(empHoliday)
  Future<HttpResponse<EmpHolidayModel>> saveEmpHoliday(
      @Body(nullToAbsent: true) EmpHolidayModel dissentModel);

  @PUT("$empHoliday/{id}")
  Future<HttpResponse<EmpHolidayModel>> updateEmpHoliday(@Path("id") int id,
      @Body(nullToAbsent: true) EmpHolidayModel dissentModel);

  @DELETE("$empHoliday/{id}")
  Future<HttpResponse<void>> deleteEmpHoliday(@Path("id") int id);

  //*
  //* Emp Kashf Tepy api
  //*
  @GET("$empKashfTepy/search")
  Future<HttpResponse<List<EmpKashfTepySearchModel>>> searchEmpKashfTepy(
    @Query("name") String? name,
    @Query("cardId") String? cardId,
    @Query("empType") String? empType,
  );

  @GET("$empKashfTepy/{id}")
  Future<HttpResponse<EmpKashfTepyModel>> findEmpKashfTepyById(
      @Path("id") int id);

  @POST(empKashfTepy)
  Future<HttpResponse<EmpKashfTepyModel>> saveEmpKashfTepy(
      @Body(nullToAbsent: true) EmpKashfTepyModel dissentModel);

  @PUT("$empKashfTepy/{id}")
  Future<HttpResponse<EmpKashfTepyModel>> updateEmpKashfTepy(@Path("id") int id,
      @Body(nullToAbsent: true) EmpKashfTepyModel dissentModel);

  @DELETE("$empKashfTepy/{id}")
  Future<HttpResponse<void>> deleteEmpKashfTepy(@Path("id") int id);

  //*
  //* Emp Mobashra api
  //*
  @GET("$empMobashra/search")
  Future<HttpResponse<List<EmpMobashraSearchModel>>> searchEmpMobashra(
    @Query("name") String? name,
    @Query("cardId") String? cardId,
    @Query("empType") String? empType,
  );

  @GET("$empMobashra/{id}")
  Future<HttpResponse<EmpMobashraModel>> findEmpMobashraById(
      @Path("id") int id);

  @POST(empMobashra)
  Future<HttpResponse<EmpMobashraModel>> saveEmpMobashra(
      @Body(nullToAbsent: true) EmpMobashraModel dissentModel);

  @PUT("$empMobashra/{id}")
  Future<HttpResponse<EmpMobashraModel>> updateEmpMobashra(@Path("id") int id,
      @Body(nullToAbsent: true) EmpMobashraModel dissentModel);

  @DELETE("$empMobashra/{id}")
  Future<HttpResponse<void>> deleteEmpMobashra(@Path("id") int id);

  //*
  //* Emp Mokhalfat api
  //*
  @GET("$empMokhalfat/search")
  Future<HttpResponse<List<EmpMokhalfatSearchModel>>> searchEmpMokhalfat(
    @Query("name") String? name,
    @Query("cardId") String? cardId,
  );

  @GET("$empMokhalfat/{id}")
  Future<HttpResponse<EmpMokhalfatModel>> findEmpMokhalfatById(
      @Path("id") int id);

  @POST(empMokhalfat)
  Future<HttpResponse<EmpMokhalfatModel>> saveEmpMokhalfat(
      @Body(nullToAbsent: true) EmpMokhalfatModel dissentModel);

  @PUT("$empMokhalfat/{id}")
  Future<HttpResponse<EmpMokhalfatModel>> updateEmpMokhalfat(@Path("id") int id,
      @Body(nullToAbsent: true) EmpMokhalfatModel dissentModel);

  @DELETE("$empMokhalfat/{id}")
  Future<HttpResponse<void>> deleteEmpMokhalfat(@Path("id") int id);

  //*
  //* Emp Overtime api
  //*
  @GET("$empOvertime/search")
  Future<HttpResponse<List<EmpOvertimeSearchModel>>> searchEmpOvertime(
    @Query("name") String? name,
    @Query("cardId") String? cardId,
    @Query("place") String? place,
  );

  @GET("$empOvertime/{id}")
  Future<HttpResponse<EmpOvertimeModel>> findEmpOvertimeById(
      @Path("id") int id);

  @POST(empOvertime)
  Future<HttpResponse<EmpOvertimeModel>> saveEmpOvertime(
      @Body(nullToAbsent: true) EmpOvertimeModel dissentModel);

  @PUT("$empOvertime/{id}")
  Future<HttpResponse<EmpOvertimeModel>> updateEmpOvertime(@Path("id") int id,
      @Body(nullToAbsent: true) EmpOvertimeModel dissentModel);

  @DELETE("$empOvertime/{id}")
  Future<HttpResponse<void>> deleteEmpOvertime(@Path("id") int id);

  //*
  //* Emp Taeen api
  //*
  @GET("$empTaeen/search")
  Future<HttpResponse<List<EmpTaeenSearchModel>>> searchEmpTaeen(
    @Query("name") String? name,
  );

  @GET("$empTaeen/{id}")
  Future<HttpResponse<EmpTaeenModel>> findEmpTaeenById(@Path("id") int id);

  @POST(empTaeen)
  Future<HttpResponse<EmpTaeenModel>> saveEmpTaeen(
      @Body(nullToAbsent: true) EmpTaeenModel dissentModel);

  @PUT("$empTaeen/{id}")
  Future<HttpResponse<EmpTaeenModel>> updateEmpTaeen(
      @Path("id") int id, @Body(nullToAbsent: true) EmpTaeenModel dissentModel);

  @DELETE("$empTaeen/{id}")
  Future<HttpResponse<void>> deleteEmpTaeen(@Path("id") int id);

  //*
  //* Emp Tarqea api
  //*
  @GET("$empTarqea/search")
  Future<HttpResponse<List<EmpTarqeaSearchModel>>> searchEmpTarqea(
    @Query("qrarId") String? qrarId,
    @Query("name") String? name,
  );

  @GET("$empTarqea/{id}")
  Future<HttpResponse<EmpTarqeaModel>> findEmpTarqeaById(@Path("id") int id);

  @POST(empTarqea)
  Future<HttpResponse<EmpTarqeaModel>> saveEmpTarqea(
      @Body(nullToAbsent: true) EmpTarqeaModel dissentModel);

  @PUT("$empTarqea/{id}")
  Future<HttpResponse<EmpTarqeaModel>> updateEmpTarqea(@Path("id") int id,
      @Body(nullToAbsent: true) EmpTarqeaModel dissentModel);

  @DELETE("$empTarqea/{id}")
  Future<HttpResponse<void>> deleteEmpTarqea(@Path("id") int id);

  //*
  //* Passport api
  //*
  @GET("$passport/search")
  Future<HttpResponse<List<PassportSearchModel>>> searchPassport(
    @Query("name") String? name,
    @Query("passportNumber") String? passportNumber,
  );

  @GET("$passport/{id}")
  Future<HttpResponse<PassportModel>> findPassportById(@Path("id") int id);

  @POST(passport)
  Future<HttpResponse<PassportModel>> savePassport(
      @Body(nullToAbsent: true) PassportModel dissentModel);

  @PUT("$passport/{id}")
  Future<HttpResponse<PassportModel>> updatePassport(
      @Path("id") int id, @Body(nullToAbsent: true) PassportModel dissentModel);

  @DELETE("$passport/{id}")
  Future<HttpResponse<void>> deletePassport(@Path("id") int id);

  //*
  //* Emp Tafweed api
  //*
  @GET("$tafweed/search")
  Future<HttpResponse<List<TafweedSearchModel>>> searchTafweed(
    @Query("empId") int? empId,
  );

  @GET("$tafweed/{id}")
  Future<HttpResponse<TafweedModel>> findTafweedById(@Path("id") int id);

  @POST(tafweed)
  Future<HttpResponse<TafweedModel>> saveTafweed(
      @Body(nullToAbsent: true) TafweedModel dissentModel);

  @PUT("$tafweed/{id}")
  Future<HttpResponse<TafweedModel>> updateTafweed(
      @Path("id") int id, @Body(nullToAbsent: true) TafweedModel dissentModel);

  @DELETE("$tafweed/{id}")
  Future<HttpResponse<void>> deleteTafweed(@Path("id") int id);

  //*
  //* Employee api
  //*
  @GET("$employee/search")
  Future<HttpResponse<List<EmployeeSearchModel>>> searchEmployee(
    @Query("id") int? id,
    @Query("name") String? name,
    @Query("cardId") String? cardId,
    @Query("jobId") int? jobId,
    @Query("partId") int? partId,
    @Query("fia") String? fia,
    @Query("draga") double? draga,
    @Query("jobState") String? jobState,
    @Query("empType") String? empType,
  );

  @GET("$employee/find")
  Future<HttpResponse<List<EmployeeFindModel>>> findEmployee(
    @Query("id") int? id,
    @Query("name") String? name,
    @Query("cardId") String? cardId,
    @Query("empType") String? empType,
  );

  @GET("$employee/{id}")
  Future<HttpResponse<EmployeeModel>> findEmployeeById(@Path("id") int id);

  @POST(employee)
  Future<HttpResponse<EmployeeModel>> saveEmployee(
      @Body(nullToAbsent: true) EmployeeModel dissentModel);

  @PUT("$employee/{id}")
  Future<HttpResponse<EmployeeModel>> updateEmployee(
      @Path("id") int id, @Body(nullToAbsent: true) EmployeeModel dissentModel);

  @DELETE("$employee/{id}")
  Future<HttpResponse<void>> deleteEmployee(@Path("id") int id);

  //*
  //* Emp Eqrar api
  //*
  @GET("$empEqrar/search")
  Future<HttpResponse<List<EmpEqrarSearchModel>>> searchEmpEqrar(
      @Query("name") String? name);

  @GET("$empEqrar/{id}")
  Future<HttpResponse<EmpEqrarModel>> findEmpEqrarById(@Path("id") int id);

  @POST(empEqrar)
  Future<HttpResponse<EmpEqrarModel>> saveEmpEqrar(
      @Body(nullToAbsent: true) EmpEqrarModel dissentModel);

  @PUT("$empEqrar/{id}")
  Future<HttpResponse<EmpEqrarModel>> updateEmpEqrar(
      @Path("id") int id, @Body(nullToAbsent: true) EmpEqrarModel dissentModel);

  @DELETE("$empEqrar/{id}")
  Future<HttpResponse<void>> deleteEmpEqrar(@Path("id") int id);

  //*
  //* EmpHolidayType api
  //*
  @GET(empHolidayType)
  Future<HttpResponse<List<EmpHolidayTypeModel>>> findAllEmpHolidayType();

  @POST(empHolidayType)
  Future<HttpResponse<EmpHolidayTypeModel>> saveEmpHolidayType(
      @Body(nullToAbsent: true) EmpHolidayTypeModel empHolidayTypeModel);

  @PUT("$empHolidayType/{id}")
  Future<HttpResponse<EmpHolidayTypeModel>> updateEmpHolidayType(
      @Path("id") int id,
      @Body(nullToAbsent: true) EmpHolidayTypeModel empHolidayTypeModel);

  @DELETE("$empHolidayType/{id}")
  Future<HttpResponse<void>> deleteEmpHolidayType(@Path("id") int id);
}
