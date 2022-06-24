import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/provider/auth_provider.dart';
import 'package:flutter_sample/provider/crud_provider.dart';
import 'package:flutter_sample/view/detail_page.dart';
import 'package:flutter_sample/view/edit_page.dart';
import 'package:flutter_sample/view/recent_chats.dart';
import 'package:flutter_sample/view/user_detail.dart';
import 'package:flutter_sample/widgets/drawer_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../notification_service.dart';



class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  late types.User currentUser;


  @override
  void initState() {
    super.initState();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
          (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);

        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

     getToken();
  }



  Future<void> getToken()async{
    final response = await FirebaseMessaging.instance.getToken();
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Social App'),
        actions: [
          TextButton(onPressed: (){
            Get.to(() => RecentChats(), transition: Transition.leftToRight);
          }, child: Text('recent chats', style: TextStyle(color: Colors.white),))
        ],
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
                          currentUser = data.firstWhere((element) => element.id == uid, orElse: (){
                            return types.User(
                              id: 'no data'
                            );
                          });
                          final dat = data.where((element) => element.id != uid).toList();
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                              itemCount: dat.length,
                              itemBuilder: (context, index){
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: InkWell(
                                  onTap: (){
                                    Get.to(() => UserDetail(dat[index]), transition: Transition.leftToRight);
                                  },
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
                     height: 620,
                     padding: EdgeInsets.symmetric(horizontal: 10),
                     child: posts.when(
                         data: (data){
                           return ListView.builder(
                             physics: BouncingScrollPhysics(),
                             shrinkWrap: true,
                             itemCount: data.length,
                               itemBuilder: (context, index){
                               return Container(
                                   height: 366,
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
                                                   Navigator.of(context).pop();
                                          Get.defaultDialog(
                                            title: 'Are you sure',
                                            content: Text('remove this post'),
                                            actions: [
                                              TextButton(onPressed: (){
                                                ref.read(crudProvider).removePost(
                                                    postId: data[index].id,
                                                    imageName: data[index].imageName
                                                );
                                                Navigator.of(context).pop();
                                              }, child: Text('Yes')),
                                              TextButton(onPressed: (){
                                                Navigator.of(context).pop();
                                              }, child: Text('No')),
                                            ]
                                          );
                                                 },
                                                 icon:Icon(Icons.delete)),
                                           ]
                                         );
                                       }, icon: Icon(Icons.edit))
                                         ],
                                       ),
                                       if(uid != data[index].userId)  SizedBox(height: 20,),
                                       InkWell(
                                         onTap: (){
                                           Get.to(() => DetailPage(data[index], currentUser), transition: Transition.leftToRight);
                                         },
                                         child: CachedNetworkImage(
                                          imageUrl: data[index].imageUrl,
                                           height: 260,
                                           fit: BoxFit.fitHeight,),
                                       ),
                                       SizedBox(height: 10,),
                                       Container(
                                           width: double.infinity,
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [

                                               Text(data[index].description, overflow: TextOverflow.ellipsis, maxLines: 2,),
                                           if(data[index].userId != uid)  Row(
                                             children: [
                                               IconButton(onPressed: (){
                                                  if(data[index].like.usernames.contains(currentUser.firstName)){
                                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                         duration: Duration(seconds: 1),
                                                         content: Text('you have already like this post')));
                                                  }else{
                                                    ref.read(crudProvider).addLike(
                                                        like: data[index].like.likes,
                                                        username: currentUser.firstName!,
                                                        postId: data[index].id
                                                    );
                                                  }

                                               }, icon: Icon(Icons.thumb_up)),
                                               if(data[index].like.likes !=0) Text('${data[index].like.likes}')
                                             ],
                                           )
                                             ],
                                           ))
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
