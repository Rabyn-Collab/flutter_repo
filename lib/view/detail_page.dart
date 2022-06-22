import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/models/post.dart';
import 'package:flutter_sample/provider/crud_provider.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;


class DetailPage extends StatelessWidget {
  final Post post;
  final types.User user;
DetailPage(this.post, this.user);
final  commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
            builder: (context, ref, child) {
              final postData = ref.watch(postStream);
              return ListView(
                children: [
                  Image.network(post.imageUrl, height: 370, width: double.infinity,
                  fit: BoxFit.fitHeight,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post.title),
                        SizedBox(height: 10,),
                        Text(post.description),

                        TextFormField(
                          controller: commentController,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'please add comment';
                            }
                            return null;
                          },
                          onFieldSubmitted: (val)async {
                            final newComment = Comments(
                                comment: val.trim(),
                                imageUrl: user.imageUrl!, username: user.firstName!);
                           await  ref.read(crudProvider).addComment(
                               comments: newComment,
                               postId: post.id);
                           commentController.clear();
                          },
                          decoration: InputDecoration(
                            hintText: 'add comment'
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 45),
                        child: postData.when(
                            data: (data){
                              final currentPost = data.firstWhere((element) => element.id == post.id);
                              print(currentPost.comments);
                              return ListView.builder(
                                shrinkWrap: true,
                                  itemCount: currentPost.comments.length,
                                  itemBuilder: (context, index){
                                    return ListTile(
                                      leading: CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(currentPost.comments[index].imageUrl),
                                      ),
                                      title: Text(currentPost.comments[index].username),
                                      subtitle: Text(currentPost.comments[index].comment),
                                    );
                                  });
                            },
                            error: (err, stack) => Text('$err'),
                            loading: () => Center(child: CircularProgressIndicator(),)
                        ),
                        )

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
