




class Product{

  final String id;
  final String product_name;
  final String product_detail;
  final String imagePath;
  final int price;

  Product({
    required this.price,
    required this.product_name,
    required this.imagePath,
    required this.product_detail,
    required this.id
});


  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
        price: json['price'],
        product_name: json['product_name'],
        imagePath: json['image'],
        product_detail: json['product_detail'],
        id: json['_id']
    );
  }



}