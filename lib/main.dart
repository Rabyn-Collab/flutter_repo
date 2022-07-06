import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/models/cart_item.dart';
import 'package:flutter_sample/models/user.dart';
import 'package:flutter_sample/view/status_page.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';


final boxA = Provider<List<User>>((ref) => []);
final boxB = Provider<List<CartItem>>((ref) => []);



void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CartItemAdapter());
 final userBox =  await Hive.openBox<User>('users');
 final cartBox =  await Hive.openBox<User>('carts');
 runApp(ProviderScope(
     overrides: [
       boxA.overrideWithValue(userBox.values.toList().cast<User>()),
       boxB.overrideWithValue(cartBox.values.toList().cast<CartItem>()),
     ],
     child: Home()));


}






class Home extends StatelessWidget {

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
