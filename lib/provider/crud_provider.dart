import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/api.dart';

import '../models/products.dart';


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



}