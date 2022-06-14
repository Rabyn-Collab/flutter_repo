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
            //  final image = ref.watch(imageP)
              return Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  child: ListView(
                    children: [
                      Text(isLogin ? 'Login Form': 'Sign Up Form', style: TextStyle(fontSize: 20),),
                      SizedBox(height: 10,),
                      if(!isLogin)    TextFormField(
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
                 if(!isLogin)   Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text('please select an image')),
                        height: 190,
                      ),

                      SizedBox(height: 15,),
                      ElevatedButton(
                          onPressed: (){
                            if(isLogin){

                            }else{

                            }

                      }, child: Text('Submit')),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(isLogin ? 'Don\'t have an account ?'  : 'Already have an account!' ),
                          TextButton(onPressed: (){
                            ref.read(loginProvider.notifier).toggle();
                          }, child: Text(isLogin ? 'Sign Up': 'Login'))
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
    )
    );
  }
}
