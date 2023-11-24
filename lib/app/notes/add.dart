import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note_app/constant/link_api.dart';
import 'package:note_app/main.dart';

import '../../components/crud.dart';
import '../../components/customtextform.dart';
import '../../components/valid.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:image_picker/image_picker.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> with Crud {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isLoading = false;
  File? myFile;

  addNote() async {
    if (myFile == null) {
      return AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: "هام",
          body: const Text("الرجاء اختيار صورة من المعرض"))
        ..show();
    }
    if (formState.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await postRequestWithFile(
          linkAddNotes,
          {
            "title": title.text,
            "body": body.text,
            "user_id": sharedPref!.getString("id"),
          },
          myFile!);
      isLoading = false;
      setState(() {});
      if (response['message'] == "success") {
        Navigator.pushReplacementNamed(context!, "/home");
      } else {
        print(response['message']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
        backgroundColor: Colors.black,
        actions: [IconButton(onPressed:(){
          showModalBottomSheet(context: context, builder:(context){
            return Container(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.all(8),
                  child: Text("please show image",style: TextStyle(fontSize: 22),),),
                  InkWell(onTap: ()async{
                    XFile? xfile=await ImagePicker().pickImage(source: ImageSource.gallery);
                    Navigator.of(context!).pop();
                    myFile=File(xfile!.path);
                    setState(() {});
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding:const EdgeInsets.all(10),
                    child:const Text("from gallery"),
                  ),
                  ),
                  const SizedBox(height: 15,),
                  InkWell(onTap: ()async{
                    XFile? xfile=await ImagePicker().pickImage(source: ImageSource.camera);
                    Navigator.of(context!).pop();
                    myFile=File(xfile!.path);
                    setState(() {});
                  },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding:const EdgeInsets.all(10),
                      child:const Text("from camera"),
                    ),
                  ),

                ],
              ),
            );
          });
        }, icon: Icon(Icons.camera_alt,color: myFile==null?Colors.white:Colors.green,))],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Form(
                  key: formState,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustTextFormSign(
                          valid: (val) {
                            return validInput(val!, 2, 100);
                          },
                          hint: "Title",
                          myController: title,
                        ),
                        CustTextFormSign(
                          valid: (val) {
                            return validInput(val!, 2, 2000);
                          },
                          hint: "Body",
                          myController: body,
                        ),
                        MaterialButton(
                          onPressed: () async {
                            await addNote();
                          },
                          minWidth: double.infinity,
                          child: const Text(
                            "Add Note",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.black,
                        ),
                      ]),
                ),
              ),
            ),
    );
  }
}
