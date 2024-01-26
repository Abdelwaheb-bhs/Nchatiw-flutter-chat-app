import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nchatiw_1/Models/message.dart';

class ChatServ{
  final FirebaseFirestore _db=FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<List<Map<String,dynamic>>> getUsersStream(){
    return _db.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }
  Future<void> sendMessage(String recieverID,message)async{
    //get current info
      final String currentUserID = _auth.currentUser!.uid;
      final String currentUserEmail = _auth.currentUser!.email!;
      final Timestamp timestamp = Timestamp.now();
    //create new message
    Message newMessage = Message(
      senderID: currentUserID,
       senderEmail: currentUserEmail, 
       recieverID: recieverID,
        message: message,
         timestamp: timestamp);
    // constract chatroom Id for the two users(nthabtou ken houma ya7kiw)
    List<String> ids = [currentUserID,recieverID];
    ids.sort();//yetratbou , bch nthabet li chatroom nafsha 3and zouz
    String idRoom = ids.join('_');
    //save new message
    await _db
    .collection('Chats')
    .doc(idRoom).
    collection('messages')
    .add(newMessage.toMap());
  }
   Stream<QuerySnapshot> getMessages(String userID , otheruserID){
    List<String> ids = [userID,otheruserID];
    ids.sort();//yetratbou , bch nthabet li chatroom nafsha 3and zouz
    String idRoom = ids.join('_');
    //save new message
    return _db
    .collection('Chats')
    .doc(idRoom).
    collection('messages')
    .orderBy("timestamp",descending: false)
    .snapshots();
  }
}