import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nchatiw_1/Screens/mainScreen.dart';
import 'package:nchatiw_1/Services/authServ.dart';
import 'package:nchatiw_1/Services/chatServ.dart';

class ChatPage extends StatefulWidget {
  final String recieverEmail;
  final String recieverID;
   ChatPage({super.key, required this.recieverEmail, required this.recieverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatServ chatServ = ChatServ();

  final AuthServ authServ = AuthServ();

  final _auth=FirebaseAuth.instance;

  final TextEditingController messageController = TextEditingController();

  void sendMessage() async{
    if (messageController.text.isNotEmpty) {
      await chatServ.sendMessage(widget.recieverID, messageController.text);
      messageController.clear();
    }
  }

  @override
  
  User? getCurrentUser (){
    return _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(title: Text('${widget.recieverEmail}')
      ,backgroundColor:Theme.of(context).appBarTheme.backgroundColor ,
      shadowColor: Theme.of(context).colorScheme.error,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      )),),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList(){
    String senderId = this.getCurrentUser()!.uid;
    return Container(
  decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.primary,
    
  ),
      child: StreamBuilder(stream: chatServ.getMessages(widget.recieverID, _auth.currentUser!.uid),
       builder: (context,snapshot){
        if (snapshot.hasError) {
          return Text("has error");
        }
        if (snapshot.connectionState==ConnectionState.waiting) {
          return Text("Loading...");
        }
        return ListView(
          children: snapshot.data!.docs
          .map((doc) => _buildMessageItem(doc)).toList(),
        );
       }),
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String,dynamic> data = doc.data() as Map<String,dynamic> ;
    var alignment = (data["senderId"]==_auth.currentUser!.uid)?Alignment.centerRight
    :Alignment.centerLeft;
    
    return Container(
      alignment: alignment,
      child: MessageBox(isMe: data["senderId"]==_auth.currentUser!.uid,
      text: data["message"],sender:data["senderEmail"] ,)
    );
  }

  Widget buildUserInput(){
    return 
         Container(
           decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              border: Border(
                top: BorderSide(
                  color: Color.fromARGB(255, 12, 203, 171),
                  width: 2,
                )
              )
            ),
           child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Expanded(
                 child: TextField(
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  controller: messageController,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintStyle:TextStyle(color: Theme.of(context).primaryColor) ,
                    fillColor:Theme.of(context).primaryColor ,
                    labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                            contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20, ),
                            hintText: 'Write your message here..',
                            border: InputBorder.none,
                          ),
                 ),
               ),
               IconButton(onPressed: sendMessage, icon: Icon(Icons.send,color: Color.fromARGB(255, 4, 208, 143),))
             ],
           ),
         );
  }
}
class MessageBox extends StatelessWidget {
  const MessageBox({ this.text ,  this.sender ,required this.isMe, Key?key}):super(key: key);
  final String? sender;
  final String? text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text('$sender',style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary),),
          Material(
            shadowColor: Theme.of(context).colorScheme.error,
            elevation: 5,
            borderRadius: BorderRadius.only(
              topLeft:isMe? Radius.circular(15):Radius.circular(0),
              bottomLeft: Radius.circular(15),
              bottomRight:Radius.circular(15),
              topRight:isMe?Radius.circular(0): Radius.circular(15),
            ),
            color: isMe? Color.fromARGB(255, 247, 196, 114):Theme.of(context).focusColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 20),
              child: Text('$text',
              style:  isMe? TextStyle(fontSize: 15,color: const Color.fromARGB(255, 0, 0, 0)):TextStyle(fontSize: 15,color: Colors.white),),
            ),
          ),
        ],
      ),
    );
              
  }
}