import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/models/movie.dart';
import 'package:flutter_sample/provider/movie_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';



class DetailPage extends StatelessWidget {
final Movie movie;

DetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
            builder: (context, ref, child) {
              final videoData = ref.watch(videoProvider(movie.id));
              return ListView(
                children: [
                  Container(
                    height: 240,
                    child: videoData.when(
                        data: (data){
                          return YoutubePlayer(
                            controller: YoutubePlayerController(
                              initialVideoId: data,
                              flags: YoutubePlayerFlags(
                                autoPlay: false,
                              ),
                            ),
                            showVideoProgressIndicator: true,
                          );
                        },
                        error: (err, stack) => Center(child: Text('$err')),
                        loading: () => Center(child: CircularProgressIndicator(
                          color: Colors.purple,
                        ),)
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(movie.title),
                        Text(movie.release_date),
                        SizedBox(height: 10,),
                        Image.network('https://image.tmdb.org/t/p/w600_and_h900_bestv2/${movie.poster_path}'),
                        SizedBox(height: 10,),
                        Text(movie.overview)
                      ],
                    ),
                  ),


                ],
              );
            }
    )
    );
  }
}
