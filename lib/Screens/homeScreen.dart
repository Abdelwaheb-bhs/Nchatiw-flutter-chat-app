import 'package:nchatiw_1/screens/registerScreen.dart';
import 'package:nchatiw_1/screens/signinScreen.dart';
import 'package:flutter/material.dart';
import 'package:nchatiw_1/Widgets/myButton.dart';
class welcomeScreen extends StatefulWidget {
  static const screenroute ='welcome-screen';
  const welcomeScreen({super.key});

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: ListView(
        children:[ Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[ 
            Container(
                        height: MediaQuery.of(context).size.height / 3.5,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Theme.of(context).canvasColor, Theme.of(context).canvasColor],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.elliptical(
                                    MediaQuery.of(context).size.width, 105.0)))
                                    ),
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
            children: [
             
                                    Center(
                          child: Text(
                          "Nchatiw",
                          style: TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                           ),
                           
                        ),
                        Container(
                child:Image.asset('images/image.png')
            )],
              ),
          ),
          SizedBox( height: 0 ),
        MyBotton(
          color: Theme.of(context).canvasColor,
          textColor:Color.fromARGB(255, 255, 255, 255) ,
          title: 'Sign in',
          onPressed: (){
            Navigator.pushNamed(context, signinscreen.screenroute);
          },
        ),
            SizedBox( height: 10 ),
      
        MyBotton(
          color: Color.fromARGB(255, 255, 255, 255),
          textColor:Color.fromARGB(255, 0, 0, 0) ,
          title: 'Register',
          onPressed: (){
                      Navigator.pushNamed(context,Registerscreen.screenroute);
      
          },
        ),]
          ),
      ]),
    );
  }
}

