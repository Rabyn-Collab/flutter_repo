import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final roomProvider = Provider((ref) => RoomProvider());

final roomStream = StreamProvider.autoDispose((ref) => FirebaseChatCore.instance.rooms());

class RoomProvider {

 Future<types.Room?> createRoom(types.User user) async{

    try{
     final room = await FirebaseChatCore.instance.createRoom(user);
     return room;
    }on FirebaseException catch (err){
       return null;
    }

 }


}