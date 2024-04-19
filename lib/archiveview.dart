import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:googlenotes/colors.dart';
import 'package:googlenotes/SideMenu.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:googlenotes/createnote.dart';
import 'package:googlenotes/noteview.dart';
import 'package:googlenotes/searchnotespage.dart';
import 'home.dart';
import 'model/NoteModel.dart';

class ArchiveView extends StatefulWidget {
  late List<Note> notesList;
 ArchiveView({required this.notesList});

  @override
  State<ArchiveView> createState() => _ArchiveViewState();
}

class _ArchiveViewState extends State<ArchiveView> {
  bool isStaggered=true;
  List<Widget> Gridviewlist = [];
  GlobalKey<ScaffoldState> _drawerkey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
      drawer: SideMenuBar(value: 2,notesList: widget.notesList,),
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
                                  color: white,
                                  onPressed: (){
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
              itemCount: widget.notesList.length,
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) => widget.notesList[index].isArchived? InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteView(note: widget.notesList[index],)));
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
                        widget.notesList[index].title,
                        style: TextStyle(
                            color: white.withOpacity(0.9),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text((widget.notesList[index].content.length > 200) ? "${widget.notesList[index].content.substring(0,200)}..." : widget.notesList[index].content ,style: TextStyle(color: white.withOpacity(0.7)),),
                    ],
                  ),
                ),
              ): SizedBox(width: 0,height: 0,),
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
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.notesList.length,
              itemBuilder: (context, index) => InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteView(note: widget.notesList[index],)));
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
                        widget.notesList[index].title,
                        style: TextStyle(
                            color: white.withOpacity(0.9),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(widget.notesList[index].content.length > 200 ? "${widget.notesList[index].content.substring(0,200)}..." : widget.notesList[index].content ,style: TextStyle(color: white.withOpacity(0.7)),),
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
