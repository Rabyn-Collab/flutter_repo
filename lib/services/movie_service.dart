import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_sample/api.dart';
import 'package:flutter_sample/models/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MovieService {



  static Future<List<Movie>> getMovieByCategory({required String apiPath, required int page}) async {
    final dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    try {
       final response = await dio.get(apiPath, queryParameters: {
         'api_key': '2a0f926961d00c667e191a21c14461f8',
         'language': 'en-US',
         'page': page
       });
       if(apiPath == Api.popularMovieUrl){
         final response1 = await dio.get(apiPath, queryParameters: {
           'api_key': '2a0f926961d00c667e191a21c14461f8',
           'language': 'en-US',
           'page': 1
         });
         await prefs.setString('movie', jsonEncode(response1.data['results']));
       }
       final data= (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
       return data;
    }on DioError catch (err){
      if(apiPath == Api.popularMovieUrl){
        final data = prefs.getString('movie');
        return (jsonDecode(data!) as List).map((e) => Movie.fromJson(e)).toList();
      }else{
        return [];
      }

    }
  }



  static Future<List<Movie>> searchMovie({required String apiPath, required int page,required String query}) async {
    final dio = Dio();
    try {
      final response = await dio.get(apiPath, queryParameters: {
        'api_key': '2a0f926961d00c667e191a21c14461f8',
        'language': 'en-US',
        'query': query,
        'page': page
      });
      if((response.data['results'] as List).isEmpty){
          return [Movie(id: 0, title: 'no-data',
              overview: '', poster_path: '', release_date: '', vote_average: '')];
      }else{
        final data= (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
        return data;
      }

    }on DioError catch (err){
      print(err);
      return [];
    }
  }





}
