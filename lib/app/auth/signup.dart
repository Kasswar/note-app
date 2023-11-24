import 'package:flutter/material.dart';
import 'package:note_app/components/customtextform.dart';
import 'package:note_app/components/crud.dart';
import 'package:note_app/components/valid.dart';
import 'package:note_app/constant/link_api.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formState=GlobalKey();
  TextEditingController userName=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  bool isLoading=false;
  Crud _crud=Crud();
  mySignUp()async{
    print(formState.currentState!.validate());
    if(formState.currentState!.validate()){
      isLoading=true;
      setState(() {});
      var response=await _crud.postRequest(linkSignUp,{
        "username":userName.text,
        "email":email.text,
        "password":password.text,
      });
      isLoading=false;
      setState(() {});
      print("--------------------------------------------");
      print(response['message']);
      if(response['message']=="success"){
        print(response['message']);
        Navigator.pushReplacementNamed(context!,"/home");
      }else{
        print("signup fail");
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        child:isLoading?const Center(child: CircularProgressIndicator(),): SingleChildScrollView(
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
              CustTextFormSign(valid:(val){return validInput(val!, 2, 20);},hint: "User Name",myController: userName,),
              CustTextFormSign(valid:(val){return validInput(val!, 10, 50);},hint: "Email",myController: email,),
              CustTextFormSign(valid:(val){return validInput(val!, 4, 20);},hint: "Passworf",myController: password,),
              MaterialButton(
                onPressed: ()async {
                 await mySignUp();
                },
                child:Text(
                  "SignUp",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.black,
              ),
              const SizedBox(height: 45,),
              InkWell(child: const Text("Login"),onTap: (){
                Navigator.pushReplacementNamed(context,"/login");
              },),
            ]),
          ),
        ),
      ),
    );
  }
}
