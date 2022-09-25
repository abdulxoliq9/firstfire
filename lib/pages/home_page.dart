import 'package:firstfire/pages/signIn_page.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static final String id = 'home_page';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Fire'),
      ),
      body: Center(
        child: FlatButton(
          color: Colors.teal,
          onPressed: (){
            Navigator.pushReplacementNamed(context, SignIn.id);
          },
          child: Text('LogOut',style: TextStyle(
            color: Colors.white
          ),),
        ),
      ),
    );
  }
}
