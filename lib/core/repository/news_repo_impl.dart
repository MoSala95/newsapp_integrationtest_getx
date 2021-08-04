import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:newsapp_integrationtest_getx/core/model/article.dart';
 import 'package:newsapp_integrationtest_getx/core/repository/news_repo.dart';
import 'package:newsapp_integrationtest_getx/service/http_service.dart';
import 'package:newsapp_integrationtest_getx/service/http_service_impl.dart';

class NewsRepoImpl implements NewsRepo{

  HttpService? _httpService;

  NewsRepoImpl(){
    _httpService = Get.put(HttpServiceImpl());
    _httpService!.init();
  }

  @override
  Future<Either<Unit,Articles>> getNewsHeadline() async{
    // TODO: implement getNewsHeadlin

    try {
       final response = await _httpService!.getRequest("/v2/top-headlines?country=us");
       print(response.data);

       final parsedResponse = Articles.fromJson(response.data);

       return right(parsedResponse);
    } on Exception catch (e) {
      print(e);
      return left(unit);
    }
  }

  @override
   Future<Either<Unit,Articles>> getSearchedNews(String query) async{
    // TODO: implement getSearchedNews
    try {
      final response = await _httpService!.getRequest("/v2/everything?q=$query");

      final parsedResponse = Articles.fromJson(response.data);

      return right(parsedResponse);
    } on Exception catch (e) {
      print(e);
      return left(unit);
    }
  }

}