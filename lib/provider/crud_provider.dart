import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/api.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

import '../models/products.dart';
import '../models/user.dart';


final productProvider = FutureProvider((ref) => CrudProvider.getProducts());

class CrudProvider{

 static Future<List<Product>>  getProducts() async{
    final dio = Dio();
      try{
        final response = await  dio.get(Api.baseUrl);
        final data = (response.data as List).map((e) => Product.fromJson(e)).toList();
        return data;
      }on DioError catch(err){
         throw '${err.message}';
      }
  }





 static Future<String>  addProducts({required String product_name, required String product_detail,
 required int price , required XFile image
 }) async{
   final dio = Dio();
   final userBox = Hive.box<User>('users').values.toList();
   try{
     final _formData = FormData.fromMap({
       'product_name': product_name,
       'product_detail': product_detail,
       'price': price,
       'image': await MultipartFile.fromFile(image.path, filename: image.name,),
     });

     final response = await  dio.post(Api.addProduct, data: _formData, options: Options(
       headers: {
         HttpHeaders.authorizationHeader:  'Bearer ${userBox[0].token}'
       }
     ));

     return 'success';
   }on DioError catch(err){
     return 'something went wrong';
   }
 }









}