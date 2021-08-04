import 'package:get/get.dart';
import 'package:newsapp_integrationtest_getx/feature/search_news/controller/search_news_controller.dart';

class SearchNewsBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SearchNewsController());
  }

}