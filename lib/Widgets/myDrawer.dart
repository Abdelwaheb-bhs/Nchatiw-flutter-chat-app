import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nchatiw_1/Screens/mainScreen.dart';
import 'package:nchatiw_1/screens/homeScreen.dart';

class MyDrawer extends StatelessWidget {
  
  const MyDrawer({super.key});

  
  @override
  Widget build(BuildContext context) {
    final _auth=FirebaseAuth.instance;
    String m=_auth.currentUser!.email as String;
    String M=m[0].toUpperCase();
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          DrawerHeader(
            child:Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Text(M,style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 50),),
                    backgroundColor:Color.fromARGB(255, 15, 179, 143) ,
                ),
                SizedBox(height: 5,),
                Text(m,style: TextStyle(color: Theme.of(context).primaryColor),),
              ],
            ),
          ) ),
          ListTile(
            title: Text("H O M E",style: TextStyle(color: Theme.of(context).primaryColor),),
            leading: Icon(Icons.home,color:Theme.of(context).errorColor ,),
            onTap: () {
              Navigator.popAndPushNamed(context,MainScreen.screenroute);
            },
          ),
          
          ListTile(
            title: Text("L O G O U T",style: TextStyle(color: Theme.of(context).primaryColor),),
            leading: Icon(Icons.logout,color:Theme.of(context).errorColor ,),
            onTap: () {
              _auth.signOut();
              Navigator.popAndPushNamed(context,welcomeScreen.screenroute);
            },
          ),
        ],
      ),

    );
  }
}