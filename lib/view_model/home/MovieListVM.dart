
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_mvvm/data/remote/response/ApiResponse.dart';
import 'package:flutter_movie_app_mvvm/models/moviesList/MainMovies.dart';
import 'package:flutter_movie_app_mvvm/repository/movies/MovieRepoImp.dart';

class MovieListVM extends ChangeNotifier{
 final _myRepo = MovieRepoImp();

 ApiResponse<MainMovies> movieMain = ApiResponse.loading();

 void _setMovieMain(ApiResponse<MainMovies> response){
   print('The current response status is $response');
   movieMain = response;
   notifyListeners();
 }

 Future<void> fetchMovies() async{
   _setMovieMain(ApiResponse.loading());
   _myRepo.getMoviesList().then(
           (value) {
 _setMovieMain(ApiResponse.completed(value));
           }).onError((error, stackTrace){
             _setMovieMain(ApiResponse.error(error.toString()));
   });
 }


}