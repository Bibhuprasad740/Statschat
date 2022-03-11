import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({
    Key? key,
    required this.loggedInUser,
    required this.messageText,
    required this.senderName,
    required this.senderEmail,
    required this.isMe,
  }) : super(key: key);

  final String messageText, senderName, senderEmail;
  final bool isMe;
  final User? loggedInUser;
  Radius topRightBorder = const Radius.circular(30);
  Radius topLeftBorder = const Radius.circular(30);
  Radius bottomLeftBorder = const Radius.circular(30);
  Radius bottomRightBorder = const Radius.circular(30);

  @override
  Widget build(BuildContext context) {
    var dHeight = MediaQuery.of(context).size.height;
    var dWidth = MediaQuery.of(context).size.width;
    if (isMe) {
      topRightBorder = const Radius.circular(0);
      bottomRightBorder = const Radius.circular(40);
    } else {
      topLeftBorder = const Radius.circular(0);
      bottomLeftBorder = const Radius.circular(40);
    }
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: isMe ? dWidth * 0.3 : 5,
            right: isMe ? 5 : dWidth * 0.3,
          ),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.only(
                topLeft: topLeftBorder,
                bottomLeft: bottomLeftBorder,
                bottomRight: bottomRightBorder,
                topRight: topRightBorder),
            color: senderEmail == loggedInUser!.email
                ? Colors.white
                : Colors.blueAccent[100],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isMe ? 'You' : 'User: $senderName',
                    style: TextStyle(
                      color: isMe ? Colors.lightGreen : Colors.brown,
                      //fontFamily: 'Satisfy',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    messageText,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
