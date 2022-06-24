import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:image_picker/image_picker.dart';


class ChatPage extends StatefulWidget {
 final types.Room room;
 ChatPage(this.room);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {


  final uid = FirebaseAuth.instance.currentUser!.uid;
  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

void _handleImageSelection() async{
    final  imageData = await ImagePicker().pickImage(
        source: ImageSource.gallery);
     if(imageData !=null){
       final size = File(imageData.path).lengthSync();
       final ref = FirebaseStorage.instance.ref().child('chatImage/${imageData.name}');
       await ref.putFile(File(imageData.path));
       final imageUrl = await ref.getDownloadURL();
       final message = types.PartialImage(
         name: imageData.name,
         uri: imageUrl,
         size: size,
       );
       FirebaseChatCore.instance.sendMessage(message, widget.room.id);
     }

}

  void _handleSendPressed(types.PartialText message)  async{
    FirebaseChatCore.instance.sendMessage(message, widget.room.id);
    final dio= Dio();

    try{
      final otherUser = widget.room.users.firstWhere((element) => element != uid);
      final response = await dio.post('https://fcm.googleapis.com/fcm/send', data: {
        "notification": {
          "title": "hello firbase project",
          "body": message.text,
          "android_channel_id": "high_importance_channel"
        },
        "to": "${otherUser.metadata!['token']}"

      }, options: Options(
        headers: {
          HttpHeaders.authorizationHeader : 'key=AAAAkbzyPkg:APA91bHB0zqNGfDw7x8tP1ZPCqUwMBED-SJNLLnOR-4TyOAIEsdouLIHwoX2_iraiQoWeE_lRB2HHu3L-R8h7qLRj8aIR6fVBYm_AuByC_wpAWacvrnE9F6iKme9CLed4j4Vp-qBI-N6'
        }
      ));
    }on DioError catch (err){

    }


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<types.Room>(
          stream: FirebaseChatCore.instance.room(widget.room.id),
          initialData: widget.room,
          builder: (context, snapshot) {
            return StreamBuilder<List<types.Message>>(
              initialData: [],
              stream: FirebaseChatCore.instance.messages(snapshot.data!),
              builder: (context, snapshot) {
                return Chat(
                  messages: snapshot.data ?? [],
                  onAttachmentPressed: _handleAtachmentPressed,
                  onSendPressed: _handleSendPressed,
                  showUserAvatars: true,
                  showUserNames: true,
                  user: types.User(
                    id: FirebaseChatCore.instance.firebaseUser?.uid ?? ''
                  ),
                );
              }
            );
          }
        )
    );
  }
}
