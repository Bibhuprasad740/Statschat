import 'package:flutter/material.dart';
import 'package:statschat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:statschat/message_bubble.dart';

User? loggedInUser;
String senderEmail = '';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat-screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? message;
  var textFieldController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _authentication = FirebaseAuth.instance;
  String loggedInUserName = '';
  bool isMe = false;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = _authentication.currentUser;
      loggedInUser = user;
      loggedInUserName = (user?.displayName).toString();
    } catch (e) {
      print(e);
    }
  }

  // void messagesStream() async {
  //   await for (var snapshot in _firestore.collection('messages').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       messageData = message.data();
  //       messagesText.add(messageData['messageText']); // individual messages in the messageObject instance
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mark_chat_read_rounded),
            tooltip: 'Show Chats!',
          ),
          IconButton(
              //TODO: fix this error of animation controller
              /**
             * sometimes while logging out gives 
                    *   ════════ Exception caught by animation library ══════════
                                                    Assertion failed:
                                                    ..\…\widgets\framework.dart:4234
                                                    _lifecycleState != _ElementLifecycle.defunct
                                                    is not true
                            -->this error<--
             */
              tooltip: 'Logout',
              icon: const Icon(Icons.logout_outlined),
              onPressed: () async {
                try {
                  await _authentication.signOut();
                  Navigator.pop(context);
                  Navigator.pop(context);
                } catch (e) {
                  print(e);
                }
              }),
        ],
        title: Text(loggedInUserName),
        backgroundColor: Colors.blueAccent[100],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              builder: (context, snapshot) {
                List<Widget> messageWidgets = [];
                if (!snapshot.hasData) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    ),
                  );
                }
                var messages = snapshot.data!.docs;
                for (var message in messages) {
                  var messageObject = message.data() as Map;
                  var messageText = messageObject['messageText'] as String;
                  senderEmail = messageObject['senderEmail'] as String;
                  isMe = senderEmail == loggedInUser!.email;
                  var senderName = messageObject['senderName'] as String;
                  messageWidgets.add(
                    MessageBubble(
                      messageText: messageText,
                      senderName: senderName,
                      senderEmail: senderEmail,
                      isMe: isMe,
                      loggedInUser: loggedInUser,
                    ),
                  );
                }
                messageWidgets.reversed;
                return Expanded(
                  child: ListView(
                    children: messageWidgets,
                  ),
                );
              },
              stream: _firestore.collection('messages').snapshots(),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      controller: textFieldController,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        textFieldController.clear();
                      });
                      _firestore.collection('messages').add({
                        'messageText': message,
                        'senderEmail': (loggedInUser?.email).toString(),
                        'senderName': loggedInUserName,
                      });
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
