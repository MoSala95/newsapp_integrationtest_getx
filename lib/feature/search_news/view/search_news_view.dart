import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp_integrationtest_getx/core/widget/drawer.dart';
import 'package:newsapp_integrationtest_getx/feature/search_news/controller/search_news_controller.dart';

class SearchNewsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search News"),
      ),
      drawer: getAppDrawer(),
      body:   Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              key: Key("search_text_field"),
              controller: Get.find<SearchNewsController>().searchTextController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
              ),
            ),
           Expanded(child: GetX<SearchNewsController>(
                 builder: (controller) {
                  if (controller.isLoading.isTrue)
                    return Center(child: CircularProgressIndicator());

                  if (controller.articles.isEmpty)
                    return Center(child: Text("No news found"));

                  return Container(
                    margin: const EdgeInsets.all(10),
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            controller.articles[index].urlToImage == null
                                ? Container()
                                : Image.network(
                                    controller.articles[index].urlToImage!),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              controller.articles[index].title!,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              controller.articles[index].description!,
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: controller.articles.length,
                    ),
                  );
                })

            )
          ],
        )

    );
  }
}
