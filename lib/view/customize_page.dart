import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/provider/crud_provider.dart';
import 'package:flutter_sample/view/edit_page.dart';
import 'package:get/get.dart';

import '../api.dart';


class CustomizePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
            builder: (context, ref, child) {
              final productData = ref.watch(productProvider);
              return productData.when(
                  data: (data){
                    return ListView.separated(
                      separatorBuilder: (context, n){
                        return Divider(
                          color: Colors.black,
                        );
                      },
                        itemCount: data.length,
                        itemBuilder: (context, index){
                          return ListTile(
                            leading: Container(
                                width: 100,
                                height: 100,
                                child: Image.network('${Api.baseUrl}/${data[index].imagePath}',fit: BoxFit.cover,)),
                          title: Text(data[index].product_name),
                            trailing: Container(
                              width: 100,
                              child: Row(
                                children: [
                               IconButton(
                                   onPressed: (){
                                    Get.to(() => EditPage(data[index]), transition: Transition.leftToRight);
                                   }, icon: Icon(Icons.edit)),
                               IconButton(
                                   onPressed: (){
                                Get.defaultDialog(
                                  title: 'Are you sure ?',
                                  content: Text('You want to remove this post'),
                                  actions: [
                                    TextButton(
                                        onPressed: (){
                                        Navigator.of(context).pop();
                                        }, child: Text('no')),
                                    TextButton(
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                           ref.read(crudProvider).removeProduct(productId: data[index].id, imagePath: data[index].imagePath);
                                           ref.refresh(productProvider);
                                        }, child: Text('yes'))
                                  ]
                                );
                                   }, icon: Icon(Icons.delete)),
                                ],
                              ),
                            ),
                          );
                        });
                  }, error: (err, stack) => Center(child: Text('$err'))
                  , loading: () => Center(child: CircularProgressIndicator()));
            }
    )
    );
  }
}
