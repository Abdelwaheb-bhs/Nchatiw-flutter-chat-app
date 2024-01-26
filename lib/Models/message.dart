import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message{
   final String senderID;
  final String senderEmail; 
 final String recieverID;
 final String message;
 final Timestamp timestamp;
 Message({
   required this.senderID,
   required this.senderEmail,
   required this.recieverID,
   required this.message,
     required this.timestamp,
 });
 Map<String,dynamic> toMap(){
  return {
    'senderId':senderID,
    'senderEmail':senderEmail,
    'recieverId':recieverID,
    'message':message,
    'timestamp':timestamp
  };
 }
}