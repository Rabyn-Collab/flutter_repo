import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/provider/chat_provider.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;


class RecentChats extends StatelessWidget {
final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
            builder: (context, ref, child) {
              final rooms = ref.watch(roomStream);
              return rooms.when(
                  data: (data){
                      return ListView.builder(
                        itemCount: data.length,
                          itemBuilder: (context, index){
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(data[index].imageUrl!),
                              ),
                              title: Text(data[index].name!),
                            );
                          });
                  },
                  error: (err, stack) => Text('$err'),
                  loading: () => Center(child: CircularProgressIndicator(),)
              );
            }
              )
    );
  }
}
