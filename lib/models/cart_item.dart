import 'package:hive/hive.dart';
part 'cart_item.g.dart';

    @HiveType(typeId: 1)
    class CartItem extends HiveObject{

      @HiveField(0)
      late String id;

      @HiveField(1)
      late String title;

      @HiveField(2)
      late String imageUrl;

      @HiveField(3)
      late int quantity;

      @HiveField(4)
      late int price;

      @HiveField(5)
      late int total;

      CartItem({
        required this.id,
        required this.price,
        required this.title,
        required this.quantity,
        required this.total,
        required this.imageUrl
    });

      factory CartItem.fromJson(Map<String, dynamic> json){
        return CartItem(
            id: json['id'],
          title: json['title'],
          price: json['price'],
          imageUrl: json['imageUrl'],
          quantity: json['quantity'],
          total: json['total']
        );
      }


      @override
      String toString() {
        return 'CartItem('
            'title:$total'
           'price: $price '
           'imageUrl: $imageUrl'
           'quantity: $quantity'
           'total: $total'
          ')';
      }



    }


