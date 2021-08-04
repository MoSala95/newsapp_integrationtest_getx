import 'package:dartz/dartz.dart';
import 'package:newsapp_integrationtest_getx/core/model/article.dart';

abstract class NewsRepo {
  Future<Either<Unit,Articles>> getNewsHeadline();
  Future<Either<Unit,Articles>> getSearchedNews(String query);
}