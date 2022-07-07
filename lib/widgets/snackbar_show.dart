import 'package:flutter/material.dart';
import 'package:flutter_sample/view/cart_page.dart';
import 'package:get/get.dart';



class  SnackBarProvider{
  static showSnack(BuildContext context, String message){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(milliseconds: 1500),
      content: Text(message),
      action: SnackBarAction(label: 'Go to Cart', onPressed: (){
        Get.to(() => CartPage(), transition:  Transition.leftToRight);
      }),
    ));
  }


}
