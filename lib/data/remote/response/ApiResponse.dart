
import 'package:flutter_movie_app_mvvm/data/remote/response/Status.dart';

class ApiResponse<T>{

  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status, this.data ,this.message);

  ApiResponse.loading() : status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;


  @override
  String toString() {
    print('ToString methed apiResponse is called');
    return "Status : $status \n Message : $message \n Data : $data";
  }

}