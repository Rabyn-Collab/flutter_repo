import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final counterProvider = ChangeNotifierProvider.family((ref, int n) => CounterProvider(number: n));

final counter1Provider = StateProvider<int>((ref) => 0);



class CounterProvider extends ChangeNotifier{


  CounterProvider({required this.number});

  int number;


  void increment(){
     number++;
     notifyListeners();
  }

  void decrement(){
   number--;
   notifyListeners();
  }



}


