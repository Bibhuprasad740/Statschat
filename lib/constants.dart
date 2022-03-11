import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintText: 'Type your message here...',
    border: InputBorder.none,
    fillColor: Colors.black);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kHeadingStyle = TextStyle(
  fontSize: 50,
  fontFamily: 'Satisfy',
  color: Colors.yellow,
  fontWeight: FontWeight.bold,
);

const kTitleStyle = TextStyle(
    //fontFamily: 'DancingScript',
    fontSize: 59,
    fontWeight: FontWeight.w900,
    color: Colors.blueAccent,
    letterSpacing: 6);

const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.grey),
  fillColor: Colors.white,
  hintText: 'Enter a something',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
