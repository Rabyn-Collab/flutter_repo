import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/provider/auth_provider.dart';
import 'package:flutter_sample/provider/crud_provider.dart';
import 'package:flutter_sample/view/edit_page.dart';
import 'package:flutter_sample/widgets/drawer_widget.dart';
import 'package:get/get.dart';



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
              final posts = ref.watch(postStream);
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

                   SizedBox(height: 10,),
                   Container(
                     padding: EdgeInsets.symmetric(horizontal: 10),
                     child: posts.when(
                         data: (data){
                           return ListView.builder(
                             shrinkWrap: true,
                             itemCount: data.length,
                               itemBuilder: (context, index){
                               return Container(
                                   height: 360,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Expanded(
                                             child: Text(data[index].title,
                                             overflow: TextOverflow.ellipsis, maxLines: 2,),
                                           ),
                                       if(uid == data[index].userId)    IconButton(onPressed: (){
                                         Get.defaultDialog(
                                           title: 'edit page',
                                           content: Text('Customize your post'),
                                           actions: [
                                             IconButton(
                                                 onPressed: (){
                                                   Navigator.of(context).pop();
                                                   Get.to(() => EditPage(data[index]), transition: Transition.leftToRight);

                                                 }, icon: Icon(Icons.edit)),
                                             IconButton(
                                                 onPressed: (){

                                                 },
                                                 icon:Icon(Icons.delete)),
                                           ]
                                         );
                                       }, icon: Icon(Icons.edit))
                                         ],
                                       ),
                                       if(uid != data[index].userId)  SizedBox(height: 20,),
                                       Image.network(data[index].imageUrl,
                                         height: 260,
                                         fit: BoxFit.fitHeight,),
                                       SizedBox(height: 10,),
                                       Container(
                                           width: double.infinity,
                                           child: Text(data[index].description, overflow: TextOverflow.ellipsis, maxLines: 2,))
                                     ],
                                   ));
                               });
                         },
                         error: (err, stack) => Center(child: Text('$err')),
                         loading: () => Center(child: CircularProgressIndicator(
              color: Colors.purple,
              ))
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
