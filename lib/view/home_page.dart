import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/provider/auth_provider.dart';
import 'package:flutter_sample/widgets/drawer_widget.dart';



class HomePage extends StatelessWidget {

  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Social App'),
      ),
        body: Consumer(
            builder: (context, ref, child) {
              final users = ref.watch(usersStream);
              return Column(
                children: [
                  Container(
                    height: 149,
                    child: users.when(
                        data: (data){
                          final dat = data.where((element) => element.id != uid).toList();
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                              itemCount: dat.length,
                              itemBuilder: (context, index){
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(dat[index].imageUrl!),
                                    ),
                                    SizedBox(height: 7,),
                                    Text(dat[index].firstName!, style: TextStyle(fontSize: 16),)
                                  ],
                                ),
                              );
                              },
                          );
                        },
                        error: (err, stack) => Text('$err'),
                        loading: () => Container()
                    ),
                  ),
                ],
              );
            }
    ),
      drawer: DrawerWidget(),
    );
  }
}
