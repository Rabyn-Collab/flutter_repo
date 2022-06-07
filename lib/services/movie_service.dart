import 'package:dio/dio.dart';
import 'package:flutter_sample/models/movie.dart';


class MovieService {


  static Future<List<Movie>> getMovieByCategory({required String apiPath, required int page}) async {
    final dio = Dio();
    try {
       final response = await dio.get(apiPath, queryParameters: {
         'api_key': '2a0f926961d00c667e191a21c14461f8',
         'language': 'en-US',
         'page': 1
       });

       final data= (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
       return data;


    }on DioError catch (err){
      print(err);
      return [];
    }
  }







}
