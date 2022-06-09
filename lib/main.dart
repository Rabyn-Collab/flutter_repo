import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/services/movie_service.dart';
import 'package:flutter_sample/view/home_page.dart';
import 'package:get/get.dart';

import 'provider/movie_provider.dart';




void main (){
  runApp(ProviderScope(child: Home()));
}

//
// class User{
//   final int age;
//   final String username;
//
//   User({required this.username, required this.age}){
//           some();
//   }
//
//   User.initState(): age=90, username='hello';
//
//   User copyWith({String? username, int? age}){
//       return User(
//           username: username ?? this.username,
//           age: age !=null ? age++ :   this.age
//       );
//   }
//
//
//   void  some(){
//     print('heelo');
//   }
//
//
//
// }
//
//
// final counterProvider = StateNotifierProvider<Counter, int>((ref) => Counter(0));
//
// class Counter extends StateNotifier<int>{
//   Counter(super.state);
//
//   void increment(){
//     state++; // state = 0;
//   }
//
//
//   void decrement(){
//     state--; // state = 0;
//   }
//
//
// }






class Home extends StatelessWidget {
 // const Home({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


class CounterApp extends StatefulWidget {
  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  // User user = User.initState();
  //
  // final u = User(username: 's;dlkf;lsd0', age: 90);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          //final counter = ref.watch(counterProvider);
          final movieState = ref.watch(movieProvider);
          if(movieState.movies.isNotEmpty){
            print(movieState.movies[0].title);
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    // Text(user.username, style: TextStyle(fontSize: 50),),
                    // Text('${user.age}', style: TextStyle(fontSize: 50),),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: (){



              }, child: Text('some'))
            ],
          );
        }
      ),
    );
  }
}
