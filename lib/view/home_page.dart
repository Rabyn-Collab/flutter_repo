import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/api.dart';
import 'package:flutter_sample/provider/movie_provider.dart';
import 'package:flutter_sample/view/detail_page.dart';
import 'package:get/get.dart';



class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 160,
        flexibleSpace: Image.asset('assets/images/tmdb.jpg', fit: BoxFit.fill,),
      ),
        body: OfflineBuilder(
      connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child,) {
        return connectivity == ConnectivityResult.none ? Center(child: Text('no connection')): Consumer(
            builder: (context, ref, child) {
              final movieState = ref.watch(movieProvider);
              return Column(
                children: [
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: searchController,
                              onFieldSubmitted: (val) {
                                ref.read(movieProvider.notifier).searchMovie(
                                    searchText: val.trim());
                                searchController.clear();
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                hintText: 'search movie',
                                border: OutlineInputBorder(),
                                //  suffixIcon: Icon(Icons.add_a_photo_outlined)
                              ),
                            ),
                          )
                      ),
                      PopupMenuButton(
                          padding: EdgeInsets.only(top: 15),
                          icon: Icon(Icons.menu, size: 30,),
                          onSelected: (val) {
                            ref.read(movieProvider.notifier).changeCategory(
                                apiPath: val as String);
                          },
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                  value: Api.popularMovieUrl,
                                  child: Text('popular')
                              ),
                              PopupMenuItem(
                                  value: Api.upComingMovieUrl,
                                  child: Text('upcoming')),
                              PopupMenuItem(
                                  value: Api.topRatedMovieUrl,
                                  child: Text('top_rated')),
                            ];
                          }
                      ),
                    ],

                  ),
                  SizedBox(height: 15,),
                  Container(
                    height: 590,
                    child: movieState.movies.isEmpty ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.purple,
                      ),
                    ) : movieState.movies[0].title == 'no-data' ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Try using another keyword',
                            style: TextStyle(fontSize: 20),),
                          ElevatedButton(
                              onPressed: () {
                                ref.refresh(movieProvider.notifier);
                              }, child: Text('reload'))
                        ],
                      ),
                    ) : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: NotificationListener(
                        onNotification: (onNotification) {
                          if (onNotification is ScrollEndNotification) {
                            final before = onNotification.metrics.extentBefore;
                            final max = onNotification.metrics.maxScrollExtent;
                            if (before == max) {
                              ref.read(movieProvider.notifier).loadMore();
                            }
                          }
                          return true;
                        },
                        child: GridView.builder(
                            itemCount: movieState.movies.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 2 / 3,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                            ),
                            itemBuilder: (context, index) {
                              final movie = movieState.movies[index];
                              return InkWell(
                                onTap: () {
                                  Get.to(() => DetailPage(movie),
                                      transition: Transition.leftToRight);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    errorWidget: (c, s, d) {
                                      return Image.asset(
                                          'assets/images/tmdb.jpg');
                                    },
                                    imageUrl: 'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${movie
                                        .poster_path}',),
                                ),
                              );
                            }
                        ),
                      ),
                    ),
                  )

                ],
              );
            },


        );
      },
          child: Container(),
        )
    );
  }
}
