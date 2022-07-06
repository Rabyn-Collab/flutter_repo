import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/main.dart';
import 'package:flutter_sample/models/cart_item.dart';




final cartProvider = StateNotifierProvider((ref) => CartProvider(ref.watch(boxB)));

class CartProvider extends StateNotifier<List<CartItem>>{
  CartProvider(super.state);


}