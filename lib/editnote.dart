import 'package:flutter/material.dart';
import 'package:googlenotes/colors.dart';
import 'package:googlenotes/noteview.dart';
import 'package:googlenotes/services/db.dart';
import 'model/NoteModel.dart';

class EditNote extends StatefulWidget {
  Note? note;
  EditNote({required this.note});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late String NewTitle;
  late String NewContent;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.NewTitle=widget.note!.title.toString();
    this.NewContent=widget.note!.content.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: white.withOpacity(0.8)),
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () async {
              Note newNote=Note(id: widget.note!.id ,pin: false,isArchived: false, title: NewTitle, content: NewContent);
              await NotesDatabse.instance.updateNote(newNote);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NoteView(note: newNote)));
            },
            icon: Icon(Icons.save_outlined),
            splashRadius: 20,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Form(
                child: TextFormField(
                  onChanged: (value){
                    NewTitle=value;
                  },
              initialValue: NewTitle,
                style: TextStyle(
                  fontSize: 20,
                  color: white,
                  fontWeight: FontWeight.bold,
                ),
                cursorColor: white,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Title",
                    hintStyle:
                    TextStyle(fontSize: 23, color: white.withOpacity(0.7))),

            )),

            Container(
              color: bgColor,
              height: 300,
              child:
              Form(child:
              TextFormField(
                onChanged: (value){
                  NewContent=value;
                },
                initialValue: NewContent,
                maxLines: null,
                minLines: 50,
                keyboardType: TextInputType.multiline,
                style: TextStyle(fontSize: 18, color: white),
                cursorColor: white,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Note",
                    hintStyle:
                    TextStyle(fontSize: 19, color: white.withOpacity(0.7))),
              ),
                ),

            )
          ],
        ),
      ),
    );
  }
}
