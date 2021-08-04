import 'package:get/get.dart';
import 'package:newsapp_integrationtest_getx/core/repository/news_repo.dart';
import 'package:newsapp_integrationtest_getx/core/repository/news_repo_impl.dart';
import 'package:newsapp_integrationtest_getx/core/model/article.dart';

class NewsHeadlineController extends GetxController{
  NewsRepo? _newsRepo;

  NewsHeadlineController(){
    _newsRepo = Get.find<NewsRepo>();
    loadNewsLine();
  }

  RxBool isLoading = false.obs;

  RxList<Article>? articles;

  loadNewsLine() async{

    showLoading();

    final result = await _newsRepo!.getNewsHeadline();

    hideLoading();

    if(result!= null){
     result.fold((l) => l, (r) => articles= r.articles!.obs);
    }else{
      print("No data recieved");
    }
  }

  showLoading(){
    isLoading.toggle();
  }

  hideLoading(){
    isLoading.toggle();
  }
}