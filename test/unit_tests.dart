import 'package:dartz/dartz.dart';
import 'package:newsapp_integrationtest_getx/core/model/article.dart';
import 'package:newsapp_integrationtest_getx/core/repository/news_repo.dart';
import 'package:newsapp_integrationtest_getx/feature/news_headline/binding/news_headline_binding.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main(){
  MockNewsRepo? newsRepositoryMock;
  Either<Unit,Articles>? expectedArticles;
  setUp((){
    newsRepositoryMock= MockNewsRepo();
    // expectedArticles= Right(Articles(articles: []));
  });

  group("test repo api calls", (){
    test("get headline", ()async{
       Either<Unit,Articles> articles= await newsRepositoryMock!.getNewsHeadline();
      expect(articles, isA<Right>());
    });
    test("get searched news", ()async{
       Either<Unit,Articles> articles= await newsRepositoryMock!.getSearchedNews("Egypt");
       expect(articles, isA<Right>());
    });

  });


}