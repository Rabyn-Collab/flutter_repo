import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/models/post.dart';

import '../provider/crud_provider.dart';



class UserDetail extends StatelessWidget {
   final types.User user;
   UserDetail(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
          builder: (context, ref, child) {
            final posts = ref.watch(postStream);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(user.imageUrl!),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.firstName!),
                            SizedBox(height: 10,),
                            Text(user.metadata!['email']!),
                            SizedBox(height: 10,),
                            ElevatedButton(
                                onPressed: () {

                                }, child: Text('start chat')
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 710,
                    child: posts.when(
                        data: (data){
                          final userPost = data.where((element) => element.userId == user.id).toList();
                          return GridView.builder(
                            itemCount: userPost.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3/2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5
                              ),
                              itemBuilder: (context, index){
                              return Image.network(userPost[index].imageUrl);
                              }
                          );
                        },
                        error: (err, stack) => Center(child: Text('$err')),
                        loading: () => Center(child: CircularProgressIndicator(),)
                    ),
                  ),
                ],
              ),
            );
          }
        )
    );
  }
}
