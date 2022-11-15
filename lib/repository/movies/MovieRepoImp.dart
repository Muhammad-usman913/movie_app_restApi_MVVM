

import 'package:flutter_movie_app_mvvm/models/moviesList/MainMovies.dart';
import 'package:flutter_movie_app_mvvm/repository/movies/MovieRepo.dart';

import '../../data/remote/network/BaseApiService.dart';
import '../../data/remote/network/NetworkApiService.dart';

class MovieRepoImp implements MovieRepo{

  BaseApiService _apiService = NetworkApiService();

  @override
  Future<MainMovies> getMoviesList() async{
    try{
      dynamic response = await _apiService.getResponse();
      print("The api response $response");
      final jsonData = MainMovies.fromJson(response);
      print("The model class response $jsonData");
      return jsonData;
    }catch(e){
       throw e;
    }



  }

}