import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/api.dart';
import 'package:flutter_sample/models/order.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/cart_item.dart';
import '../models/user.dart';


final orderProvider = Provider((ref) => OrderProvider());
final orderHistory = FutureProvider((ref) => OrderProvider().getOrderHistory());






class OrderProvider{


  Future<String> addOrder({ required int amount, required List<CartItem> carts}) async{
    final userBox = Hive.box<User>('users').values.toList();
    final dio = Dio();
    try{
      final response = await dio.post(Api.createOrder, data: {
           'amount': amount,
        'dateTime': DateTime.now().toString(),
        'products': carts.map((e) => e.toJson()).toList(),
        'userId': userBox[0].id
      }, options: Options(
        headers: {
          HttpHeaders.authorizationHeader:  'Bearer ${userBox[0].token}'
        }
      ));
      return 'success';
    }on DioError catch(err){
      return '${err.message}';
    }

  }


  Future<List<Order>> getOrderHistory() async{
    final userBox = Hive.box<User>('users').values.toList();
    final dio = Dio();
    try{
      final response = await dio.get('${Api.getOrder}/${userBox[0].id}',  options: Options(
          headers: {
            HttpHeaders.authorizationHeader:  'Bearer ${userBox[0].token}'
          }
      ));
       final data = (response.data as List).map((e) => Order.fromJson(e)).toList();
       return data;
    }on DioError catch(err){
      throw '${err.message}';
    }

  }


}
