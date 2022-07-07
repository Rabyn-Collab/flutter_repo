import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/provider/cart_provider.dart';



class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
        body: SafeArea(
          child: Consumer(
              builder: (context, ref, child) {
                final cartData = ref.watch(cartProvider);
                return cartData.isEmpty ? Container(
                  child: Center(child: Text('No item added'),) ,) : Container(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.red,
                        height: h * 0.86,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Text('Total'),
                              ],
                            ),
                            SizedBox(height: 15,),
                            ElevatedButton(onPressed: (){}, child: Text('Check Out'))
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
                ),
        )
    );
  }
}


