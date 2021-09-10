import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:headlines/headlines/ui/home/headlines_page.dart';

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController;
  TextEditingController passwordController;
  
  bool _isLoading = true;
  
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
  
  void validateAndSubmit() async {
    setState(() { _isLoading = true;});
    if (validateAndSave()) {
      if (_isLoading) {
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: SimpleDialog(
                contentPadding: EdgeInsets.all(10),
                title: Center(child: Text('Loading...',)),
                children: <Widget>[
                  SizedBox(height: 5),
                  Center(child: CircularProgressIndicator()),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      'Checking credentials, please wait.',
                    ),
                  )
                ]
              )
            );
          }
        );
      }
      
      try {
        UserCredential user = await FirebaseAuth
          .instance.signInWithEmailAndPassword(
            email: emailController.text, 
            password: passwordController.text
        ).whenComplete(() {
          setState(() {
            _isLoading = false;
            formKey.currentState.reset();
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return UserHome();
              }
            )
          );
        });
      }
      catch(error) {
        print('Error: $error');
        showDialog(
          context: context, 
          builder: (context) {
            return AlertDialog(
              title: Text('Error!'),
              content: Text(
                'Login Failed with error: $error'
              )
            );
          }
        );
      }
    }
  }
  
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
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
              // decoration: BoxDecoration(
              //   color: Colors.blueAccent,
              //   // borderRadius: BorderRadius.vertical(
              //   //   bottom: Radius.circular(5)
              //   // )
              // ),
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
                height: 350,
                // decoration: BoxDecoration(
                //   color: Colors.blue,
                //   borderRadius: BorderRadius.all(Radius.circular(10))
                // ),
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
                        key: formKey,
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            TextFormField(
                              controller: emailController,
                              autovalidateMode: AutovalidateMode.always,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email_rounded),
                              ),
                              validator: (value) {
                                return value.isEmpty ? 'Email address is missing.' :
                                  null;
                              },
                              onSaved: (value) {
                                emailController.text = value;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: passwordController,
                              obscuringCharacter: '*',
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.vpn_key),
                              ),
                              validator: (value) {
                                return value.isEmpty ? 'Password is missing.' :
                                  null;
                              },
                              onSaved: (value) {
                                passwordController.text = value;
                              },
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              child: Text('Login', 
                              //   style: TextStyle(
                              //     // fontSize: 25,
                              //     // color: Colors.blue
                              //   )
                              // ),
                              // style: ButtonStyle(
                              //   // backgroundColor: MaterialStateProperty.all(
                              //   //   Colors.white
                              //   // ),
                              //   shape: MaterialStateProperty.all(
                              //     StadiumBorder(
                              //       side: BorderSide.none
                              //     )
                              //   ),
                              //   padding: MaterialStateProperty.all(
                              //     EdgeInsets.all(10)
                              //   )
                              ),
                              onPressed: validateAndSubmit,
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