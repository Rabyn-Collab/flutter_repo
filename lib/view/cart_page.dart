import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/api.dart';
import 'package:flutter_sample/provider/cart_provider.dart';



class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
          child: Consumer(
              builder: (context, ref, child) {
                final cartData = ref.watch(cartProvider);
                final total = ref.watch(cartProvider.notifier).total;
                return cartData.isEmpty ? Container(
                  child: Center(child: Text('No item added'),) ,) : Container(
                  child: Column(
                    children: [
                      Container(
                        height: h * 0.86,
                        child: ListView.builder(
                            itemCount: cartData.length,
                            itemBuilder: (context, index){
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        height:  h * 0.2,
                                        child: Image.network(
                                            '${Api.baseUrl}/${cartData[index].imageUrl}', width: w*0.4,fit: BoxFit.fitHeight,)),

                                   Spacer(),
                                    Container(
                                      height:  h * 0.2,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(cartData[index].title),
                                          Text(cartData[index].quantity > 1 ? 'Rs. ${cartData[index].total}' :'Rs. ${cartData[index].price}'),
                                          Text('x   ${cartData[index].quantity}'),
                                          Row(
                                            children: [
                                              OutlinedButton(
                                                  onPressed: (){
                                                ref.read(cartProvider.notifier).singleProductAdd(cartData[index]);
                                                  }, child:Icon(Icons.add)
                                              ),
                                              SizedBox(width: 25,),
                                              OutlinedButton(
                                                  onPressed: (){
                                                    ref.read(cartProvider.notifier).singleProductRemove(cartData[index]);

                                                  }, child:Icon(Icons.remove)
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Text('Total'),
                                Spacer(),
                                Text('$total', style: TextStyle(fontSize: 17),)
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


