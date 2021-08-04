import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp_integrationtest_getx/core/widget/drawer.dart';
import 'package:newsapp_integrationtest_getx/feature/news_headline/controller/news_headline_controller.dart';

class NewsHeadlineView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:Key("scaffold_key"),
      appBar: AppBar(
        title: Text("News Headline"),
      ),
      drawer: getAppDrawer(),
      body: GetX<NewsHeadlineController>(
       builder: (controller) {
         if (controller.isLoading.isTrue)
           return Center(
            child: CircularProgressIndicator(),
           );

         return Container(
          margin: const EdgeInsets.all(10),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.articles![index].urlToImage != null)
                    Image.network(controller.articles![index].urlToImage!,
                      key:Key("headline_image"),),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    controller.articles![index].title!,
                    key:Key("headline_title"),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    controller.articles![index].description ?? "",
                    key:Key("headline_desc"),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: controller.articles!.length,
          ),
        );
      }),
    );
  }
}
