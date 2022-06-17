import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/provider/auth_provider.dart';
import 'package:flutter_sample/view/create_page.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer(
        builder: (context, ref, child) {
          final userData = ref.watch(userStream);
          return userData.when(
              data: (data){
                return ListView(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(data.imageUrl!))
                      ),
                        child: Text(data.metadata!['email'])
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();

                      },
                      leading: Icon(Icons.av_timer),
                      title: Text(data.firstName!),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.to(() => CreatePage(), transition: Transition.leftToRight);
                      },
                      leading: Icon(Icons.add),
                      title: Text('Create Post'),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        ref.read(authProvider).userLogOut();
                      },
                      leading: Icon(Icons.exit_to_app),
                      title: Text('LogOut'),
                    )
                  ],
                );
              },
              error: (err, stack) => Center(child: Text('$err')),
              loading: () => Center(child: CircularProgressIndicator(
                color: Colors.purple,
              ),)
          );
        }
      ),
    );
  }
}
