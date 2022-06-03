import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/provider/counter_provider.dart';
import 'package:flutter_sample/view/home_page.dart';
import 'package:get/get.dart';



void main (){
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






