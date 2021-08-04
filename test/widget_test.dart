// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:newsapp_integrationtest_getx/core/repository/news_repo.dart';
import 'package:newsapp_integrationtest_getx/feature/news_headline/binding/news_headline_binding.dart';
import 'package:newsapp_integrationtest_getx/feature/news_headline/controller/news_headline_controller.dart';
import 'package:newsapp_integrationtest_getx/feature/news_headline/view/news_headling_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:network_image_mock/network_image_mock.dart';


void main() {
  Get.put<NewsRepo>(MockNewsRepo());
  Get.put(NewsHeadlineController());

  testWidgets('success loading', (WidgetTester tester) async {

    await mockNetworkImagesFor(()async=>await tester.runAsync(() async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: NewsHeadlineView(),),);

     // expect(find.byType(CircularProgressIndicator), findsOneWidget);
       final controller = Get.find<NewsHeadlineController>();
      print(controller.articles == null);
      await tester.pump();
      expectLater(controller.articles!.length, 11);
      expect(find.text("Spotify Songs0"), findsWidgets);
      await tester.drag(find.byType(ListView), Offset(0, -500));
      await tester.pump();
      expect(find.text("Spotify Songs6"), findsWidgets);
    }));
});
}
