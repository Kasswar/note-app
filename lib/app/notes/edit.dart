import 'package:flutter/material.dart';
import 'package:note_app/components/crud.dart';
import 'package:note_app/constant/link_api.dart';

import '../../components/customtextform.dart';
import '../../components/valid.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';
class Edit extends StatefulWidget {
 final notes;
   Edit({required this.notes,Key? key}) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> with Crud{
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isLoading = false;
  File? myFile;

  editNote() async {
    if (formState.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response;
      if(myFile==null){
        response = await postRequest(linkEditNotes, {
          "title": title.text,
          "body": body.text,
          "note_id": widget.notes['id'].toString(),
          "image":widget.notes['image'].toString()
        });
      }else{
        response = await postRequestWithFile(
            linkEditNotes,
            {
              "title": title.text,
              "body": body.text,
              "note_id": widget.notes['id'].toString(),
              "image":widget.notes['image'].toString()
            },
            myFile!);
      }
      print("---------------------------------------------");
      print("${ widget.notes['id']}");
      print("${ widget.notes['image']}");
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
  void initState() {
    print(widget.notes);
    title.text=widget.notes['title'];
    body.text=widget.notes['body'];
    super.initState();
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
                      await editNote();
                    },
                    minWidth: double.infinity,
                    child: const Text(
                      "Save",
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
