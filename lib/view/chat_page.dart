import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';


class ChatPage extends StatefulWidget {
 final types.Room room;
 ChatPage(this.room);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {



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
                //  _handleImageSelection();
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



  void _handleSendPressed(types.PartialText message)  async{
    FirebaseChatCore.instance.sendMessage(message, widget.room.id);
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
               //   onMessageTap: _handleMessageTap,
                 // onPreviewDataFetched: _handlePreviewDataFetched,
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
