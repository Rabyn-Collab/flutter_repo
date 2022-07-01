import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/main.dart';
import 'package:flutter_sample/models/user.dart';
import 'package:hive/hive.dart';

import '../api.dart';



final userProvider = StateNotifierProvider<UserProvider, List<User>>((ref) => UserProvider(ref.read(boxA)));

class UserProvider extends StateNotifier<List<User>>{
  UserProvider(super.state);



  Future<String> userSignUp({required String username, required String email, required String password}) async{
    final dio = Dio();
    try{
      final response =  await dio.post(Api.userSignUp, data: {
        'email': email,
        'full_name': username,
        'password': password
      });

      final newUser = User.fromJson(response.data);
      Hive.box<User>('users').add(newUser);
      state = [newUser];
      return 'success';
    }on DioError catch (err){
      return '${err.message}';
    }

  }


  Future<String> userLogin({required String email, required String password}) async{
    final dio = Dio();
    try{
      final response =  await dio.post(Api.userLogin, data: {
        'email': email,
        'password': password
      });

      final newUser = User.fromJson(response.data);
      Hive.box<User>('users').add(newUser);
      state = [newUser];
      return 'success';
    }on DioError catch (err){
      return '${err.message}';
    }

  }


  void clearBox(){
    Hive.box<User>('users').clear();
    state = [];
  }



}