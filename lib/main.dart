import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'headlines/ui/authenticate/authenticate.dart';
import 'headlines/ui/themes/ui_theme.dart';
// import 'headlines/ui/home/headlines_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: mainTheme,
      home: Authentication(),
    );
  }
}
