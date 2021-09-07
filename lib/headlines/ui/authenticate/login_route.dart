import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  
  TextEditingController emailController;
  TextEditingController passwordController;
  
  void validateAndSave() {
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                // borderRadius: BorderRadius.vertical(
                //   bottom: Radius.circular(5)
                // )
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    Text(
                      'Please fill in login credentials.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      )
                    )
                  ]
                ),
              )
            ),
            SizedBox(height: 10),
            // Input Fields section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      Divider(thickness: 1, height: 30,),
                      
                      Form(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email_rounded),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ),
                              validator: (value) {
                                return value.isEmpty ? 'Email address is missing.' :
                                  null;
                              }
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: passwordController,
                              obscuringCharacter: '*',
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.vpn_key),
                                focusColor: Colors.black,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ),
                              validator: (value) {
                                return value.isEmpty ? 'Password is missing.' :
                                  null;
                              }
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              child: Text('Login', 
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.blue
                                )
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.white
                                ),
                                shape: MaterialStateProperty.all(
                                  StadiumBorder(
                                    side: BorderSide.none
                                  )
                                ),
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.all(10)
                                )
                              ),
                              onPressed: validateAndSave,
                            ),
                          ],
                        ),
                      ),
                    ]
                  ),
                )
              )
            ),
          ]
        )
      ),
    );
  }
}