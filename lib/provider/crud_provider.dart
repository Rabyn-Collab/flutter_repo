import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/api.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import '../models/products.dart';
import '../models/user.dart';
import 'package:http_parser/http_parser.dart';

final productProvider = FutureProvider((ref) => CrudProvider.getProducts());
final crudProvider = Provider((ref) => CrudProvider());

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





  Future<String>  addProducts({required String product_name, required String product_detail,
 required int price , required XFile image
 }) async{
   final dio = Dio();
   final userBox = Hive.box<User>('users').values.toList();
   try{
     final _formData = FormData.fromMap({
       'product_name': product_name,
       'product_detail': product_detail,
       'price': price,
       'image':  await MultipartFile.fromFile(image.path, contentType: MediaType(
           'image', image.path.split('.').last)),
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





 Future<String>  updateProducts({required String product_name, required String product_detail,
   required int price , XFile? image, required String productId, String? imagePath
 }) async{
   final dio = Dio();
   final userBox = Hive.box<User>('users').values.toList();
   try{
     if(image == null){
       final response = await  dio.patch('${Api.updateProduct}/$productId', data: {
         'product_name': product_name,
         'product_detail': product_detail,
         'price': price,
         'photo': 'no need to update'
       }, options: Options(
           headers: {
             HttpHeaders.authorizationHeader:  'Bearer ${userBox[0].token}'
           }
       ));
     }else{
       final _formData = FormData.fromMap({
         'product_name': product_name,
         'product_detail': product_detail,
         'price': price,
         'imageUrl': imagePath,
         'image':  await MultipartFile.fromFile(image.path, contentType: MediaType(
             'image', image.path.split('.').last)),
       });

       final response = await  dio.patch('${Api.updateProduct}/$productId', data: _formData, options: Options(
           headers: {
             HttpHeaders.authorizationHeader:  'Bearer ${userBox[0].token}'
           }
       ));
     }


     return 'success';
   }on DioError catch(err){
     return 'something went wrong';
   }
 }




 Future<String>  removeProduct({required String productId,required String imagePath
 }) async{
   final dio = Dio();
   final userBox = Hive.box<User>('users').values.toList();
   try{

       final response = await  dio.delete('${Api.removeProduct}/$productId', data: {
         'photo': imagePath,
       }, options: Options(
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