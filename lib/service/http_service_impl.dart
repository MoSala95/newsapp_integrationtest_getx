
import 'package:dio/dio.dart';
import 'package:newsapp_integrationtest_getx/service/http_service.dart';

const BASE_URL = "https://newsapi.org/";
const API_KEY = "b3d87d6848ce44bd8b1d3e411228e387";

class HttpServiceImpl implements HttpService{

  Dio? _dio;

  @override
  Future<Response> getRequest(String url) async{
    // TODO: implement getRequest

    Response response;
    try {
      response = await _dio!.get(url);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  initializeInterceptors(){

    _dio!.interceptors.add(InterceptorsWrapper(
        onRequest:(options, handler){
          // Do something before request is sent
          return handler.next(options); //continue

        },
        onResponse:(response,handler) {
          // Do something with response data
          return handler.next(response); // continue

        },
        onError: (DioError e, handler) {
          // Do something with response error
          return  handler.next(e);//continue

        }
    ));
  }

  @override
  void init() {
    _dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      headers: {"Authorization" : "Bearer $API_KEY"}
    ));

    initializeInterceptors();
  }

}