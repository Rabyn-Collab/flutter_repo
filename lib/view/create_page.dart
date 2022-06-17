import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/provider/crud_provider.dart';
import 'package:flutter_sample/provider/image_provider.dart';
import 'package:flutter_sample/provider/login_provider.dart';
import 'package:get/get.dart';




class CreatePage extends StatelessWidget {

  final _form = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();

  final userId = FirebaseAuth.instance.currentUser!.uid;
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
                      Text('Create Form', style: TextStyle(fontSize: 20),),
                      SizedBox(height: 10,),

                      TextFormField(
                        controller: titleController,
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
                        controller: descController,
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
                       InkWell(
                        onTap: (){
                          ref.read(imageProvider).imagePick();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                          ),
                          child: image == null ? Center(child: Text('please select an image')):
                          Image.file(File(image.path)),
                          height: 190,
                        ),
                      ),

                      SizedBox(height: 15,),
                      ElevatedButton(
                          onPressed: () async{
                            _form.currentState!.save();
                            if(_form.currentState!.validate()){
                              FocusScope.of(context).unfocus();
                                if(image == null){
                                  Get.defaultDialog(
                                      title: 'image required',
                                      content: Text('please select an image'),
                                      actions: [
                                        TextButton(
                                            onPressed: (){
                                              Navigator.of(context).pop();
                                            }, child: Text('close'))
                                      ]
                                  );
                                }else{
                                  final response = ref.read(crudProvider).postAdd(
                                      title: titleController.text.trim(),
                                      description: descController.text.trim(),
                                      userId: userId,
                                      image: image);
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
