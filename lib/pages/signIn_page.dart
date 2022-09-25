import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstfire/pages/home_page.dart';
import 'package:firstfire/pages/signUp_page.dart';
import 'package:firstfire/services/auth_service.dart';
import 'package:firstfire/services/prefs.dart';
import 'package:flutter/material.dart';

import '../services/utils.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static final String id = 'signIn_page';
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var isloading = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  doSignIn(){
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    isloading = true;
    //if(email.isEmpty || password.isEmpty)return
    AuthService.signInUser(context, email, password).then((firebaseUser) => {
      getFire(firebaseUser),
    });

  }

  getFire(User firebaseUser)async {
    isloading = false;
    if(firebaseUser != null){
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    }else{
      Utils.fireToast('Check your email or password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
              ),SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Password'
                ),
              ),
              SizedBox(height: 25,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: FlatButton(
                  color: Colors.teal,
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, HomePage.id);
                    doSignIn();
                  },
                  child: Text('Sign In',style:
                    TextStyle(color: Colors.white),),
                ),
              ),SizedBox(height: 15,),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, SignUp.id);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Don`t have an account ?'),
                      SizedBox(width: 5,),
                      Text('SIGN UP',style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
