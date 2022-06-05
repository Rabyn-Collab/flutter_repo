import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/provider/counter_provider.dart';
import 'package:flutter_sample/view/home_page.dart';
import 'package:get/get.dart';


class Post{

  final int id;
  final String title;
  final String body;

  Post({required this.body, required this.id, required this.title});

  factory Post.fromJson(Map<String, dynamic> json){
    return  Post(
        body: json['body'],
        id: json['id'],
        title: json['title']
    );
  }


}



Future<List<Post>>  getData() async {

  final dio = Dio();
  try{
     final response = await dio.get('https://jsonplaceholder.typicode.com/posts');
     final data = (response.data as List).map((e) => Post.fromJson(e)).toList();
     return data;
  }on DioError catch (err){
    return [];
  }
}


void main () async{
  final m = await getData();
  print(m);
  runApp(ProviderScope(child: Home()));
}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Counter(),
    );
  }
}




class Counter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
        body: SafeArea(
          child: Center(
              child: Consumer(
                builder: (context, ref, child) {
                  final number = ref.watch(counterProvider(20));
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${number.number}', style: TextStyle(fontSize: 50),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                ref.read(counterProvider(20)).increment();
                              }, child: Text('Add')),
                          TextButton(
                              onPressed: () {
                                ref.read(counterProvider(20)).decrement();
                              }, child: Text('sub')),
                        ],
                      )
                    ],
                  );
                }
              )
          ),
        )
    );
  }
}






