import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../feature/tarmeez_badal/data/model/badal_model.dart';
import '../../feature/tarmeez_badal_countries/data/model/badal_countries_model.dart';
import '../../feature/tarmeez_dissent/data/model/dissent_model.dart';
import '../../feature/tarmeez_emp_degrees/data/model/emp_degrees_model.dart';
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

  @POST(empDegrees)
  Future<HttpResponse<EmpDegreesModel>> saveEmpDegrees(
      @Body(nullToAbsent: true) EmpDegreesModel empDegreesModel);

  @PUT("$empDegrees/{id}")
  Future<HttpResponse<EmpDegreesModel>> updateEmpDegrees(@Path("id") int id,
      @Body(nullToAbsent: true) EmpDegreesModel empDegreesModel);

  @DELETE("$empDegrees/{id}")
  Future<HttpResponse<void>> deleteEmpDegrees(@Path("id") int id);

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
}
