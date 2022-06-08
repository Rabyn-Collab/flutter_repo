import 'package:flutter_sample/api.dart';
import 'package:flutter_sample/models/movie.dart';



class MovieState{

  final String searchText;
  final String apiPath;
  final int page;
  final List<Movie> movies;


  MovieState({
    required this.apiPath,
    required this.page,
    required this.movies,
    required this.searchText
});

  MovieState.initState() : searchText='', movies=[], page=1, apiPath= Api.popularMovieUrl;

  MovieState copyWith({
   String? apiPath,
  int?  page,
  List<Movie>?  movies,
   String? searchText

}){
    return MovieState(
        apiPath: apiPath ?? this.apiPath,
        page: page ?? this.page,
        movies: movies ?? this.movies,
        searchText: searchText ?? this.searchText
    );
  }





}