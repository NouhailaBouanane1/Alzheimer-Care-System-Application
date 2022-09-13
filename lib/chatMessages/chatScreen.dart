import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../mode_model.dart';

final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  final String reciver;
  final String sender;
  final Mode userMode;
  const ChatScreen(
      {Key? key,
      required this.reciver,
      required this.sender,
      required this.userMode})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final mesageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late CollectionReference msgsRef;

  final CollectionReference _notificationsRef =
      FirebaseFirestore.instance.collection('Notifications');
  String?
      messageText; //message that will be saved in the firebase this will give us the message

//to check if ther is a user that is sign in or not
  @override
  void initState() {
    super.initState();
    if (widget.userMode.userMode == 'Patients') {
      msgsRef = FirebaseFirestore.instance
          .collection('messages')
          .doc(widget.reciver + widget.sender)
          .collection('Chat');
    } else {
      msgsRef = FirebaseFirestore.instance
          .collection('messages')
          .doc(widget.sender + widget.reciver)
          .collection('Chat');
    }
  }

  /*void messageStreams() async{
    await for(var snapshot in _firestore.collection('messages').snapshots()){
      for(var message in snapshot.docs){
        //snapshot will listen to every change
        print(message.data());
      }}
    }*/

  //this method will bring data from the firestore

  @override
  Widget build(BuildContext context) {
    var _user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Row(
          children: [
            Image.asset(
              'images/messages.jpg',
              width: 35,
              height: 35,
            ),
            SizedBox(
              width: 14,
            ),
            Text(
              AppLocalizations.of(context)!.chat,
              style: TextStyle(
                color: Colors.white,
                fontSize: 27,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            messageStreamBuilder(
              msgsRef: msgsRef,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFCE93D8),
                    width: 3,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: mesageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText:
                            AppLocalizations.of(context)!.writeYourMessage,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      mesageTextController
                          .clear(); //in order to clear text field after pressing send
                      msgsRef.add({
                        'text': messageText,
                        'sender': _user.uid,
                        'name': _user.displayName,
                        'time': FieldValue
                            .serverTimestamp(), //function built in firbase to give time
                      });
                      _notificationsRef.add({
                        'receiverUid': widget.reciver,
                        'senderUid': widget.sender,
                        'senderName': _user.displayName,
                      });
                    },
                    child: Text(
                      AppLocalizations.of(context)!.send,
                      style: TextStyle(
                        color: Color(0xFF4A148C),
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class messageStreamBuilder extends StatefulWidget {
  final CollectionReference msgsRef;
  const messageStreamBuilder({Key? key, required this.msgsRef})
      : super(key: key);

  @override
  State<messageStreamBuilder> createState() => _messageStreamBuilderState();
}

class _messageStreamBuilderState extends State<messageStreamBuilder> {
  @override
  Widget build(BuildContext context) {
    var _user = FirebaseAuth.instance.currentUser!;

    return StreamBuilder<QuerySnapshot>(
      stream: widget.msgsRef.orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<MessageLine> messageWidgets = [];
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.purple,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        for (var message in messages) {
          final messageText = message.get('text');
          final messageSender = message.get('name');
          final msgUid = message.get('sender');
          final currentUser = _user.uid;

          final messageWidget = MessageLine(
            sender: messageSender,
            text: messageText,
            isMe: msgUid == currentUser,
          );
          messageWidgets.add(messageWidget);
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({this.sender, this.text, required this.isMe, Key? key})
      : super(key: key);
  final String? sender;
  final String? text;
  final bool? isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.purple[500],
            ),
          ),
          Material(
            elevation: 5,
            borderRadius: isMe!
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            color: isMe! ? Colors.blue[500] : Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                '$text',
                style: TextStyle(
                    fontSize: 40,fontWeight: FontWeight.bold ,color: isMe! ? Colors.white : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
