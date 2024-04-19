import 'package:flutter/material.dart';
import 'package:googlenotes/colors.dart';
import 'package:googlenotes/editnote.dart';
import 'package:googlenotes/services/db.dart';
import 'home.dart';
import 'model/NoteModel.dart';

class NoteView extends StatefulWidget {
  Note? note;
  NoteView({required this.note});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white.withOpacity(0.8)),
        leading: BackButton(
          onPressed: (){
            Navigator.pop(context);
          },
        ) ,
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: [
          IconButton(onPressed: () async {
                await NotesDatabse.instance.pinNote(widget.note);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
          },splashRadius: 20, icon: widget.note!.pin? Icon(Icons.push_pin):Icon(Icons.push_pin_outlined) ),
          IconButton(onPressed: () async{
            await NotesDatabse.instance.archiveNote(widget.note);
            Navigator.pop(context);
          },splashRadius: 20, icon: widget.note!.isArchived? Icon(Icons.archive) : Icon(Icons.archive_outlined)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> EditNote(note: widget.note)));
          },splashRadius: 20, icon: Icon(Icons.edit_outlined)),
          IconButton(onPressed: () async {
            showDialog(context: context, builder: (context)=>AlertDialog(
              backgroundColor: Colors.white12,
              title: const Text("Delete Notes"),
              content: const Text("Delete this note?"),
              actions: [
                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text("CANCEL",style: TextStyle(color: white.withOpacity(0.7)),)),
                TextButton(onPressed: () async {
                  await NotesDatabse.instance.delteNote(widget.note);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                }, child:
                Text("DELETE",style: TextStyle(color: Colors.red),)
                )
              ],
            ));
          },splashRadius: 20, icon: Icon(Icons.delete_forever_outlined)),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: bgColor,
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.note!.title,style: TextStyle(fontWeight: FontWeight.bold,color: white.withOpacity(0.9),fontSize: 23),),
              SizedBox(height: 10,),
              Text(widget.note!.content,style: TextStyle(color: white,fontSize: 17),)
            ],
          ),
        ),
      ),
    );
  }
}
