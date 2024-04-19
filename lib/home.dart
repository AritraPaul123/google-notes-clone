import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:googlenotes/colors.dart';
import 'package:googlenotes/SideMenu.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:googlenotes/createnote.dart';
import 'package:googlenotes/services/db.dart';
import 'package:googlenotes/noteview.dart';
import 'package:googlenotes/searchnotespage.dart';
import 'package:googlenotes/model/NoteModel.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int counter=0;
  late List<Note> notesListfinal=[];
  late List<Note> notesList=[];
  late Note onenotevalue;
  bool isStaggered= true;

  GlobalKey<ScaffoldState> _drawerkey = GlobalKey();
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    // createEntry(Note(pin: false, title: "Aritra Paul", content: "I Am Aritra Paul"));
    allnotes();
  }

  // Future Entry(Note note) async{
  //   await NotesDatabse.instance.InsertEntry(note);
  // }
  Future allnotes() async{
    this.notesList= await NotesDatabse.instance.readAllNotes();
    notesList.forEach((element) {
      setState(() {
        notesListfinal.add(element);
      });
    });
  }
  Future onenotes(int id) async{
    this.onenotevalue=(await NotesDatabse.instance.readOneNote(id))!;
    print(onenotevalue.title);
  }
  Future updatenotes(Note note) async{
    await NotesDatabse.instance.updateNote(note);
  }
  // Future deletenotes(Note note) async{
  //   await NotesDatabse.instance.delteNote(note);
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNote()));
        },
        backgroundColor: cardColor,
        foregroundColor: white.withOpacity(0.8),
        child: Icon(Icons.add,size: 45,),
      ),
      endDrawerEnableOpenDragGesture: true,
      key: _drawerkey,
      drawer: SideMenuBar(value: 1,notesList: notesListfinal,),
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: cardColor,
                      boxShadow: [
                        BoxShadow(
                            color: black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 3)
                      ]),
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                _drawerkey.currentState?.openDrawer();
                              },
                              style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                    (states) => white.withOpacity(0.1),
                                  ),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)))),
                              child: Icon(
                                Icons.menu,
                                color: white,
                              )),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchNotesView()));
                            },
                            child: Container(
                              height: 55,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Search Your Notes",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: white.withOpacity(0.5)),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    overlayColor: MaterialStateColor.resolveWith(
                                      (states) => white.withOpacity(0.1),
                                    ),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)))),
                                child: IconButton(
                                  icon: Icon(Icons.grid_view),
                                  color: white, onPressed: () {
                                    setState(() {
                                      isStaggered=!isStaggered;
                                    });
                                },
                                )),
                            SizedBox(
                              width: 9,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 16,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            isStaggered? SectionAll(): SectionNotesList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget SectionAll(){
    return     Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            children: [
              Text(
                "ALL",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: white.withOpacity(0.5)),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
          child: MasonryGridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: notesListfinal.length,
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) => InkWell(
                onTap: (){
                  print(notesListfinal[index].pin);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteView(note: notesListfinal[index],)));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: index.isEven? Colors.green[900]: Colors.blue[900],
                      border: Border.all(color: index.isEven? Colors.green.withOpacity(0.4): Colors.blue.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notesListfinal[index].title,
                        style: TextStyle(
                            color: white.withOpacity(0.9),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(notesListfinal[index].content.length > 200 ? "${notesListfinal[index].content.substring(0,200)}..." : notesListfinal[index].content ,style: TextStyle(color: white.withOpacity(0.7)),),
                    ],
                  ),
                ),
              )
          ),
        )
      ],
    );
  }
  Widget SectionNotesList(){
    return     Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            children: [
              Text(
                "ALL  ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: white.withOpacity(0.5)),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: notesListfinal.length,
              itemBuilder: (context, index) => InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteView(note: notesListfinal[index])));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: index.isEven? Colors.green[900]: Colors.blue[900],
                      border: Border.all(color: index.isEven? Colors.green.withOpacity(0.4): Colors.blue.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notesListfinal[index].title,
                        style: TextStyle(
                            color: white.withOpacity(0.9),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(notesListfinal[index].content.length > 200  ? "${notesListfinal[index].content.substring(0,200)}..." : notesListfinal[index].content ,style: TextStyle(color: white.withOpacity(0.7)),),
                    ],
                  ),
                ),
              )
          ),
        )
      ],
    );
  }
}
