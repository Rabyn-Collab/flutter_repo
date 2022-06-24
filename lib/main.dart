import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/view/status_page.dart';
import 'package:get/get.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();


}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  "High_importance_channel",
  "High_importance_channel",
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
const InitializationSettings initializationSettings =
InitializationSettings(
  android: AndroidInitializationSettings("@mipmap/ic_launcher"),
);



void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 runApp(ProviderScope(child: Home()));

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (String? id) async {
      if (id!.isNotEmpty) {
        print("Router Value1234 $id");

        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => DemoScreen(
        //       id: id,
        //     ),
        //   ),
        // );


      }
    },
  );
}





class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
       home: StatusPage(),
    );
  }
}



class PageViews extends StatelessWidget {
  const PageViews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container()
    );
  }
}



class CounterApp extends StatelessWidget {

  int number = 0;

 final numberController = StreamController<int>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: StreamBuilder<int>(
              stream: numberController.stream,
              builder: (context, snapshot) {
                // if(snapshot.connectionState == ConnectionState.waiting){
                //
                // }
                if(snapshot.hasData){
                  return Text('${snapshot.data}', style: TextStyle(fontSize: 20),);
                }else{
                  return  Text('${snapshot.data}', style: TextStyle(fontSize: 20),);
                }
              }
            )
        ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
          numberController.sink.add(number++);
          }, child: Icon(Icons.add),
      ),
    );
  }
}
