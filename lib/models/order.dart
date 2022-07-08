import 'cart_item.dart';




class Order{

 final int amount;
 final String dateTime;
 final List<CartItem> products;
 final String  userId;


 Order({
   required this.dateTime,
   required this.amount,
   required this.products,
   required this.userId
});


 factory Order.fromJson(Map<String, dynamic> json){
   return Order(
       dateTime: json['dateTime'],
       amount: json['amount'],
       products: json['products'],
       userId: json['userId']
   );

 }

}