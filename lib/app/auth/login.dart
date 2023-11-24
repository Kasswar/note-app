import 'package:flutter/material.dart';
import 'package:note_app/components/customtextform.dart';
import 'package:note_app/constant/link_api.dart';
import 'package:note_app/main.dart';

import '../../components/crud.dart';
import '../../components/valid.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Crud _crud = Crud();
  bool isLoading = false;

  myLogin() async {
    if (formState.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await _crud.postRequest(linkLogin, {
        "email": email.text,
        "password": password.text,
      });
      isLoading = false;
      setState(() {});
      if (response["message"] == "success") {
        sharedPref!.setString("id", response["data"]["id"].toString());
        print("============================================");
        print(response['data']['id'].toString());
        Navigator.pushReplacementNamed(context!, "/home");
      } else {
        print("signup fail");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                  key: formState,
                  child: Column(children: [
                    const SizedBox(
                      height: 75,
                    ),
                    const Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 200,
                    ),
                    CustTextFormSign(
                      valid: (val) {
                        return validInput(val!, 10, 50);
                      },
                      hint: "Email",
                      myController: email,
                    ),
                    CustTextFormSign(
                      valid: (val) {
                        return validInput(val!, 4, 20);
                      },
                      hint: "Password",
                      myController: password,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        myLogin();
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    InkWell(
                      child: const Text("SignUp"),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/signup");
                      },
                    ),
                  ]),
                ),
              ),
      ),
    );
  }
}
