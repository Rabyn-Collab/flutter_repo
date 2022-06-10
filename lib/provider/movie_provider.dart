import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/api.dart';
import 'package:flutter_sample/models/movie.dart';
import 'package:flutter_sample/models/movie_state.dart';
import 'package:flutter_sample/services/movie_service.dart';



final movieProvider = StateNotifierProvider<MovieProvider, MovieState>((ref) => MovieProvider(MovieState.initState()));

class MovieProvider extends StateNotifier<MovieState>{
  MovieProvider(super.state){
    getMovieData();
  }

  Future<void> getMovieData() async{
  List<Movie> _movies = [];
    if(state.searchText.isEmpty){
      _movies = await MovieService.getMovieByCategory(apiPath: state.apiPath, page: state.page);

    }else{
      _movies = await MovieService.searchMovie(apiPath: state.apiPath, page: state.page, query: state.searchText);

    }

    state = state.copyWith(
      movies: [...state.movies, ..._movies]
    );


  }

  void changeCategory({required String apiPath}){
    state = state.copyWith(
      apiPath: apiPath,
      searchText: '',
      movies: []
    );

    getMovieData();

  }

  void searchMovie({required String searchText}){
    state = state.copyWith(
        apiPath: Api.searchMovieUrl,
        searchText: searchText,
        movies: []
    );
    getMovieData();

  }

  void loadMore(){
    state = state.copyWith(
        searchText: '',
        page: state.page + 1
    );
    getMovieData();

  }



}


final videoProvider = FutureProvider.family((ref, int id) => VideoProvider().getVideoId(id));

class VideoProvider {

  Future<String> getVideoId(int videoId) async{
    final dio = Dio();
    final response = await dio.get('https://api.themoviedb.org/3/movie/$videoId/videos', queryParameters: {
      'api_key': '2a0f926961d00c667e191a21c14461f8'
    });
    return response.data['results'][0]['key'];
  }



}