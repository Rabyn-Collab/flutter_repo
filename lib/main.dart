import 'package:flutter/material.dart';
import 'package:flutter_sample/models/sample.dart';


//inheritance, abstraction, encapsulation, polymorphism


extension sDop on String{
  String doubleTo(){
    return  this + ' ' +  'hello';
  }

}

void main (){

String greet = 'Ram';
print(greet.toUpperCase());
print(greet.doubleTo());


}




