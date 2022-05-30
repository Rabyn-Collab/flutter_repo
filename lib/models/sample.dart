






mixin Breathing<T>{
  T breathing();
}



class Human implements Breathing{

  @override
 int breathing() {
    return 90;
  }

}

class Animal implements Breathing{
  @override
 String breathing() {
   return 'sldfkl;ksdf';
  }

}













abstract class L{
  late int amount;
}

abstract class Person {
  late String name;
  late int age;

  void greet(String type);

}


class U{
  late String m;

  U({required this.m});
}

class College implements Person, L{
  College({required this.age, required this.name, required this.amount});

  @override
  int age;

  @override
  String name;

  @override
  void greet(String type) {
    print('hello student');
  }

  @override
  int amount;


}



class Bank implements Person{



   int _balance = 0;
  Bank({required this.age, required this.name});

  @override
  int age;

  @override
  String name;

  @override
  void greet(String type) {
   print('hello customer');
  }


}


