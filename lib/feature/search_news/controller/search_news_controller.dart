import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:newsapp_integrationtest_getx/core/repository/news_repo.dart';
import 'package:newsapp_integrationtest_getx/core/repository/news_repo_impl.dart';
import 'package:newsapp_integrationtest_getx/core/model/article.dart';

class SearchNewsController extends GetxController{
  NewsRepo? _newsRepo;

  SearchNewsController(){
    _newsRepo = Get.find<NewsRepo>();
    
    searchTextController.addListener(() { 
      if(searchTextController.text.length%3==0 && searchTextController.text.length!=0){
        searchNewsHeadline();
      }
    });
  }
  
  final searchTextController = TextEditingController();

  RxBool isLoading = false.obs;

  RxList<Article> articles = RxList();

  searchNewsHeadline() async{

    showLoading();

    final result = await _newsRepo!.getSearchedNews(searchTextController.text);

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