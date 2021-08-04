import 'package:dartz/dartz.dart';
import 'package:newsapp_integrationtest_getx/core/fake_json_reponses/articles_sample.dart';
import 'package:newsapp_integrationtest_getx/core/model/article.dart';
import 'package:newsapp_integrationtest_getx/core/repository/news_repo.dart';
import 'package:get/get.dart';
import 'package:newsapp_integrationtest_getx/core/repository/news_repo_impl.dart';
import 'package:newsapp_integrationtest_getx/feature/news_headline/controller/news_headline_controller.dart';
import 'package:mockito/mockito.dart';
class NewsHeadlineBinding extends Bindings{
  @override
  void dependencies() {
    //here i specify the type of newsRepo which helps a lot in testing as it is an interface
    Get.lazyPut<NewsRepo>(()=>NewsRepoImpl());
    Get.put(NewsHeadlineController());
  }

}
class NewsHeadlineBindingTest extends Bindings{
  @override
  void dependencies() {
    Get.put<NewsRepo>(MockNewsRepo());
    Get.put(NewsHeadlineController());
  }

}

class MockNewsRepo extends Mock implements NewsRepo{
  @override
  Future<Either<Unit,Articles>> getNewsHeadline() async{
    print("mock headline call");
    final parsedResponse = articlesFromJson(SampleJsonResponse.articles);
    return right(parsedResponse);
  }
  @override
  Future<Either<Unit,Articles>> getSearchedNews(String  query) async{
    print("mock search article call");
    final parsedResponse = articlesFromJson(SampleJsonResponse.articles);
    return right(parsedResponse);
  }
}