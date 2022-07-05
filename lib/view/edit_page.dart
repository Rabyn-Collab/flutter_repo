import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/provider/crud_provider.dart';
import 'package:flutter_sample/provider/image_provider.dart';
import 'package:flutter_sample/provider/login_provider.dart';

import '../api.dart';
import '../models/products.dart';




class EditPage extends StatelessWidget {
  final Product product;
  EditPage(this.product);

  final _form = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
            builder: (context, ref, child) {
              final image = ref.watch(imageProvider).image;
              return Form(
                key: _form,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  child: ListView(
                    children: [
                      Text('Edit Form', style: TextStyle(fontSize: 20),),
                      SizedBox(height: 10,),

                      TextFormField(
                        controller: titleController..text = product.product_name,
                        validator: (val){
                          if(val!.isEmpty){
                            return 'please provide title';
                          }else if(val.length > 40){
                            return 'maximum limit is 40';
                          }else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'title'
                        ),
                      ),
                      SizedBox(height: 10,),

                      TextFormField(
                       controller: descController..text = product.product_detail,
                        validator: (val){
                          if(val!.isEmpty){
                            return 'please provide description';
                          }else if(val.length > 1400){
                            return 'maximum limit is 1400';
                          }else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'description'
                        ),
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        keyboardType: TextInputType.number,
                           controller: priceController..text = product.price.toString(),
                        validator: (val){
                          if(val!.isEmpty){
                            return 'please provide pricw';
                          }else if(val.length > 14){
                            return 'maximum limit is 14';
                          }else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'price'
                        ),
                      ),
                      SizedBox(height: 15,),
                      InkWell(
                        onTap: (){
                          ref.read(imageProvider).imagePick();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                          ),
                          child: image == null ? Image.network('${Api.baseUrl}/${product.imagePath}'):
                          Image.file(File(image.path)),
                          height: 190,
                        ),
                      ),

                      SizedBox(height: 15,),
                      ElevatedButton(
                          onPressed: () async{
                            _form.currentState!.save();
                            if(_form.currentState!.validate()){
                              FocusManager.instance.primaryFocus!.unfocus();
                              if(image == null){
                             final response = await   ref.read(crudProvider).updateProducts(
                                 product_name: titleController.text.trim(),
                                 product_detail: descController.text.trim(),
                                 productId: product.id,
                               price: int.parse(priceController.text.trim())
                             );
                             ref.refresh(productProvider);
                             if(response == 'success'){
                               Navigator.of(context).pop();
                             }
                              }else{

                                final response = await   ref.read(crudProvider).updateProducts(
                                    product_name: titleController.text.trim(),
                                    product_detail: descController.text.trim(),
                                   productId: product.id,
                                    price: int.parse(priceController.text.trim()),
                                  image: image,
                                  imagePath: product.imagePath
                                );
                                ref.refresh(productProvider);
                                if(response == 'success'){
                                  Navigator.of(context).pop();
                                }
                              }

                            }

                          }, child: Text('Submit')),

                    ],
                  ),
                ),
              );
            }
        )
    );
  }
}
