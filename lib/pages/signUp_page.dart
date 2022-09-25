import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstfire/pages/signIn_page.dart';
import 'package:firstfire/services/auth_service.dart';
import 'package:firstfire/services/prefs.dart';
import 'package:firstfire/services/utils.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static final String id = 'signUp_page';
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var isloading = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fullnameController = TextEditingController();



  doSignUp(){
    String email = emailController.text.toString().trim();
    String name = fullnameController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    setState(() {
      isloading = true;
    });
    AuthService.signUpUser(context, name, email, password).then((firebaseUser) => {
      getFire(firebaseUser)
    });
  }

  getFire(User firebaseUser)async{
    setState(() {
      isloading = false;
    });
    if(firebaseUser != null){
     await Prefs.saveUserId(firebaseUser.uid);
     Navigator.pushReplacementNamed(context, HomePage.id);
    }else{
      Utils.fireToast('Check your informations');
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
                controller: fullnameController,
                decoration: InputDecoration(
                  hintText: 'Full Name',
                ),
              ),SizedBox(height: 10,),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
              ),SizedBox(height: 10,),
              TextField(controller: passwordController,
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
                    doSignUp();
                  },
                  child: Text('Sign Up',style:
                  TextStyle(color: Colors.white),),
                ),
              ),SizedBox(height: 15,),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, SignIn.id);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Already have an account ?'),
                      SizedBox(width: 5,),
                      Text('SIGN IN',style: TextStyle(
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
