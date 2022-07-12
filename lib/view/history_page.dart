import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/provider/order_provider.dart';
import 'package:intl/intl.dart';

import '../api.dart';



class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Consumer(
              builder: (context, ref, child) {
                final orderData = ref.watch(orderHistory);
                return  orderData.when(
                    data: (data){
                      return ListView.separated(
                        separatorBuilder: (ctx, n){
                          return Divider(
                            color: Colors.black,
                            height: 50,
                            thickness: 9,
                          );
                        },
                          itemCount: data.length,
                          itemBuilder: (context, index){
                          final date = DateTime.parse(data[index].dateTime);
                          final d = DateFormat.jm().format(date);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('$d'),
                                  SizedBox(height: 15,),
                                  Column(
                                    children: data[index].products.map((e) {
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 7, left: 10, right: 10),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Image.network('${Api.baseUrl}/${e.imageUrl}',
                                            height: 120,
                                            ),
                                            Spacer(),
                                            Column(
                                              children: [
                                                Text(e.title),
                                                SizedBox(height: 10,),
                                                Text('X  ${e.quantity}'),
                                                SizedBox(height: 10,),
                                                Text('${e.price}')
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  SizedBox(height: 15,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total:-'),
                                      Text('${data[index].amount}'),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }
                      );
                    },
                    error: (err, stack) => Text('$err'),
                    loading: () => Center(child: CircularProgressIndicator(),)
                );
              }
               ),
        )
    );
  }
}
