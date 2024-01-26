import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nchatiw_1/Screens/chatPage.dart';
import 'package:nchatiw_1/Screens/chatScreen.dart';
import 'package:nchatiw_1/Screens/homeScreen.dart';
import 'package:nchatiw_1/Services/authServ.dart';
import 'package:nchatiw_1/Services/chatServ.dart';
import 'package:nchatiw_1/Widgets/myDrawer.dart';
import 'package:nchatiw_1/Widgets/userTitle.dart';

class MainScreen extends StatefulWidget {
  static const screenroute ='main-screen';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void logOut(){
    final auth= AuthServ();
    auth.signOut();

  }
  final _auth=FirebaseAuth.instance;
  final ChatServ _chatServ = ChatServ();
  User? getCurrentUser (){
    return _auth.currentUser;
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary ,
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor ,
        actions: [
          IconButton(onPressed: (){
             _auth.signOut();
              Navigator.popAndPushNamed(context,welcomeScreen.screenroute);
          }, icon: Icon(Icons.logout))
        ],
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }
  Widget _buildUserList(){
    return StreamBuilder(
      stream: _chatServ.getUsersStream(),
     builder:(context,snapshot){
      if(snapshot.hasError){
        return const Text("Error");
      }
      if(snapshot.connectionState==ConnectionState.waiting){
        return const Text("Loading....");
      }
      return ListView(
        children: snapshot.data!.map<Widget>((userdata) => _buildUserListItem(userdata,context)).toList(),
      );
     } );
  }
  Widget _buildUserListItem(Map<String,dynamic> userdata,BuildContext context){
    String m=userdata["email"][0];
    String M=m.toUpperCase();
    if (userdata["email"]!=_auth.currentUser!.email) {
      return GestureDetector(
        onTap: () {
                Navigator.push(context,
                 MaterialPageRoute(builder: (context)=>ChatPage(recieverEmail: userdata["email"]
                 ,recieverID: userdata["uid"] ,)));
              },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:   Theme.of(context).colorScheme.secondary,
            ),
            
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
              children: [
                CircleAvatar(child: Text(M,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                backgroundColor:Color.fromARGB(255, 15, 179, 143) ,),
                SizedBox(width: 10,),
                UserTitle(
                  text: userdata["email"],
                  onTap: () {
                    Navigator.push(context,
                     MaterialPageRoute(builder: (context)=>ChatPage(recieverEmail: userdata["email"]
                     ,recieverID: userdata["uid"] ,)));
                  },
                ),
              ],
                ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    } 
  }
}

