import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
  final _fireStore = FirebaseFirestore.instance;
  late User SigninUser;
  

class Chatscreen extends StatefulWidget {
      static const screenroute ='chat-screen';
  

  const Chatscreen({super.key});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  String? message;
  final messageController = TextEditingController();
  final _auth=FirebaseAuth.instance;
  
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser (){
    try {
      final user = _auth.currentUser;
    if (user!=null) {
      SigninUser=user;
    }
    } catch (e) {
      print(e);
    }
  }
  // void getMessages () async{
    // final messages = await _fireStore.collection('messages').get();
    // for(var message in messages.docs){
      // print(message.data());
    // }
  // }
  void streamMeassages ()async{
   await for (var snapshot in  _fireStore.collection('messages').snapshots()){
    for(var message in snapshot.docs){
      print(message.data());
    }
   }
  }
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(255, 12, 215, 181),
      body: SafeArea(
    child: ListView(
      children:[ Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Nchatiw',style: TextStyle(fontSize:35,color: Colors.white ),),
              ),
              IconButton(onPressed:(){
                _auth.signOut();
                Navigator.pop(context);
              }, icon: Icon(Icons.exit_to_app,size: 40,color: Color.fromARGB(255, 255, 255, 255),),),
            ],
          ),
          //SizedBox(height: 10,),
          Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 0, bottom: 0.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.2,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children:[
            
             MessageStream()
          ]),
          ),
          Container(
            
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
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
                Expanded(child: TextField(
                  controller: messageController,
                  onChanged: (value) {
                    message=value;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20, ),
                    hintText: 'Write your message here..',
                    border: InputBorder.none,
                  ),
                ),
                ),
                TextButton(
                  onPressed: (){
                    messageController.clear();
                    _fireStore.collection('messages').add({
                      'text': message,
                      'sender':SigninUser.email,
                      'time':FieldValue.serverTimestamp(),
                    });
                  },
                 child: Text('send',style: TextStyle(
                  color: Color.fromARGB(255, 11, 220, 235),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
    
                 ),),
                 )
              ],
            ),
          ),
        ],
      ),
    ])
      
      
      
      ),
      
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
          stream: _fireStore.collection('messages').orderBy('time').snapshots(),
          builder: (context, snapshot ){
            List<MessageBox> messagesWidgets =[];
            if (!snapshot.hasData) {
              
            }
            final messages = snapshot.data!.docs.reversed;
            for (var message in messages) {
              final messageText = message.get('text');
              final messageSender = message.get('sender');
              final currentUser = SigninUser.email;
              final messagesWidget = MessageBox(text: messageText,sender: messageSender,
              isMe:currentUser==messageSender ,);
              messagesWidgets.add(messagesWidget);
            }
            return Expanded(
              child: ListView(
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                children: messagesWidgets,
              ),
            );
          });
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
          Text('$sender',style: TextStyle(fontSize: 12, color: Colors.black45),),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.only(
              topLeft:isMe? Radius.circular(15):Radius.circular(0),
              bottomLeft: Radius.circular(15),
              bottomRight:Radius.circular(15),
              topRight:isMe?Radius.circular(0): Radius.circular(15),
            ),
            color: isMe? Color.fromARGB(255, 247, 196, 114):Color.fromARGB(255, 0, 193, 164),
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