import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:headlines/headlines/ui/home/headlines_page.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController;
  TextEditingController passwordController;
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }
  
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
                title: Text('Loading...'),
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                  Text(
                    'Checking credentials, please wait.'
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
                      'Welcome,',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    Text(
                      'Please fill in the form to get started.',
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
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      Divider(thickness: 1, height: 30,),
                      
                      Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: emailController,
                              autovalidateMode: AutovalidateMode.always,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email_rounded),
                              ),
                              validator: (value) {
                                return value.isEmpty ? 'Email is missing.' : 
                                  null;
                              },
                              onSaved: (value) {
                                emailController.text = value;
                              }
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
                                return value.isEmpty ? 'Password is missing.':
                                  null;
                              },
                              onSaved: (value) {
                                passwordController.text = value;
                              }
                            ),
                          ],
                        ),
                      ),
                              
                      // SignUp, SignIn button section
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ElevatedButton(
                              child: Text('Sign Up'),
                              // style: ButtonStyle(
                              //   // backgroundColor: MaterialStateProperty.all(
                              //   //   Colors.greenAccent
                              //   // ),
                              //   shape: MaterialStateProperty.all(
                              //     StadiumBorder(
                              //       side: BorderSide.none
                              //     )
                              //   )
                              // ),
                              onPressed: validateAndSubmit,
                            ),
                          ]
                        )
                      )
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
