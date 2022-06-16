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
                    height: 140,
                    child: users.when(
                        data: (data){
                          final dat = data.where((element) => element.id != uid).toList();
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                              itemCount: dat.length,
                              itemBuilder: (context, index){
                              return Image.network(dat[index].imageUrl!);
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
