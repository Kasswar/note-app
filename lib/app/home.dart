import 'package:flutter/material.dart';
import 'package:note_app/app/notes/edit.dart';
import 'package:note_app/components/card_note.dart';
import 'package:note_app/components/crud.dart';
import 'package:note_app/constant/link_api.dart';
import 'package:note_app/main.dart';
import 'package:note_app/model/note_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {
  getNotes() async {
    var response = await postRequest(linkViewNotes, {
      "user_id": sharedPref!.getString("id"),
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                sharedPref!.clear();
                Navigator.pushReplacementNamed(context, "/login");
              },
              icon: const Icon(Icons.exit_to_app))
        ],
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            FutureBuilder(
                future: getNotes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data['message'] == "fail") {
                      return const Center(
                        child: Text(
                          "لا يوجد بيانات",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data['data'].length,
                        itemBuilder: (BuildContext context, index) {
                          return CardNote(
                            noteModel: NoteModel.fromJson(snapshot.data['data'][index]),
                            ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Edit(
                                            notes: snapshot.data['data'][index])));
                              },
                            onDelete: ()async{
                               var response= await postRequest(linkDeleteNotes,{
                                  "note_id":snapshot.data['data'][index]['id'].toString(),
                                 "image":snapshot!.data['data'][index]['image'].toString(),
                                });
                               if(response["message"]=="success"){
                                 Navigator.pushReplacementNamed(context!,"/home");
                               }
                            },
                          );
                        },
                      );
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: Text("Loading..."),
                    );
                  } else {
                    return const Center(
                      child: Text("Loading..."),
                    );
                  }
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/add");
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }
}
