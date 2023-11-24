import 'package:flutter/material.dart';
import 'package:note_app/constant/link_api.dart';

import '../model/note_model.dart';

class CardNote extends StatelessWidget {
  void Function()? ontap;
  void Function()? onDelete;
  final NoteModel noteModel;
   CardNote({required this.noteModel,required this.ontap,required this.onDelete,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        elevation: 25,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Image.network(
                  "$linkImageRoot/${noteModel.image}",
                  fit: BoxFit.fill,
                  width: 100,
                  height: 100,
                )),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text("${noteModel.title}"),
                  subtitle: Text("${noteModel.body}"),
                  trailing: IconButton(
                    onPressed: onDelete,
                    icon:const Icon(Icons.delete),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
