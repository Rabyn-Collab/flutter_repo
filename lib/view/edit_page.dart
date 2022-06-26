// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_sample/provider/crud_provider.dart';
// import 'package:flutter_sample/provider/image_provider.dart';
// import 'package:flutter_sample/provider/login_provider.dart';
//
//
//
//
// class EditPage extends StatelessWidget {
//
//
//   final _form = GlobalKey<FormState>();
//   final titleController = TextEditingController();
//   final descController = TextEditingController();
//
//   final userId = FirebaseAuth.instance.currentUser!.uid;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Consumer(
//             builder: (context, ref, child) {
//               final image = ref.watch(imageProvider).image;
//               return Form(
//                 key: _form,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
//                   child: ListView(
//                     children: [
//                       Text('Edit Form', style: TextStyle(fontSize: 20),),
//                       SizedBox(height: 10,),
//
//                       TextFormField(
//                         controller: titleController..text = post.title,
//                         validator: (val){
//                           if(val!.isEmpty){
//                             return 'please provide title';
//                           }else if(val.length > 40){
//                             return 'maximum limit is 40';
//                           }else{
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
//                             hintText: 'title'
//                         ),
//                       ),
//                       SizedBox(height: 10,),
//
//                       TextFormField(
//                         controller: descController..text = post.description,
//                         validator: (val){
//                           if(val!.isEmpty){
//                             return 'please provide description';
//                           }else if(val.length > 1400){
//                             return 'maximum limit is 1400';
//                           }else{
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
//                             hintText: 'description'
//                         ),
//                       ),
//                       SizedBox(height: 15,),
//                       InkWell(
//                         onTap: (){
//                           ref.read(imageProvider).imagePick();
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                               border: Border.all(color: Colors.black)
//                           ),
//                           child: image == null ? Image.network(post.imageUrl):
//                           Image.file(File(image.path)),
//                           height: 190,
//                         ),
//                       ),
//
//                       SizedBox(height: 15,),
//                       ElevatedButton(
//                           onPressed: () async{
//                             _form.currentState!.save();
//                             if(_form.currentState!.validate()){
//                               FocusManager.instance.primaryFocus!.unfocus();
//                               if(image == null){
//                              final response = await   ref.read(crudProvider).updatePost(
//                                  title: titleController.text.trim(),
//                                  description: descController.text.trim(),
//                                  postId: post.id
//                              );
//                              if(response == 'success'){
//                                Navigator.of(context).pop();
//                              }
//                               }else{
//
//                                 final response = await   ref.read(crudProvider).updatePost(
//                                     title: titleController.text.trim(),
//                                     description: descController.text.trim(),
//                                     postId: post.id,
//                                   image: image,
//                                   imageName: post.imageName
//                                 );
//                                 if(response == 'success'){
//                                   Navigator.of(context).pop();
//                                 }
//                               }
//
//                             }
//
//                           }, child: Text('Submit')),
//
//                     ],
//                   ),
//                 ),
//               );
//             }
//         )
//     );
//   }
// }
