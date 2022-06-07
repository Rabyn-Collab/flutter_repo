import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/services/movie_service.dart';
import 'package:flutter_sample/view/home_page.dart';
import 'package:get/get.dart';




void main (){

  runApp(ProviderScope(child: Home()));
}



class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomePage(),
    );
  }
}
