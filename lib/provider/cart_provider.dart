import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/main.dart';
import 'package:flutter_sample/models/cart_item.dart';
import 'package:flutter_sample/models/products.dart';
import 'package:hive_flutter/adapters.dart';




final cartProvider = StateNotifierProvider<CartProvider, List<CartItem>>((ref) => CartProvider(ref.watch(boxB)));

class CartProvider extends StateNotifier<List<CartItem>>{
  CartProvider(super.state);



  String addProductToCart(Product product){
      if(state.isEmpty){
        final newCartItem = CartItem(
            id: product.id,
            price: product.price,
            title: product.product_name,
            quantity: 1,
            total: product.price,
            imageUrl: product.imagePath
        );
        Hive.box<CartItem>('carts').add(newCartItem);
        state = [newCartItem];
        return 'success';
       }else{
        final cart = state.firstWhere((element) => element.id == product.id, orElse: (){
          return CartItem(id: '', price: 0, title: 'no-data', quantity: 0, total: 0, imageUrl: '');
        });
           if(cart.title == 'no-data'){
             final newCartItem = CartItem(
                 id: product.id,
                 price: product.price,
                 title: product.product_name,
                 quantity: 1,
                 total: product.price,
                 imageUrl: product.imagePath
             );
             Hive.box<CartItem>('carts').add(newCartItem);
             state = [...state, newCartItem];
             return 'success';
           }else{
             return 'already added to cart';
           }
      }

  }



  void singleProductAdd(CartItem cartItem){
    cartItem.quantity = cartItem.quantity + 1;
    cartItem.total = cartItem.price * cartItem.quantity;
    cartItem.save();

    state = [
      for(final element in state)
        if(element == cartItem) cartItem else element
    ];

  }

  void singleProductRemove(CartItem cartItem){
    if(cartItem.quantity > 1){
      cartItem.quantity = cartItem.quantity - 1;
      cartItem.total = cartItem.price * cartItem.quantity;
      cartItem.save();

      state = [
        for(final element in state)
          if(element == cartItem) cartItem else element
      ];

    }

  }


  int get total {
    int total = 0;
    state.forEach((element) {
      total += element.quantity * element.price;
    });
    return total;
}




}