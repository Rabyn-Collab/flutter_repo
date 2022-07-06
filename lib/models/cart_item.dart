import 'package:hive/hive.dart';
part 'cart_item.g.dart';

    @HiveType(typeId: 1)
    class CartItem extends HiveObject{

      @HiveField(0)
      final String id;

      @HiveField(1)
      final String title;

      @HiveField(2)
      final String imageUrl;

      @HiveField(3)
      final int quantity;

      @HiveField(4)
      final int price;

      @HiveField(5)
      final int total;

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


