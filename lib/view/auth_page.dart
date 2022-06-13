import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/provider/login_provider.dart';




class AuthPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
            builder: (context, ref, child) {
              final isLogin = ref.watch(loginProvider);
              return Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  child: ListView(
                    children: [
                      Text(isLogin ? 'Login Form': 'Sign Up Form', style: TextStyle(fontSize: 20),),
                      SizedBox(height: 10,),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'username'
                        ),
                      ),
               SizedBox(height: 10,),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: 'email'
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: 'password'
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text('please select an image')),
                        height: 190,
                      ),

                      SizedBox(height: 15,),
                      ElevatedButton(onPressed: (){

                      }, child: Text('Submit'))
                    ],
                  ),
                ),
              );
            }
    )
    );
  }
}
