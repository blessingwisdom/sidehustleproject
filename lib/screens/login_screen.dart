// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sidehustle/screens/home_screen.dart';
import 'package:sidehustle/screens/register_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //form Key
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  void _submit() async {
    final valid = _formKey.currentState?.validate() ?? false;
    if (valid) {
      try {
        final userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        final user = userCredential.user;
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        } else {}
      } catch (e) {
        if (e is FirebaseAuthException) {
          if (e.code == 'user-not-found') {
            print('user not found');
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
      },
      onSaved: (value) {
        if (value != null) {
          emailController.text = value;
        }
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.mail,
          color: Colors.white54,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "email Address",
        hintStyle: TextStyle(color: Colors.white38),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white54),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue.shade300,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: _submit,
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xff29487D),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 55.0,
                      backgroundImage: AssetImage("images/logo.jpg"),
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    emailField,
                    SizedBox(
                      height: 25.0,
                    ),
                    passwordField,
                    SizedBox(
                      height: 25.0,
                    ),
                    loginButton,
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegistrationScreen()));
                          },
                          child: Text(
                            "SignUp",
                            style: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
