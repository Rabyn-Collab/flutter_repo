import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';



final authStream = StreamProvider.autoDispose((ref) => FirebaseAuth.instance.authStateChanges());

final authProvider = Provider((ref) => AuthProvider());
final userStream = StreamProvider.autoDispose((ref) => AuthProvider().getSingleUser());
final usersStream = StreamProvider.autoDispose((ref) => AuthProvider().getUsers());

class AuthProvider{

final userDb = FirebaseFirestore.instance.collection('users');

 Future<void> userSignUp({required String username,
   required String email, required String password,
  required XFile image
 }) async{
   try{
   final ref = FirebaseStorage.instance.ref().child('userImage/${image.name}');
    await ref.putFile(File(image.path));
    final imageUrl = await ref.getDownloadURL();
     final response = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
   await FirebaseChatCore.instance.createUserInFirestore(
     types.User(
       firstName: username,
       id: response.user!.uid,
       imageUrl: imageUrl,
       metadata: {
         'email': email
       }
     ),);

   }on FirebaseAuthException catch (err){
     print(err);

   }


 }



 Future<String> userLogin({required String email, required String password,}) async{
   try{
     final response = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
     return 'success';
   }on FirebaseAuthException catch (err){
     return '${err.code}';
   }
 }

 Future<void> userLogOut() async {
   try {
     final response = await FirebaseAuth.instance.signOut();
   } on FirebaseAuthException catch (err) {
     print(err);
   }
 }



Stream<types.User> getSingleUser(){
   final uid = FirebaseAuth.instance.currentUser!.uid;
 final response = userDb.doc(uid).snapshots();

  final userType = response.map((event) {
    final json = event.data();
      return types.User(
        id: event.id,
        imageUrl: json!['imageUrl'],
        metadata: {
          'email': json['metadata']['email']
        },
        firstName: json['firstName'],
      );
  } );
  return userType;

}


Stream<List<types.User>> getUsers(){
  return userDb.snapshots().map((event) => getUserData(event));
}

List<types.User>  getUserData(QuerySnapshot snapshot){
    final response = snapshot.docs.map((event) {
  final json = event.data() as Map<String, dynamic>;
  return types.User(
    id: event.id,
    imageUrl: json['imageUrl'],
    metadata: {
      'email': json['metadata']['email']
    },
    firstName: json['firstName'],
  );
    }).toList();

    return response;
}


















}

