import 'package:flutter/material.dart';
import 'package:note_app/app/auth/signup.dart';
import 'package:note_app/app/home.dart';
import 'package:note_app/app/notes/add.dart';
import 'package:note_app/app/notes/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/auth/login.dart';

SharedPreferences? sharedPref;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref=await SharedPreferences.getInstance();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  String? myId=sharedPref!.getString("id");
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'note app',
      debugShowCheckedModeBanner: false,
      initialRoute:myId==null?"/login":"/home",
      routes: {
        "/login":(context) =>const Login(),
        "/signup":(context) =>const SignUp(),
        "/home":(context) => const Home(),
        "/add":(context) => const AddNote(),
        "/edit":(context) => Edit(notes: {},),
      },
    );
  }
}

