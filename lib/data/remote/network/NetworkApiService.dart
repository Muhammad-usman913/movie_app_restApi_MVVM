import 'dart:convert';
import 'dart:io';

import 'package:flutter_movie_app_mvvm/data/remote/AppException.dart';
import 'package:flutter_movie_app_mvvm/data/remote/network/BaseApiService.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkApiService extends BaseApiService{

  final String baseUrl = 'https://api.themoviedb.org/3/movie';
  final String apiKey = 'd5de8849bf12281927f86b94bad62966';
  @override
  Future getResponse() async{
    dynamic responseJson;
    try{
      final response = await http.get(Uri.parse('$baseUrl/popular?api_key=$apiKey'));
      responseJson = returnResponse(response);
    }on SocketException{
      throw FetchDataException('No internet connection');
    }
    return responseJson;
  }

 dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw FetchDataException(
          'Error occured while communication with server'+
            'with staus code : ${response.statusCode}'
        );

    }
 }

}

