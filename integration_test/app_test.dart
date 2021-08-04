// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:newsapp_integrationtest_getx/feature/news_headline/controller/news_headline_controller.dart';
import 'package:newsapp_integrationtest_getx/main.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';

void main() {

  //use this command line to run the test
  //flutter drive --driver=test_driver/integration_driver.dart --target=integration_test/app_test.dart

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('success loading', (WidgetTester tester) async {
    //test.runAsync as there ia async call to fetch news happens
    await tester.runAsync(
      () async {
        await tester.pumpWidget(
          MyApp());
      });

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    //we can use pumpAndSettle here as it will pump until the circular indicator finish that mean we have a response
    //we do not use pumpAndSettle in widget test
    //we cam use pump(Duration(seconds:x) and wait for some times but i think pumpAndSettle make sense here
    final controller= Get.find<NewsHeadlineController>();
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byKey(Key("headline_image")), findsWidgets);
    expect(find.byKey(Key("headline_title")), findsWidgets);
    expect(find.byKey(Key("headline_desc")), findsWidgets);
    expect(find.text(controller.articles![0].title!),findsOneWidget);

    await tester.drag(find.byType(ListView), Offset(0, -400));
    await tester.pumpAndSettle();
    expect(find.text(controller.articles![0].title!),findsNothing);

    final drawerFinder = find.byTooltip('Open navigation menu');

    await tester.tap(drawerFinder);
    await tester.pumpAndSettle();
    expect(find.byKey(Key("contact_key")), findsOneWidget);
    expect(find.byKey(Key("search_key")), findsOneWidget);
    await tester.tap(find.byKey(Key("search_key")));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);

    await tester.enterText(find.byKey(new Key('search_text_field')), 'cairo');
    await tester.testTextInput.receiveAction(TextInputAction.done);

    await tester.pumpAndSettle();

    await Future.delayed(Duration(seconds: 3));
    await tester.pump();
    expect(find.byType(ListView), findsOneWidget);
  });
}
